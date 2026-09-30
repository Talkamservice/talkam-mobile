import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/common/widgets/typing_animation.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/dormain/mixins/refresh_conversations_mixin.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/blocs/messaging/messaging_cubit.dart';
import 'package:talkam/features/messaging/presentation/widgets/chat_loading_shimmer.dart';
import 'package:talkam/features/messaging/presentation/widgets/chat_screen_actions.dart';
import 'package:talkam/features/messaging/presentation/widgets/conversation_actions_widget.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/message_box.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:uuid/uuid.dart';

class ChatScreenParam {
  final TalkamConversation? conversation;
  final ConversationUser user;

  ChatScreenParam({this.conversation, required this.user});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.param});

  final ChatScreenParam param;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with RefreshConversationsMixin {
  final messagingCubit = MessagingCubit(injector.get());

  final controller = TextEditingController();

  File? pickedFile;

  @override
  void initState() {
    messagingCubit.init(
      conversation: widget.param.conversation,
      receiverId: widget.param.user.id.toString(),
    );
    // The list is built with `reverse: true` (see _buildMessagesList) so
    // the newest message is anchored at scroll offset 0 with no manual
    // jump-to-bottom needed. That flips which end is "near 0": older
    // messages (start of the ascending-sorted array) now sit near
    // maxScrollExtent — load the next page once the user scrolls there.
    messagingCubit.listController.addListener(() {
      final position = messagingCubit.listController.position;
      if (position.pixels >= position.maxScrollExtent - 100) {
        messagingCubit.loadMoreMessages();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    messagingCubit.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String messageTime = "12:34 PM";
    return Scaffold(
      appBar: CustomAppBar(
        // padding: const EdgeInsets.only(top: 13),
        leadingWidth: 25,
        tittle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ImageWidget(
                  width: 32,
                  height: 32,
                  shape: BoxShape.circle,
                  imageUrl:
                      widget.param.user.avatar ?? Assets.images.svgs.dummyUser,
                ),
                // Presence UI — event name/payload are an unverified guess
                // (see MessagingCubit._subscribeToPresence), so this dot
                // simply never lights up until that's confirmed.
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: messagingCubit.isOtherUserOnlineNotifier,
                    builder: (context, isOnline, _) {
                      if (!isOnline) return const SizedBox.shrink();
                      return Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallets.successGreen,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            11.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextView(
                  text: widget.param.user.username,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                // Typing UI — same caveat: `typing` event name/shape are
                // unverified, so this just never appears until confirmed.
                ValueListenableBuilder<bool>(
                  valueListenable: messagingCubit.isOtherUserTypingNotifier,
                  builder: (context, isTyping, _) {
                    if (!isTyping) return const SizedBox.shrink();
                    return const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: TypingDotAnimation(
                        color: Color(0xFF888888),
                        dotSize: 4,
                        spacing: 2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        centerTile: false,
        actions: [
          IconButton(
              onPressed: () async {
                var refresh = await CustomDialogs.showBottomSheet(
                    context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    ChatScreenActions(
                      conversation: messagingCubit.currentConversation!,
                      onBulkMarkRead: messagingCubit.bulkMarkRead,
                    ));

                if (refresh ?? false) {
                  // `refresh: true` here means "actually hit the network,
                  // don't just show whatever's cached" — this is the one
                  // place that needs it: something changed (block/report)
                  // and the local cache is now stale.
                  messagingCubit.fetchCurrentConversation(
                      widget.param.user.id.toString(),
                      refresh: true);
                }
              },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: BlocConsumer<MessagingCubit, MessagingState>(
        bloc: messagingCubit,
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            sendMessageFailure: (error) => CustomDialogs.error(error),
            updateConversationStatusLoading: () {
              CustomDialogs.showLoading(context);
            },
            updateConversationStatusFailure: (error) {
              context.pop();
              CustomDialogs.error(error);
            },
            updateConversationStatusSuccess: (response) {
              context.pop();
              refreshAllConversations();
              if (response.status == "Accepted") {
                messagingCubit
                    .fetchCurrentConversation(widget.param.user.id.toString());
              } else {
                context.pop();
              }
            },
            sendMessageSuccess: (response) {
              // patchConversationPreview is called from inside
              // MessagingCubit.sendMessage/retryMessage now, not here — this
              // listener only fires if the cubit is still open and this
              // screen is still mounted when the response lands, which
              // isn't guaranteed if the user already navigated away.
              refreshAllConversations();
            },
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  return state.maybeWhen(
                    fetchCurrentConversationFailure: (error) {
                      return AppErrorWidget(
                        message: error,
                        onTap: () => messagingCubit.init(
                          conversation: widget.param.conversation,
                          receiverId: widget.param.user.id.toString(),
                        ),
                      );
                    },
                    getMessagesFailure: (error) {
                      return AppErrorWidget(
                        message: error,
                        onTap: () => messagingCubit.init(
                          conversation: widget.param.conversation,
                          receiverId: widget.param.user.id.toString(),
                        ),
                      );
                    },
                    // A confirmed fetch that genuinely has zero messages —
                    // the only case that should show the empty state.
                    getMessagesSuccess: (_) {
                      if (messagingCubit.messages.isEmpty) {
                        return const Center(
                          child: EmptyState(
                              title: "No chats in this conversation yet",
                              subtitle:
                                  "Chats would appear here when you have them"),
                        );
                      }
                      return _buildMessagesList();
                    },
                    // Every other state — loading, the not-yet-resolved
                    // `initial` state, etc. — shows existing messages if we
                    // have them, otherwise a spinner. Never the empty state:
                    // we haven't heard back from a real fetch yet.
                    orElse: () {
                      if (messagingCubit.messages.isNotEmpty) {
                        return _buildMessagesList();
                      }
                      return const ChatLoadingShimmer();
                    },
                  );
                }),
              ),
              ConversationActionsWidget(
                user: widget.param.user,
                onAccept: () {
                  messagingCubit.updateConversationStatus(
                      conversationId:
                          messagingCubit.currentConversation!.id.toString(),
                      status: "Accepted");
                },
                onReject: () {
                  messagingCubit.updateConversationStatus(
                      conversationId:
                          messagingCubit.currentConversation!.id.toString(),
                      status: "Declined");
                },
                onSendMessage: (message, {file}) {
                  sendMessage(message: message.trim(), file: file);
                },
                currentConversation: messagingCubit.currentConversation,
                isPendingRequest: isAPendingRequest,
                onTyping: messagingCubit.notifyTyping,
              ),
            ],
          );
        },
      ),
    );
  }

  // `reverse: true` anchors the newest message at scroll offset 0, so the
  // list opens already positioned at the bottom with no manual jump —
  // eliminating the old "flash of the top, then skip to the newest
  // message" glitch that came from jumping there only after the first
  // (top-anchored) layout had already painted. The index is mapped
  // backwards so the visual top-to-bottom order (oldest → newest) matches
  // `messagingCubit.messages`'s own ascending order unchanged.
  Widget _buildMessagesList() {
    return ListView.builder(
      reverse: true,
      controller: messagingCubit.listController,
      itemCount: messagingCubit.messages.length,
      itemBuilder: (context, index) {
        final message = messagingCubit
            .messages[messagingCubit.messages.length - 1 - index];
        return ChatMessageBox(
          message: message,
          messagingCubit: messagingCubit,
          onRetryMessage: () {
            messagingCubit.retryMessage(message);
          },
        );
      },
    );
  }

  bool get conversationIsNotYetFetched =>
      messagingCubit.currentConversation == null;

  bool get isAPendingRequest {
    return messagingCubit.currentConversation?.status == "Awaiting_Response" &&
        (!SessionManager().isMe(
            messagingCubit.currentConversation!.requestedBy?.id.toString() ??
                ''));
  }

  void sendMessage({String? message, String? file}) async {
    logger.w(file);
    if ((message != null && message.isNotEmpty) || file != null) {
      messagingCubit.sendMessage(AppMessageModel(
          content: message,
          iAmSender: true,
          assetUrl: file,
          id: const Uuid().v4(),
          time: DateTime.now(),
          sendingState: SendingState.loading,
          receiverId: widget.param.user.id.toString(),
          messageType: messageType(file),
          conversationId: messagingCubit.currentConversation!.id.toString()));
      pickedFile = null;
      setState(() {});
    }
  }

  String messageType(String? file) {
    return Helpers.pathIsImage(file ?? '')
        ? "Media"
        : Helpers.pathIsDocument(file ?? '')
            ? "File"
            : "Text";
  }

  void sendImage() async {
    var image = await ImageManager().fetchFiles(
        fileType: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'gif',
          'bmp',
          'webp',
          'pdf',
          'doc',
          'docx'
        ],
        checkSize: false);
    if (image.isNotEmpty) {
      pickedFile = File(image.first);
      setState(() {});
    }
  }
}
