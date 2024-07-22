import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostLoadingShimmer extends StatelessWidget {
  const PostLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.grey[50]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    6.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 8.0,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          10.verticalSpace,
                          Container(
                            height: 8.0,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Container(
                        height: 30,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    )
                  ],
                ),
                10.verticalSpace,
                Container(
                  height: 8.0,
                  width: 200.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                10.verticalSpace,
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity,
              height: 200.h,
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => 10.horizontalSpace,
                itemBuilder: (_, int index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[350]!,
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      height: 180,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[50]!,
              child: Container(
                width: double.infinity,
                height: 84.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.grey[50]!,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      //width: 48.0,
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  20.horizontalSpace,
                  Expanded(
                    child: Container(
                      //width: 48.0,
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 200.h,
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => 10.horizontalSpace,
                itemBuilder: (_, int index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[350]!,
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      height: 180,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
