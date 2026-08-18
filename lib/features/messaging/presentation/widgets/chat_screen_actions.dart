import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/block_reason_sheet.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/dormain/mixins/refresh_conversations_mixin.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class ChatScreenActions extends StatefulWidget {
  const ChatScreenActions({super.key, required this.conversation});

  final TalkamConversation conversation;

  @override
  State<ChatScreenActions> createState() => _ChatScreenActionsState();
}

class _ChatScreenActionsState extends State<ChatScreenActions>
    with RefreshPostsMixin, RefreshConversationsMixin {
  final profileBloc = ProfileBloc(injector.get());
  final conversationsBloc = ConversationsCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConversationsCubit, ConversationsState>(
            bloc: conversationsBloc,
            listener: (context, state) {
              state.maybeWhen(
                orElse: () => null,
                deleteConversationByIdFailure: (error) {
                  context.pop();
                  CustomDialogs.error(error);
                },
                deleteConversationByIdSuccess: () {
                  refreshPost(reload: false);
                  refreshAllConversations();
                  context.pop();
                  context.pop();
                  context.pop();
                  context.pop();
                  CustomDialogs.success("Conversation deleted");
                },
                deleteConversationByIdLoading: () {
                  CustomDialogs.showLoading(context);
                },
                updateConversationByIdFailure: (error) {
                  context.pop();
                  CustomDialogs.error(error);
                },
                updateConversationByIdSuccess: (res) {
                  refreshPost(reload: false);
                  refreshAllConversations();
                  context.pop();
                  context.pop(true);
                  CustomDialogs.success("Updated");
                },
                updateConversationByIdLoading: () {
                  CustomDialogs.showLoading(context);
                },
              );
            }),
        BlocListener<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          listener: (context, state) {
            if (state is BlockUserLoadingState) {
              CustomDialogs.showLoading(context);
            }

            if (state is BlockUserFailureState) {
              context.pop();
              CustomDialogs.error(state.error);
            }
            if (state is BlockUserSuccessState) {
              refreshPost(reload: false);
              refreshAllConversations();
              context.pop();
              context.pop(true);
              if (state.response.data.isBlocked) {
                CustomDialogs.success("User Blocked");
              } else {
                CustomDialogs.success("User UnBlocked");
              }
            }
          },
        )
      ],
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFFF),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionRow(
              icon: Icons.person_outline,
              text: 'View Profile',
              onTap: () {
                GuestUserHelper.handleGuestUserAction(
                  action: () {
                    if (SessionManager()
                        .isMe(widget.conversation.otherUser.id.toString())) {
                      context.pushNamed(PageUrl.profileScreen,
                          extra: widget.conversation.otherUser.id.toString());
                    } else {
                      context.pushNamed(PageUrl.userProfileScreen,
                          extra: widget.conversation.otherUser.id.toString());
                    }
                  },
                );
              },
            ),
            Container(
              width: double.infinity,
              child: const Divider(
                thickness: 1,
              ),
            ),
            _buildOptionRow(
              icon: widget.conversation.notificationStatus
                  ? Icons.notifications_none_outlined
                  : Icons.notifications_off_outlined,
              text: widget.conversation.notificationStatus
                  ? 'Mute notifications'
                  : "Unmute notifications",
              onTap: () {
                conversationsBloc.updateConversationById(
                    widget.conversation.id.toString(),
                    !widget.conversation.notificationStatus);
              },
            ),
            const SizedBox(
              width: double.infinity,
              child: Divider(
                thickness: 1,
              ),
            ),
            _buildOptionRow(
              icon: Icons.delete_outline_outlined,
              text: 'Delete chat',
              onTap: () {
                CustomDialogs.showConfirmDialog(context,
                    message: "All messages and files in this chat will be lost",
                    tittle: "Are you sure you want to delete?",
                    confirmText: "Delete", onYes: () {
                  conversationsBloc.deleteConversationById(
                      widget.conversation.id.toString());
                }, onCancel: () {
                  context.pop();
                }, confirmButtonBgColor: Pallets.red);
              },
            ),
            const SizedBox(
              width: double.infinity,
              child: Divider(
                thickness: 1,
              ),
            ),
            _buildOptionRow(
              icon: Icons.block_outlined,
              text: widget.conversation.userBlocked
                  ? 'UnBlock ${widget.conversation.otherUser.username}'
                  : 'Block ${widget.conversation.otherUser.username}',
              onTap: () {
                blockUser(context);
              },
            ),

            // const SizedBox(
            //   width: double.infinity,
            //   child: Divider(
            //     thickness: 1,
            //   ),
            // ),
            // _buildOptionRow(
            //   icon: Icons.flag_outlined,
            //   text: 'Report',
            //   onTap: () {},
            // ),
            const SizedBox(
              width: double.infinity,
              child: Divider(
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void blockUser(BuildContext context) async {
    if (!widget.conversation.userBlocked) {
      CustomDialogs.showConfirmDialog(
        context,
        confirmButtonBgColor: Pallets.red,
        message:
            "Are you sure you want to block ${widget.conversation.otherUser.username}",
        onCancel: () {
          context.pop();
        },
        onYes: () {
          context.pop();

          profileBloc
              .add(BlockUerEvent(widget.conversation.otherUser.id.toString()));
        },
      );
    } else {
      CustomDialogs.showConfirmDialog(
        context,
        confirmButtonBgColor: Pallets.primary,
        message:
            "Are you sure you want to unblock ${widget.conversation.otherUser.username}",
        onCancel: () {
          context.pop();
        },
        onYes: () {
          context.pop();

          profileBloc
              .add(BlockUerEvent(widget.conversation.otherUser.id.toString()));
        },
      );
    }
  }
}

Widget _buildOptionRow(
    {required IconData icon,
    required String text,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: const Color(0xff212121),
          ),
          const SizedBox(width: 16),
          TextView(
            color: const Color(0xff212121),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            text: text,
          ),
        ],
      ),
    ),
  );
}
