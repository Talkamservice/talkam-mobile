import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talkam/core/theme/pallets.dart';

class GroupLoadingShimmer extends StatelessWidget {
  const GroupLoadingShimmer({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Pallets.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (c, i) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
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
                          height: 60,
                          width: 80,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(8),
                                ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              height: 10,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 35,),
                        Container(
                          height: 35,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}