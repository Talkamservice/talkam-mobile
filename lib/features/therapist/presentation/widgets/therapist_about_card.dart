import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Tinted "ABOUT" panel holding a therapist's biography.
class TherapistAboutCard extends StatelessWidget {
  const TherapistAboutCard({super.key, required this.about});

  final String about;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.infoSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Pallets.infoBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "ABOUT",
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Pallets.slate500,
          ),
          8.verticalSpace,
          TextView(
            text: about,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Pallets.slate500,
            lineHeight: 1.4,
          ),
        ],
      ),
    );
  }
}
