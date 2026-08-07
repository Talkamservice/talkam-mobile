import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/section_label.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/features/therapist/data/models/therapist_model.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_about_card.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_profile_header.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_ratings_summary.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_review_card.dart';
import 'package:talkam/features/therapist/presentation/widgets/therapist_specialty_chip.dart';

/// Client-facing view of a therapist, ending in the booking call to action.
class TherapistProfileScreen extends StatefulWidget {
  final TherapistModel therapist;

  const TherapistProfileScreen({
    super.key,
    required this.therapist,
  });

  @override
  State<TherapistProfileScreen> createState() => _TherapistProfileScreenState();
}

class _TherapistProfileScreenState extends State<TherapistProfileScreen> {
  late String _selectedFormat;

  @override
  void initState() {
    super.initState();
    _selectedFormat = widget.therapist.sessionFormats.isNotEmpty
        ? widget.therapist.sessionFormats.first
        : 'Video';
  }

  @override
  Widget build(BuildContext context) {
    final therapist = widget.therapist;

    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: CustomAppBar(
        titleAlign: TextAlign.start,
        centerTile: false,
        tittle: TextView(
          text: "Therapist Profile",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.verticalSpace,
              TherapistProfileHeader(therapist: therapist),
              24.verticalSpace,
              TherapistAboutCard(about: therapist.about),
              24.verticalSpace,
              const SectionLabel("Specialties"),
              12.verticalSpace,
              TherapistSpecialtyChips(specialties: therapist.specialties),
              24.verticalSpace,
              const SectionLabel("Session format"),
              12.verticalSpace,
              _SessionFormatPicker(
                formats: therapist.sessionFormats,
                selected: _selectedFormat,
                onSelected: (format) =>
                    setState(() => _selectedFormat = format),
              ),
              24.verticalSpace,
              const SectionLabel("Ratings & Reviews"),
              16.verticalSpace,
              TherapistRatingsSummary(therapist: therapist),
              for (final review in therapist.reviews) ...[
                12.verticalSpace,
                TherapistReviewCard(review: review),
              ],
              20.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Pallets.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "Session fee",
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Pallets.grey,
                  ),
                  TextView(
                    text:
                        "₦${therapist.pricePerSession.toInt().toString().formatNumber()}",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlack,
                  ),
                ],
              ),
              12.verticalSpace,
              CustomButton(
                onPressed: () {
                  context.pushNamed(
                    PageUrl.bookingStepOneScreen,
                    extra: therapist,
                  );
                },
                child: const Text(
                  "Book session",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Single-select run of session formats (Video / Voice / Chat).
class _SessionFormatPicker extends StatelessWidget {
  const _SessionFormatPicker({
    required this.formats,
    required this.selected,
    required this.onSelected,
  });

  final List<String> formats;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 8.h,
      children: [
        for (final format in formats)
          GestureDetector(
            onTap: () => onSelected(format),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: format == selected
                    ? Pallets.blueBubbleColor
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: TextView(
                text: format,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color:
                    format == selected ? Pallets.white : const Color(0xFF4B5563),
              ),
            ),
          ),
      ],
    );
  }
}
