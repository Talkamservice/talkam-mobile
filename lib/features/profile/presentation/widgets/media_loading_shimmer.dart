import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talkam/core/theme/pallets.dart';

class MediaLoadingShimmer extends StatelessWidget {
  const MediaLoadingShimmer({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallets.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: Colors.grey[50]!,
        child: GridView.builder(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 6),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 9,
            crossAxisSpacing: 9,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              height: 10,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
