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
                               borderRadius: BorderRadius.circular(2),
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
                                borderRadius: BorderRadius.circular(10.0),
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


//[
//                     Row(
//                       children: [
//                         Container(
//                           height: 50.0,
//                           width: 50.0,
//                           decoration: const BoxDecoration(
//                             color: Colors.red,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         6.horizontalSpace,
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     height: 13.0,
//                                     width: 120,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(20.0),
//                                     ),
//                                   ),
//                                   3.horizontalSpace,
//                                   Container(
//                                     height: 10.0,
//                                     width: 20,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(20.0),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               5.verticalSpace,
//                               Container(
//                                 height: 10.0,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20.0),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Icon(
//                             Icons.more_vert,
//                             size: 30,
//                           ),
//                         )
//                       ],
//                     ),
//                     10.verticalSpace,
//                     Container(
//                       height: 20,
//                       width: 1.sw * 0.8,
//                       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
//                     ),
//                     10.verticalSpace,
//                     Container(
//                       height: 150,
//                       width: 1.sw,
//                       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ]
