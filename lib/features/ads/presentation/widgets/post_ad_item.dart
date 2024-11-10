import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/widgets/cancel_ad_dialog.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';
import 'package:talkam/features/post/presentation/widgets/scheduled_post_pill.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';
import '../../../../core/di/injector.dart';
import '../screens/ads_review_screens/view_analytics_page.dart';

class PostAdItem extends StatelessWidget {
  PostAdItem({super.key, required this.promotion, this.showGroupAndCategory = true, this.showScheduledPost = false, required this.onAdCancelled});

  final bool? showGroupAndCategory;
  final bool? showScheduledPost;
  final PromotionData promotion;
  final AdsCubit bloc = AdsCubit(injector.get());
  final VoidCallback onAdCancelled;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdsCubit, AdsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          removingPromotion: () {
            CustomDialogs.showLoading(context);
          },
          promotionRemoveFailed: (message) {
            context.pop();
            CustomDialogs.error(message);
          },
          promotionRemoved: (result) {
            context.pop();
            CustomDialogs.success("Promotion cancelled");
            onAdCancelled();
          },
        );
      },
      child: Column(
        children: [
          InkWell(
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAnalyticsPage(
                                    post: promotion.post!,
                                  )));
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
                if (false)
                  ActiveAdBar(
                    onCancel: () {},
                    onEdit: () {},
                  ),
                if (true)
                  InActiveAdBar(
                    onDelete: () {
                      // bloc.removePromotion(promotion.id.toString());
                    },
                    onRestart: () {},
                  ),
              ],
            ),
          )
        ],
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

class ActiveAdBar extends StatelessWidget {
  const ActiveAdBar({
    super.key,
    required this.onCancel,
    required this.onEdit,
  });

  final VoidCallback onCancel;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), border: Border.all(color: Pallets.lightBlue), gradient: whiteBlueGradient),
          child: const TextView(fontSize: 12, text: "Running Ad"),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Pallets.buttonred,
            textStyle: const TextStyle(color: Pallets.buttonred, fontSize: 12),
          ),
          onPressed: () {
            CustomDialogs.showOverlayDialog(context, child: CancelAdDialog(
              onCancel: () {
                onCancel();
                // bloc.removePromotion(promotion.id.toString());
              },
            ));
          },
          child: const TextView(
            text: "Close Ad",
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
                onEdit();
                // context.pushNamed(PageUrl.createAdsScreen);
              },
              child: const TextView(
                text: "Edit Ad",
                fontSize: 12,
              )),
        )
      ],
    );
  }
}

class InActiveAdBar extends StatelessWidget {
  const InActiveAdBar({
    super.key,
    required this.onDelete,
    required this.onRestart,
  });

  final VoidCallback onDelete;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: Pallets.buttonred.withOpacity(0.1),
            foregroundColor: Pallets.buttonred,
            padding: EdgeInsets.symmetric(horizontal: 16,),
            textStyle: const TextStyle(color: Pallets.buttonred, fontSize: 12, fontWeight: FontWeight.w700),
          ),
          onPressed: () {},
          child: const TextView(
            text: "Closed Ad",
            fontSize: 12,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Pallets.buttonred,
            textStyle: const TextStyle(color: Pallets.buttonred, fontSize: 12),
          ),
          onPressed: () {
            CustomDialogs.showOverlayDialog(context, child: CancelAdDialog(
              onCancel: () {
                onDelete();
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
                onRestart();
                // context.pushNamed(PageUrl.createAdsScreen);
              },
              child: const TextView(
                text: "Restart Ad",
                fontSize: 12,
              )),
        )
      ],
    );
  }
}
