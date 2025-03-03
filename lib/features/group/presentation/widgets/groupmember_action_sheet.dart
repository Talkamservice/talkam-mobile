import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/block_reason_sheet.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/group/presentation/widgets/suspension_reason_sheet.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupmemberActionSheet extends StatefulWidget {
  const GroupmemberActionSheet({super.key, required this.currentUserIsAdmin, required this.member, required this.group, required this.onActionSuccess});

  final bool currentUserIsAdmin;
  final TalkamGroup group;
  final GroupMemberDetails member;
  final VoidCallback onActionSuccess;

  @override
  State<GroupmemberActionSheet> createState() => _GroupmemberActionSheetState();
}

class _GroupmemberActionSheetState extends State<GroupmemberActionSheet> {
  final groupMemberBLoc = GroupMembersCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupMembersCubit, GroupMembersState>(
      bloc: groupMemberBLoc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          deleteMemberSuccess: (response) {
            context.pop();
            context.pop();
            widget.onActionSuccess();
          },
          cancelRequestSuccess: (response) {
            context.pop();
            context.pop();
            widget.onActionSuccess();
          },
          updateMemberRoleSuccess: (response) {
            context.pop();
            context.pop();
            widget.onActionSuccess();
          },
          suspensionSuccess: (response) {
            context.pop();
            context.pop();
            context.pop();
            widget.onActionSuccess();
          },
          deleteMemberLoading: () {
            CustomDialogs.showLoading(context);
          },
          cancelRequestLoading: () {
            CustomDialogs.showLoading(context);
          },
          suspensionLoading: () {
            CustomDialogs.showLoading(context);
          },
          updateMemberRoleLoading: () {
            CustomDialogs.showLoading(context);
          },
          updateMemberRoleFailure: (error) => CustomDialogs.error(error),
          deleteMemberFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          suspensionFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          cancelRequestFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
        );
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionItem(
                imagePath: Assets.images.svgs.user02,
                tittle: "View Profile",
                onTap: () {
                  context.pop();

                  GuestUserHelper.handleGuestUserAction(
                      action: () {
                        if (SessionManager().isMe(widget.member.user.id.toString())) {
                          context.pushNamed(PageUrl.profileScreen, extra: widget.member.user.id.toString());
                        } else {
                          context.pushNamed(PageUrl.userProfileScreen, extra: widget.member.user.id.toString());
                        }
                      },
                      message: "Sign in to view user profile");
                },
              ),
              if (widget.currentUserIsAdmin && !SessionManager().isMe(widget.member.user.id.toString()))
                _ActionItem(
                  imagePath: Assets.images.svgs.suspend,
                  tittle:!widget.member.isSuspended? "Suspend user":" Unsuspend user",
                  onTap: () async {
                    CustomDialogs.showConfirmDialog(context, onYes: () {
                      groupMemberBLoc.suspendMember(
                        memberId: widget.member.id.toString(),
                        reason: "",
                        endDate: DateTime.now(),
                      );
                    }, onCancel: () {
                      context.pop();
                    }, message: "Are you sure you want to ${widget.member.isSuspended?"unsuspend":"suspend"} this member", tittle: widget.member
                        .isSuspended?" UnSuspend member":"Suspend member"

                        );

                  },
                ),
              if (widget.currentUserIsAdmin && !SessionManager().isMe(widget.member.user.id.toString()))
                _ActionItem(
                  imagePath: Assets.images.svgs.slashCircle01,
                  tittle: "Remove ${widget.member.user.username}",
                  onTap: () {
                    groupMemberBLoc.cancelRequest(
                      widget.member.id.toString(),
                    );
                  },
                ),
              if (canMakeModerator())
                _ActionItem(
                  imagePath: Assets.images.svgs.userUp01,
                  tittle: "Make moderator",
                  onTap: () {
                    groupMemberBLoc.updateMemberRole(widget.member.id.toString(), "Admin");
                  },
                ),
              if (!SessionManager().isMe(widget.member.user.id.toString()))
                _ActionItem(
                  imagePath: Assets.images.svgs.messageBubbles,
                  tittle: "Send a message",
                  onTap: () {
                    var user = widget.member.user;

                    context.pushNamed(PageUrl.chatScreen,
                        extra: ChatScreenParam(
                            user: ConversationUser(id: user.id!, name: user.name!, avatar: user.avatar, email: user.email!, username: user.username!)));
                  },
                ),
              if (widget.currentUserIsAdmin && widget.member.role.toLowerCase() == "admin")
                _ActionItem(
                  imagePath: Assets.images.svgs.userUp01,
                  tittle: "Remove as moderator",
                  onTap: () {
                    groupMemberBLoc.updateMemberRole(widget.member.id.toString(), "Member");
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  bool canMakeModerator() {
    return (widget.currentUserIsAdmin && widget.member.role.toLowerCase() != "admin" && widget.member.role.toLowerCase() != "moderator") &&
        !SessionManager().isMe(widget.member.user.id.toString()) &&
        ((widget.group.userRole?.toLowerCase() != "admin") ||
            (widget.group.userRole?.toLowerCase() != "moderator") ||
            (widget.group.userRole?.toLowerCase() != "owner"));
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({super.key, required this.imagePath, required this.tittle, required this.onTap});

  final String imagePath;
  final String tittle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: Row(
              children: [
                ImageWidget(imageUrl: imagePath),
                18.horizontalSpace,
                TextView(
                  text: tittle,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          ),
          const Divider(
              // thickness: 1,
              )
        ],
      ),
    );
  }
}

class FilterModel{

}

enum DateFilter{
  last_month,
  this_month,
}
