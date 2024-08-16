import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalChipsShimmer extends StatefulWidget {
  const HorizontalChipsShimmer({super.key});

  @override
  State<HorizontalChipsShimmer> createState() => _HorizontalChipsShimmerState();
}

class _HorizontalChipsShimmerState extends State<HorizontalChipsShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            separatorBuilder: (_, __) => 14.horizontalSpace,
            itemBuilder: (_, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: 60,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
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
