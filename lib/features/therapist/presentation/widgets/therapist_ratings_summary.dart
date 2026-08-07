import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/presentation/widgets/rating_stars.dart';

/// Average rating alongside the 5-to-1 star distribution.
class TherapistRatingsSummary extends StatelessWidget {
  const TherapistRatingsSummary({super.key, required this.therapist});

  final TherapistModel therapist;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.surfaceMuted,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: "${therapist.rating}",
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlack,
              ),
              4.verticalSpace,
              const RatingStars(count: 5),
              6.verticalSpace,
              TextView(
                text: "avg rating",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Pallets.grey,
              ),
            ],
          ),
          24.horizontalSpace,
          Expanded(
            child: Column(
              children: [
                for (var star = 5; star >= 1; star--) ...[
                  _RatingBarRow(
                    star: star,
                    fraction: therapist.breakdownFor(star),
                  ),
                  if (star > 1) 6.verticalSpace,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  const _RatingBarRow({required this.star, required this.fraction});

  final int star;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10.w,
          child: TextView(
            text: "$star",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Pallets.grey,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: fraction.clamp(0.0, 1.0),
              minHeight: 4.h,
              backgroundColor: Pallets.hairline,
              valueColor: const AlwaysStoppedAnimation<Color>(Pallets.starAmber),
            ),
          ),
        ),
      ],
    );
  }
}
