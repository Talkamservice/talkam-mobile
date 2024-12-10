import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screen.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screens/view_analytics_page.dart';

import '../../../../common/widgets/custom_appbar.dart';
import '../../../post/data/models/get_posts_response.dart';

class PromotionShimmer extends StatelessWidget {
  const PromotionShimmer({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.grey[50]!,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              height: 50,
                              width: 50,
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 13.0,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      3.horizontalSpace,
                                      Container(
                                        height: 10.0,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.verticalSpace,
                                  Container(
                                    height: 10.0,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            5.horizontalSpace,
                            const Icon(Icons.more_vert)
                          ],
                        ),
                        10.verticalSpace,
                        Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          height: 150,
                          width: 500,
                        ),
                        10.verticalSpace,
                        Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          height: 25,
                          width: 75,
                        ),
                      ],
                    ),
                  ),
                ),
                14.verticalSpace,
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallets.borderGrey)),
                  child: Column(
                    children: [
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
                        height: 40,
                        width: 500,
                      ),
                      10.verticalSpace,
                      const Divider(
                        thickness: 1,
                        color: Pallets.buttonGrey,
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 25,
                            width: 70,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 25,
                            width: 70,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            height: 25,
                            width: 70,
                          ),
                        ],
                      ),
                      10.verticalSpace,
                    ],
                  ),
                )
              ],
            )
        ),
      ],
    );
  }
}