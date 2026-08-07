import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/section_label.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_about_card.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_ratings_summary.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_review_card.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_specialty_chip.dart';

/// "Profile" tab — biography, specialties and review history.
class TherapistAboutTab extends StatelessWidget {
  const TherapistAboutTab({
    super.key,
    required this.therapist,
    this.padding,
  });

  final TherapistModel therapist;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          TherapistAboutCard(about: therapist.about),
          24.verticalSpace,
          const SectionLabel("Specialties"),
          12.verticalSpace,
          TherapistSpecialtyChips(specialties: therapist.specialties),
          24.verticalSpace,
          const SectionLabel("Ratings & Reviews"),
          16.verticalSpace,
          TherapistRatingsSummary(therapist: therapist),
          for (final review in therapist.reviews) ...[
            12.verticalSpace,
            TherapistReviewCard(review: review),
          ],
        ],
      ),
    );
  }
}
