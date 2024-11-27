import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/widgets/promotion_sheet.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupOverViewSection extends StatelessWidget {
  const GroupOverViewSection({super.key, this.showAbout = true, required this.data, this.onAboutCLicked, this.onPromoted});

  final VoidCallback? onAboutCLicked;
  final VoidCallback? onPromoted;

  final TalkamGroup data;

  final bool? showAbout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ImageWidget(
              imageUrl: data.category?.iconImage,
              size: 40,
              fit: BoxFit.cover,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextView(
                        text: data.name!,
                        fontSize: 16,
                      ),
                      8.horizontalSpace,
                      if ((data.isOwner || data.isAdmin) && !data.isPromoted)
                        InkWell(
                          onTap: () {
                            SubscriptionHelper.handleSubscriptionAction(
                              unsubscribedUserAction: () {
                                context.pushNamed(PageUrl.subscriptionScreen);
                              },
                              action: () {
                                CustomDialogs.showBottomSheet(
                                    context,
                                    PromotePostSheet(
                                      type: 'Group',
                                      id: data.id ?? 0,
                                      onPromoted: () {
                                        if (onPromoted != null) {
                                          onPromoted!();
                                        }
                                      },
                                    ),
                                    constraints: BoxConstraints(maxHeight: 0.7.sh));
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22), border: Border.all(color: Pallets.lightBlue), gradient: whiteBlueGradient),
                            child: const TextView(fontSize: 8, text: "Promote group"),
                          ),
                        ),
                      if (data.isPromoted)
                        SizedBox(
                          width: 40,
                          height: 25,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero, shape: StadiumBorder(), backgroundColor: Pallets.adIndicator, foregroundColor: Pallets.black),
                              onPressed: () {},
                              child: TextView(
                                text: "Ad",
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              )),
                        )
                    ],
                  ),
                  // 2.verticalSpace,
                  TextView(
                    text: formatFollowersCount(data.totalMembers),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            if (showAbout!)
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Pallets.borderGrey.withOpacity(0.2),
                      shape: const StadiumBorder(side: BorderSide(color: Pallets.borderGrey)),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
                  onPressed: () {
                    if (onAboutCLicked != null) {
                      onAboutCLicked!();
                    }

                    // CustomDialogs.showBottomSheet(context, const RulesSheet());
                  },
                  child: Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.infoCircle),
                      10.horizontalSpace,
                      const TextView(
                        text: "About",
                        fontSize: 14,
                        // color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ))
          ],
        ),
        13.verticalSpace,
        TextView(
          text: data.about.toString(),
        )
      ],
    );
  }
}

formatFollowersCount(totalMembers) {
  if (totalMembers >= 1000) {
    return '${(totalMembers / 1000).toFixed(1)}k';
  } else if (totalMembers <= 1) {
    return "${totalMembers.toString()} Follower";
  } else {
    return "${totalMembers.toString()} Followers";
  }
}
