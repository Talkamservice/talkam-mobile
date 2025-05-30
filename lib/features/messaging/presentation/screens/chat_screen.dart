import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/dormain/mixins/refresh_conversations_mixin.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/blocs/messaging/messaging_cubit.dart';
import 'package:talkam/features/messaging/presentation/widgets/chat_screen_actions.dart';
import 'package:talkam/features/messaging/presentation/widgets/conversation_actions_widget.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/message_box.dart';
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

class _ChatScreenState extends State<ChatScreen> with RefreshConversationsMixin {
  final messagingCubit = MessagingCubit(injector.get());

  final controller = TextEditingController();

  File? pickedFile;

  @override
  void initState() {
    messagingCubit.init(receiverId: widget.param.user.id.toString());
    super.initState();
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
            ImageWidget(
              width: 32,
              height: 32,
              shape: BoxShape.circle,
              imageUrl: widget.param.user.avatar.toString(),
            ),
            11.horizontalSpace,
            TextView(
              text: widget.param.user.username,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        centerTile: false,
        showDivider: true,
        actions: [
          IconButton(
              onPressed: () async {
                var refresh = await CustomDialogs.showBottomSheet(
                    context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    ChatScreenActions(
                      conversation: messagingCubit.currentConversation!,
                    ));

                if (refresh ?? false) {
                  messagingCubit.fetchCurrentConversation(widget.param.user.id.toString(), refresh: false);
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
            sendMessageFailure: (error) {},
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
                messagingCubit.fetchCurrentConversation(widget.param.user.id.toString());
              } else {
                context.pop();
              }
            },
            getMessagesSuccess: (response) {
              refreshAllConversations();
            },
            sendMessageSuccess: (response) {
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
                    orElse: () {
                      if (messagingCubit.messages.isEmpty) {
                        return const Center(
                          child: EmptyState(title: "No chats in this conversation yet", subtitle: "Chats would appear here when you have them"),
                        );
                      }
                      return ListView.builder(
                        controller: messagingCubit.listController,
                        reverse: true,
                        itemCount: messagingCubit.messages.length,
                        itemBuilder: (context, index) => ChatMessageBox(
                          message: messagingCubit.messages[index],
                          onRetryMessage: () {
                            messagingCubit.retryMessage(messagingCubit.messages[index]);
                          },
                        ),
                      );
                    },
                    fetchCurrentConversationLoading: () {
                      return Center(
                        child: CustomDialogs.getLoading(size: 50),
                      );
                    },
                  );

                  // return ;
                }),
              ),
              ConversationActionsWidget(
                user: widget.param.user,
                onAccept: () {
                  messagingCubit.updateConversationStatus(conversationId: messagingCubit.currentConversation!.id.toString(), status: "Accepted");
                },
                onReject: () {
                  messagingCubit.updateConversationStatus(conversationId: messagingCubit.currentConversation!.id.toString(), status: "Declined");
                },
                onSendMessage: (message, {file}) {
                  sendMessage(message: message.trim(), file: file);
                },
                currentConversation: messagingCubit.currentConversation,
                isPendingRequest: isAPendingRequest,
              ),
            ],
          );
        },
      ),
    );
  }

  bool get conversationIsNotYetFetched => messagingCubit.currentConversation == null;

  bool get isAPendingRequest {
    return messagingCubit.currentConversation?.status == "Awaiting_Response" &&
        (!SessionManager().isMe(messagingCubit.currentConversation!.requestedBy.id.toString()));
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
    var image = await ImageManager()
        .fetchFiles(fileType: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'pdf', 'doc', 'docx'], checkSize: false);
    if (image.isNotEmpty) {
      pickedFile = File(image.first);
      setState(() {});
    }
  }
}
