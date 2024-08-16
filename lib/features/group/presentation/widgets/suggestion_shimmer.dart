import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SuggestionsShimmer extends StatefulWidget {
  const SuggestionsShimmer({super.key});

  @override
  State<SuggestionsShimmer> createState() => _SuggestionsShimmerState();
}

class _SuggestionsShimmerState extends State<SuggestionsShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: SizedBox(
          width: double.infinity,
          height: 90,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            separatorBuilder: (_, __) => 14.horizontalSpace,
            itemBuilder: (_, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Container(
                  width: 268.w,
                  height: 120.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey[200]!, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 93.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 12.sp,

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            8.verticalSpace,

                            Container(
                              width: 50.w,

                              height: 8.sp,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            10.verticalSpace,
                            Container(
                              width: 80.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}











