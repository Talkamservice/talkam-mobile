import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_group_header.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_group_overview.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class AdGroupResultItem extends StatelessWidget {
  const AdGroupResultItem({super.key, required this.group, required this.onJoinStateChanged, this.imageRadius, this.showFollowGroup = false});

  final TalkamGroup group;
  final BorderRadius? imageRadius;
  final bool showFollowGroup;
  final Function() onJoinStateChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        if (group.isSuspended ?? false) {
          CustomDialogs.error("You have been suspended from this group");
        } else if (!group.isPublic && !(group.isFollowing ?? false)) {
          CustomDialogs.showInfoMessage(context, privateGroupViewText);
        } else {
          context.pushNamed(PageUrl.groupsInfoScreen, extra: group.id.toString());
        }
      },
      child: Column(
        children: [
          AdGroupHeader(
            group: group,
            imageRadius: imageRadius,
            onStateChanged: () {},
          ),
          8.verticalSpace,
          AdGroupOverView(
            data: group,
            showFollowButton: showFollowGroup,
          )
        ],
      ),
    );
  }
}
