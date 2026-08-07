import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/presentation/widgets/rating_stars.dart';

/// A single anonymised client review.
class TherapistReviewCard extends StatelessWidget {
  const TherapistReviewCard({super.key, required this.review});

  final TherapistReview review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.surfaceMuted,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Pallets.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingStars(count: review.rating),
              TextView(
                text: review.timeAgo,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Pallets.grey,
              ),
            ],
          ),
          12.verticalSpace,
          TextView(
            text: review.body,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Pallets.slate700,
            lineHeight: 1.4,
          ),
          12.verticalSpace,
          TextView(
            text: review.attribution,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Pallets.grey,
          ),
        ],
      ),
    );
  }
}
