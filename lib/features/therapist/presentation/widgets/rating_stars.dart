import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

/// A horizontal run of solid rating stars.
///
/// Uses `star-filled.svg`, not `star.svg` — the latter is stroke-only, so a
/// srcIn colour filter tints just its outline and it reads as an empty star.
class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.count,
    this.starSize = 14,
    this.gap = 2,
  });

  /// Number of filled stars to draw.
  final int count;

  /// Logical star size before ScreenUtil scaling.
  final double starSize;

  /// Logical gap between stars.
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++)
          Padding(
            padding: EdgeInsets.only(right: i == count - 1 ? 0 : gap.w),
            child: SvgPicture.asset(
              Assets.images.svgV2.starFilled,
              width: starSize.w,
              height: starSize.w,
              colorFilter: const ColorFilter.mode(
                Pallets.starAmber,
                BlendMode.srcIn,
              ),
            ),
          ),
      ],
    );
  }
}
