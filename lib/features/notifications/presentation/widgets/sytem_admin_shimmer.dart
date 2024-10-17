import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/notifications/presentation/screens/system_admin.dart';

class SystemAdminShimmer extends StatelessWidget {
  const SystemAdminShimmer({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallets.white,
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
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white
                              ),),
                            5.verticalSpace,
                            Container(
                              height: 40,
                              width: 350,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white
                              ),),
                            5.verticalSpace,
                            Container(
                              height: 20,
                              width: 170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white
                              ),),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
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