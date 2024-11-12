import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';
import 'package:talkam/features/post/presentation/widgets/scheduled_post_pill.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

import 'package:talkam/common/widgets/custom_dialogs.dart';
class AdPostItem extends StatelessWidget {
  const AdPostItem({super.key, required this.promotion, this.showGroupAndCategory = true,
    this.showScheduledPost = false,});
  final PromotionData promotion;
  final bool? showGroupAndCategory;
  final bool? showScheduledPost;

  @override
  Widget build(BuildContext context) {
    return      InkWell(
      onTap: () {
        context.pushNamed(PageUrl.postDetailsScreen, extra: promotion.id.toString());
      },
      child: Container(
        decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostHeader(
                showGroupAndCategory: showGroupAndCategory,
                userName: userName,
                enablePromoteAddPill: false,
                post: promotion.post!,
                category: promotion.post!.category,
                onMenuTap: () async {
                  var isReported = await CustomDialogs.showBottomSheet(
                      context,
                      PostActionSheet(
                        post: promotion.post!,
                        onPostDeleted: () {},
                      ));
                  if (isReported ?? false) {
                    promotion.post!.isReported = true;
                  }
                },
              ),
              10.verticalSpace,
              PostContent(
                post: promotion.post!,
                mediaHeight: 113,
              ),
              4.verticalSpace,
              if (showScheduledPost!) 4.verticalSpace,
              if (shouldShowScheduledPost) const Divider(thickness: 1),
              // 3.verticalSpace,
              ScheduledPostPill(showScheduledPost: shouldShowScheduledPost, post: promotion.post!)
            ],
          ),
        ),
      ),
    );
  }
  bool get shouldShowScheduledPost => showScheduledPost! && promotion.post!.isSchedulePost && (promotion.post!.publishAt as DateTime).isAfter(DateTime.now());

  String get userName => promotion.post!.isAnonymous.toBool
      ? "Anonymous"
      : promotion.user == null
      ? ""
      : promotion.post?.user.usersName ?? "";
}
