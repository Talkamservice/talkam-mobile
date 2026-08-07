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
import 'package:talkam/common/widgets/subscribe_button.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupMemberItem extends StatelessWidget {
  const GroupMemberItem({
    super.key,
    required this.member,
    required this.group,
    required this.onActionSuccess,
    this.isFollowing = false,
    this.currentUserIsAdmin = false,
  });

  final GroupMemberDetails member;
  final TalkamGroup group;
  final VoidCallback onActionSuccess;
  final bool isFollowing;
  final bool currentUserIsAdmin;

  @override
  Widget build(BuildContext context) {
    final isMe = SessionManager().isMe(member.user.id.toString());
    final isAdmin = currentUserIsAdmin || group.isAdmin;

    return InkWell(
      onTap: () {
        GuestUserHelper.handleGuestUserAction(
          action: () {
            if (isMe) {
              context.pushNamed(PageUrl.profileScreen, extra: member.user.id.toString());
            } else {
              context.pushNamed(PageUrl.userProfileScreen, extra: member.user.id.toString());
            }
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
              imageUrl: member.user.avatar?.toString() ?? Assets.images.svgs.user,
              size: 50,
              shape: BoxShape.circle,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: TextView(
                                    text: getDisplayName,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: context.colorScheme.onSurface,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                4.horizontalSpace,
                                const Icon(
                                  Icons.verified,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                if (member.isSuspended == true || member.isBanned == true) ...[
                                  6.horizontalSpace,
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: Pallets.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: Border.all(color: Pallets.red, width: 0.5),
                                    ),
                                    child: TextView(
                                      text: member.isBanned == true ? "Banned" : "Suspended",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Pallets.red,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            TextView(
                              text: "@${member.user.username ?? getDisplayName.replaceAll(' ', '')}",
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Pallets.darkGrey,
                            ),
                          ],
                        ),
                      ),
                      if (!isMe)
                        SubscribeButton(
                          color: isFollowing ? Pallets.grey60 : Pallets.blueBubbleColor,
                          onTap: () {}, // Visual mock
                          child: TextView(
                            text: isFollowing ? "Following" : "Follow",
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      if (isAdmin && !isMe) ...[
                        4.horizontalSpace,
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            CustomDialogs.showBottomSheet(
                              context,
                              GroupmemberActionSheet(
                                currentUserIsAdmin: isAdmin,
                                member: member,
                                group: group,
                                onActionSuccess: onActionSuccess,
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                  8.verticalSpace,
                  TextView(
                    text: "Member of ${group.name ?? 'Group'}",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Pallets.darkGrey,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get getDisplayName => (member.user.name ?? "").isNotEmpty
      ? member.user.name!
      : (member.user.username ?? "").isNotEmpty
          ? member.user.username!
          : member.user.email ?? "Anonymous";
}
