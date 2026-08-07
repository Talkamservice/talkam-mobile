import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';

/// Background/foreground pair for a specialty chip.
@immutable
class SpecialtyPalette {
  const SpecialtyPalette({required this.background, required this.foreground});

  final Color background;
  final Color foreground;

  static const green =
      SpecialtyPalette(background: Color(0xFFE8F8F0), foreground: Color(0xFF059669));
  static const rose =
      SpecialtyPalette(background: Color(0xFFFFEAEA), foreground: Color(0xFFE11D48));
  static const slate =
      SpecialtyPalette(background: Color(0xFFF0F2F5), foreground: Color(0xFF6B7280));
  static const amber =
      SpecialtyPalette(background: Color(0xFFFFF6E5), foreground: Color(0xFFD97706));

  /// Colour a specialty consistently wherever it appears. Unmapped specialties
  /// fall back to [slate] — a neutral chip is better than mis-signalling with a
  /// colour that means something else elsewhere in the app.
  static SpecialtyPalette of(String specialty) {
    switch (specialty.trim().toLowerCase()) {
      case 'anxiety':
        return green;
      case 'depression':
        return rose;
      case 'overwhelm':
        return amber;
      case 'stress':
      default:
        return slate;
    }
  }
}

class TherapistSpecialtyChip extends StatelessWidget {
  const TherapistSpecialtyChip({super.key, required this.specialty});

  final String specialty;

  @override
  Widget build(BuildContext context) {
    final palette = SpecialtyPalette.of(specialty);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextView(
        text: specialty,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: palette.foreground,
      ),
    );
  }
}

/// Wrapping run of specialty chips. Wraps rather than scrolls so a therapist
/// with many specialties stays fully readable on narrow devices.
class TherapistSpecialtyChips extends StatelessWidget {
  const TherapistSpecialtyChips({super.key, required this.specialties});

  final List<String> specialties;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final specialty in specialties)
          TherapistSpecialtyChip(specialty: specialty),
      ],
    );
  }
}
