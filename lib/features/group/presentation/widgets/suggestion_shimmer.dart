import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Mirrors the real Suggested carousel's `_SuggestedTile` card — same
/// size, border, and thumbnail/text/button layout — so the loading state
/// doesn't visibly jump once real suggestions swap in.
class SuggestionsShimmer extends StatelessWidget {
  const SuggestionsShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: SizedBox(
        width: double.infinity,
        height: 100.h,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          separatorBuilder: (_, __) => 14.horizontalSpace,
          itemBuilder: (context, index) => const _SuggestedTilePlaceholder(),
        ),
      ),
    );
  }
}

class _SuggestedTilePlaceholder extends StatelessWidget {
  const _SuggestedTilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 268.w,
      height: 100.h,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Pallets.borderGrey, width: 1.5),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: Colors.grey[50]!,
        child: Row(
          children: [
            Container(
              width: 93.w,
              height: 80.h,
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
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  8.verticalSpace,
                  Container(
                    width: 60.w,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 70.w,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
