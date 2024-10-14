import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/presentation/widgets/groupmember_action_sheet.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupMemberItem extends StatelessWidget {
  const GroupMemberItem({super.key, required this.member, required this.group, required this.onActionSuccess});

  final GroupMemberDetails member;
  final TalkamGroup group;
  final VoidCallback onActionSuccess;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GuestUserHelper.handleGuestUserAction(
          action: () {
            if (SessionManager().isMe(member.user.id.toString())) {
              context.pushNamed(PageUrl.profileScreen, extra: member.user.id.toString());
            } else {
              context.pushNamed(PageUrl.userProfileScreen, extra: member.user.id.toString());
            }
          },
        );
      },
      child: Row(
        children: [
          ImageWidget(
            imageUrl: member.user.avatar.toString(),
            height: 40,
            width: 40,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: getDisplayName,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                TextView(
                  text: "Member since ${TimeUtil.formatDate((member.createdAt ?? DateTime.now()).toIso8601String())}",
                  fontSize: 12,
                ),
              ],
            ),
          ),
          if (member.isSuspended && !(member.isBanned))
            Container(
              decoration: BoxDecoration(border: Border.all(color: Pallets.red), borderRadius: BorderRadius.circular(100)),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: TextView(
                  text: "Suspended",
                  color: Pallets.red,
                  fontSize: 13,
                ),
              ),
            ),
          if (member.isBanned)
            Container(
              decoration: BoxDecoration(border: Border.all(color: Pallets.red), borderRadius: BorderRadius.circular(100)),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: TextView(
                  text: "Banned",
                  color: Pallets.red,
                  fontSize: 13,
                ),
              ),
            ),
          IconButton(
              onPressed: () {
                CustomDialogs.showBottomSheet(
                    context,
                    GroupmemberActionSheet(
                      currentUserIsAdmin: group.isAdmin,
                      member: member,
                      group: group,
                      onActionSuccess: onActionSuccess,
                    ));
              },
              icon: Icon(
                Icons.more_vert,
                color: context.colorScheme.onSurface,
              ))
        ],
      ),
    );
  }

  String get getDisplayName => (member.user.name ?? "").isNotEmpty
      ? member.user.name!
      : (member.user.username != null && member.user.username!.isNotEmpty)
          ? member.user.username!
          : member.user.email!;
}
