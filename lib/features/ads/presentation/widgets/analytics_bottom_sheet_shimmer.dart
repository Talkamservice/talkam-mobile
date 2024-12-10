import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screens/view_analytics_page.dart';

import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../gen/assets.gen.dart';
import '../../../post/data/models/get_posts_response.dart';

class AnalyticsBottomSheetShimmer extends StatelessWidget {
  const AnalyticsBottomSheetShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            Shimmer.fromColors(
                baseColor: Colors.grey[350]!,
                highlightColor: Colors.grey[50]!,
                child: Column(
                  children: [
                    14.verticalSpace,
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                height: 20,
                                width: 100,
                              ),
                              ImageWidget(imageUrl: Assets.images.svgs.cancelOutlined,height: 10.49, width: 10.49,)
                            ],
                          ),
                          8.verticalSpace,
                          const Divider(
                            thickness: 1,
                            color: Pallets.buttonGrey,
                          ),
                          10.verticalSpace,
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 20,
                            width: 200,
                          ),
                          40.verticalSpace,
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: 500,
                          ),
                          10.verticalSpace,
                          const Divider(
                            thickness: 1,
                            color: Pallets.buttonGrey,
                          ),
                          10.verticalSpace,
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: 500,
                          ),
                          10.verticalSpace,
                          const Divider(
                            thickness: 1,
                            color: Pallets.buttonGrey,
                          ),
                          10.verticalSpace,
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: 500,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Pallets.buttonGrey,
                          ),
                          10.verticalSpace,
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 20,
                            width: 200,
                          ),
                          10.verticalSpace,
                          const Divider(
                            thickness: 1,
                            color: Pallets.buttonGrey,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: 500,
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}