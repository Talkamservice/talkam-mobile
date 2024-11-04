import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/presentation/widgets/analytics_reactions_bar.dart';
import 'package:talkam/features/ads/presentation/widgets/country_engagements_item.dart';
import 'package:talkam/features/ads/presentation/widgets/country_engagements_widget.dart';
import 'package:talkam/features/ads/presentation/widgets/impressions_info_item.dart';
import 'package:talkam/features/ads/presentation/widgets/impressions_info_widget.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_item_components.dart';
import '../../../../../common/widgets/custom_appbar.dart';
import '../../../../../common/widgets/image_widget.dart';
import '../../../../../gen/assets.gen.dart';


class ViewAnalyticsPage extends StatelessWidget {
  const ViewAnalyticsPage ({super.key, required this.post});

  final TalkamPost post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          padding: EdgeInsets.only(right: 10.0),
          tittleText: "Back",
          centerTile: false,
          showDivider: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left:16, right:16, top:20,),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    PostHeader(
                      showGroupAndCategory: true,
                      userName: "sample username",
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
                  ],
                ),
              ),
            ),
              14.verticalSpace,
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                child: Column(
                  children: [
                    const AnalyticsReactionsBar(comments: 40, likes: 50, dislikes: 20, shares: 20),
                    10.verticalSpace,
                    const ImpressionsInfoWidget(),
                    15.verticalSpace,
                    const Divider(
                      thickness: 1,
                      color: Pallets.buttonGrey,
                    ),
                    12.verticalSpace,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Country engagements", style: TextStyle(fontSize: 12),),
                      ],
                    ),
                    12.verticalSpace,
                    const Divider(
                      thickness: 1,
                      color: Pallets.buttonGrey,
                    ),
                    20.verticalSpace,
                    const CountryEngagementsWidget(country1: "Nigeria", country2: "Ghana", country3: "Benin", countryPer1: "98", countryPer2: "1", countryPer3: "1")
                  ],
                ),
              )
            ],
          ),
        )
      );
  }
}
