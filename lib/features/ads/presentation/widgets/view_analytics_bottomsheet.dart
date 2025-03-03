import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/presentation/widgets/analytics_bottom_sheet_shimmer.dart';

import '../../../../common/widgets/error_widget.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/theme/pallets.dart';
import '../../../../gen/assets.gen.dart';
import '../blocs/ads/ads_cubit.dart';
import 'ad_group_item.dart';
import 'analytics_reactions_bar.dart';
import 'country_engagements_widget.dart';
import 'impressions_info_widget.dart';

class ViewAnalyticsBottomSheet extends StatefulWidget {
  const ViewAnalyticsBottomSheet({super.key, required this.postId, this.isPost = true});

  final String postId;
  final bool isPost;

  @override
  State<ViewAnalyticsBottomSheet> createState() => _ViewAnalyticsBottomSheetState();
}

class _ViewAnalyticsBottomSheetState extends State<ViewAnalyticsBottomSheet> {
  final AdsCubit bloc = AdsCubit(injector.get());

  @override
  void initState() {
    bloc.getAnalytics(widget.isPost, widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsState>(
        bloc: bloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => Container(
                    height: 400.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    decoration: BoxDecoration(
                        color: context.theme.cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(8.r),
                        )),
                    child: AppErrorWidget(
                      onTap: () {
                        bloc.getAnalytics(widget.isPost, widget.postId);
                      },
                    ),
                  ),
              getAnalyticsLoading: () => AnalyticsBottomSheetShimmer(),
              getAnalyticsFailed: (message) => Container(
                    height: 400.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    decoration: BoxDecoration(
                        color: context.theme.cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(8.r),
                        )),
                    child: AppErrorWidget(
                      onTap: () {
                        bloc.getAnalytics(widget.isPost, widget.postId);
                      },
                    ),
                  ),
              getAnalyticsSuccess: (promotion) {
                return Container(
                  height: 400.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        topRight: Radius.circular(8.r),
                      )),
                  child: ListView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Post analytics",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                                onTap: Navigator.of(context).pop,
                                child: ImageWidget(
                                  imageUrl: Assets.images.svgs.cancelOutlined,
                                  height: 10.49,
                                  width: 10.49,
                                ))
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Pallets.buttonGrey,
                        ),
                        Text(
                          "Get more insights into how well your post is doing.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Pallets.textGrey,
                          ),
                        ),
                        20.verticalSpace,
                        ImpressionsInfoWidget(analyticsInfo: promotion.data),
                        if (promotion.data.countries != null && promotion.data.countries!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              CountryEngagementsWidget(
                                countryStats: promotion.data.countries ?? [],
                              ),
                            ],
                          )
                      ],
                    ),
                  ]),
                );
              });
        });
  }
}
