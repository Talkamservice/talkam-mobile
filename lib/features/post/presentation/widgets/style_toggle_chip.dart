import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Small circular B/I toggle used by the composer's inline style reveal.
/// Stays highlighted while [active], matching the "remains selected while
/// on" toggle behavior.
class StyleToggleChip extends StatelessWidget {
  const StyleToggleChip({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
    this.fontStyle,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      // Prevent this button from stealing keyboard focus off the composer's
      // text field — otherwise the just-styled selection visually loses its
      // highlight the instant this is tapped, even though the selection
      // range itself is preserved.
      canRequestFocus: false,
      child: Container(
        width: 28.w,
        height: 28.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active
              ? Pallets.blueBubbleColor
              : Pallets.blueBubbleColor.withValues(alpha: 0.08),
        ),
        child: TextView(
          text: label,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          fontStyle: fontStyle,
          color: active ? Colors.white : Pallets.blueBubbleColor,
        ),
      ),
    );
  }
}
