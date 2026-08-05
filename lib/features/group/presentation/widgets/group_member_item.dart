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
  });

  final GroupMemberDetails member;
  final TalkamGroup group;
  final VoidCallback onActionSuccess;
  final bool isFollowing;

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
                    ],
                  ),
                  8.verticalSpace,
                  TextView(
                    text: "I am a licensed therapist dedicated to helping individuals navigate life's challenges...",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Pallets.darkGrey,
                    maxLines: 3,
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
