import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/ads/presentation/widgets/cancel_ad_dialog.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';
import 'package:talkam/features/post/presentation/widgets/scheduled_post_pill.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';

import '../../../../core/di/injector.dart';
import '../../../subscription/presentation/widgets/cancel_subscription_dialog.dart';
import '../screens/ads_flow.dart';
import '../screens/ads_review_screens/view_analytics_page.dart';
import 'delete_ad_dialogue.dart';

class ClosedAdsPostItem extends StatelessWidget {
  const ClosedAdsPostItem({super.key, required this.post, this.showGroupAndCategory = true, this.showScheduledPost = false});

  final bool? showGroupAndCategory;
  final bool? showScheduledPost;
  final TalkamPost post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.pushNamed(PageUrl.postDetailsScreen, extra: post.id.toString());
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
                    post: post,
                    category: post.category,
                    onMenuTap: () async {
                      var isReported = await CustomDialogs.showBottomSheet(
                          context,
                          PostActionSheet(
                            post: post,
                            onPostDeleted: () {},
                          ));
                      if (isReported ?? false) {
                        post.isReported = true;
                      }
                    },
                  ),
                  10.verticalSpace,
                  PostContent(
                    post: post,
                    mediaHeight: 113,
                  ),
                  4.verticalSpace,

                  if (showScheduledPost!) 4.verticalSpace,
                  if (shouldShowScheduledPost) const Divider(thickness: 1),
                  // 3.verticalSpace,
                  ScheduledPostPill(showScheduledPost: shouldShowScheduledPost, post: post)
                ],
              ),
            ),
          ),
        ),
        14.verticalSpace,
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "Impressions",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Pallets.textGrey,
                      ),
                      8.verticalSpace,
                      const TextView(
                        text: "1,000",
                        fontSize: 16,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "Engagements",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Pallets.textGrey,
                      ),
                      8.verticalSpace,
                      const TextView(
                        text: "40",
                        fontSize: 16,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "New followers",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Pallets.textGrey,
                      ),
                      8.verticalSpace,
                      const TextView(
                        text: "20",
                        fontSize: 16,
                      ),
                    ],
                  )
                ],
              ),
              15.verticalSpace,
              const Divider(
                thickness: 1,
                color: Pallets.buttonGrey,
              ),
              TextButton(
                  onPressed: (){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context)=> ViewAnalyticsPage(promotion: post,)
                    //     )
                    // );
                  },
                  child: const Row(
                    children: [
                      Expanded(
                          child: TextView(
                            text: "View all analytics",
                            fontSize: 12,
                          )),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      )
                    ],
                  )),
              const Divider(
                thickness: 1,
                color: Pallets.buttonGrey,
              ),
              15.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xFFF4D4D4)), color: const Color(0xFFFADDDD)),
                    child: const TextView(fontSize: 12, text: "Closed Ad"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Pallets.buttonred,
                      textStyle: const TextStyle(color: Pallets.buttonred, fontSize: 12),
                    ),
                    onPressed: () {
                      CustomDialogs.showOverlayDialog(context,
                          child: DeleteAdDialog(
                            onCancel: () {
                              logger.i("cancel");
                            },
                          ));
                    },
                    child: const TextView(
                      text: "Delete Ad",
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 30,

                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          foregroundColor: Pallets.white,
                          backgroundColor: Pallets.blueBubbleColor,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          context.pushNamed(PageUrl.createAdsScreen);

                        },
                        child: const TextView(
                          text: "Restart Ad",
                          fontSize: 12,
                        )),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  bool get shouldShowScheduledPost => showScheduledPost! && post.isSchedulePost && (post.publishAt as DateTime).isAfter(DateTime.now());

  String get userName => post.isAnonymous.toBool ? "Anonymous" : post.user.usersName;
}
