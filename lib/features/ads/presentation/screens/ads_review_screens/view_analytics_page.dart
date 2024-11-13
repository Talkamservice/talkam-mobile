import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_group_item.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_post_item.dart';
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

class ViewAnalyticsPage extends StatefulWidget {
  ViewAnalyticsPage({super.key, required this.promotion});

  final PromotionData promotion;

  @override
  State<ViewAnalyticsPage> createState() => _ViewAnalyticsPageState();
}

class _ViewAnalyticsPageState extends State<ViewAnalyticsPage> {
  final AdsCubit bloc = AdsCubit(injector.get());

  @override
  void initState() {
    bloc.getAnalytics(widget.promotion.post?.id.toString() ?? "0");
    super.initState();
  }

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
        body: BlocConsumer<AdsCubit, AdsState>(
          bloc: bloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => AppErrorWidget(
                onTap: () {
                  bloc.getAnalytics(widget.promotion.post!.id.toString());
                },
              ),
              getAnalyticsLoading: () => Center(
                child: CustomDialogs.getLoading(size: 30),
              ),
              getAnalyticsFailed: (message) => AppErrorWidget(
                onTap: () {
                  bloc.getAnalytics(widget.promotion.post!.id.toString());
                },
              ),
              getAnalyticsSuccess: (result) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 20,
                  ),
                  child: ListView(
                    children: [
                      widget.promotion.isPost
                          ? AdPostItem(promotion: widget.promotion)
                          : Container(
                              decoration: BoxDecoration(
                                  color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                              padding: EdgeInsets.all(10),
                              child: AdGroupResultItem(
                                imageRadius: BorderRadius.circular(5),
                                group: widget.promotion.group!,
                                onJoinStateChanged: () {},
                              ),
                            ),
                      14.verticalSpace,
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: context.theme.cardColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                        child: Column(
                          children: [
                            if (widget.promotion.isPost)
                              AnalyticsReactionsBar(
                                  comments: result.data.comments, likes: result.data.likes, dislikes: result.data.dislikes, shares: result.data.shares),
                            if (widget.promotion.isPost) 10.verticalSpace,
                            ImpressionsInfoWidget(
                              analyticsInfo: result.data,
                            ),
                            15.verticalSpace,
                            const Divider(
                              thickness: 1,
                              color: Pallets.buttonGrey,
                            ),
                            12.verticalSpace,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Country engagements",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            12.verticalSpace,
                            const Divider(
                              thickness: 1,
                              color: Pallets.buttonGrey,
                            ),
                            20.verticalSpace,
                            const CountryEngagementsWidget(
                                country1: "Nigeria", country2: "Ghana", country3: "Benin", countryPer1: "98", countryPer2: "1", countryPer3: "1")
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
