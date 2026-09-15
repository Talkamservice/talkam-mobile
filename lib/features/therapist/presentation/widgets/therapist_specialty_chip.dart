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
  static const amber = SpecialtyPalette(background: Color(0xFFFFF6E5), foreground: Color(0xFFD97706));
  static const blue = SpecialtyPalette(background: Color(0xFFE0F2FE), foreground: Color(0xFF0284C7));
  static const purple = SpecialtyPalette(background: Color(0xFFF3E8FF), foreground: Color(0xFF9333EA));
  static const teal = SpecialtyPalette(background: Color(0xFFCCFBF1), foreground: Color(0xFF0D9488));
  static const indigo = SpecialtyPalette(background: Color(0xFFE0E7FF), foreground: Color(0xFF4F46E5));

  static const cyan = SpecialtyPalette(background: Color(0xFFCFFAFE), foreground: Color(0xFF0891B2));
  static const fuchsia = SpecialtyPalette(background: Color(0xFFFAE8FF), foreground: Color(0xFFC026D3));
  static const emerald = SpecialtyPalette(background: Color(0xFFD1FAE5), foreground: Color(0xFF059669));
  static const orange = SpecialtyPalette(background: Color(0xFFFFEDD5), foreground: Color(0xFFC2410C));
  static const violet = SpecialtyPalette(background: Color(0xFFEDE9FE), foreground: Color(0xFF7C3AED));
  static const lime = SpecialtyPalette(background: Color(0xFFECFCCB), foreground: Color(0xFF4D7C0F));
  static const pink = SpecialtyPalette(background: Color(0xFFFCE7F3), foreground: Color(0xFFBE185D));

  static const List<SpecialtyPalette> _palettes = [
    green,
    rose,
    amber,
    blue,
    purple,
    teal,
    indigo,
    cyan,
    fuchsia,
    emerald,
    orange,
    violet,
    lime,
    pink,
    slate,
  ];

  /// Colour a specialty based on its index so colors cycle sequentially.
  static SpecialtyPalette ofIndex(int index) {
    return _palettes[index % _palettes.length];
  }
}

class TherapistSpecialtyChip extends StatelessWidget {
  const TherapistSpecialtyChip({super.key, required this.specialty, this.index = 0});

  final String specialty;
  final int index;

  @override
  Widget build(BuildContext context) {
    final palette = SpecialtyPalette.ofIndex(index);

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
        for (var i = 0; i < specialties.length; i++)
          TherapistSpecialtyChip(
            specialty: specialties[i],
            index: i,
          ),
      ],
    );
  }
}
