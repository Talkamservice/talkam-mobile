import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// How a [SelectablePill] expresses its selected state.
enum SelectablePillStyle {
  /// Tinted fill, accent border, accent label. Used where several pills sit
  /// side by side and the selection should stay legible rather than shout —
  /// session durations, buffer options, time pills.
  tinted,

  /// Solid accent fill with an inverted label. Used for compact toggles where
  /// the pill itself is the indicator — weekday chips.
  solid,
}

/// A tappable pill with an optional caption underneath.
///
/// The app had grown roughly ten private copies of this shape — `_DayChip`
/// (twice), `_DurationChip`, `_TimePill`, `_Chip` and others — all sharing the
/// same unselected treatment and differing only in how selection is drawn.
/// This is the single source of truth; prefer extending it over adding an
/// eleventh copy.
class SelectablePill extends StatelessWidget {
  const SelectablePill({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.caption,
    this.enabled = true,
    this.style = SelectablePillStyle.tinted,
    this.labelSize = 14,
    this.labelWeight = FontWeight.w700,
    this.captionSize = 11,
    this.radius = 12,
    this.padding,
    this.width,
    this.height,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  /// Secondary line under [label] — "Standard", "Start", "End".
  final String? caption;

  /// When false the pill dims and stops responding to taps.
  final bool enabled;

  final SelectablePillStyle style;

  /// Logical type sizes before ScreenUtil scaling.
  final double labelSize;
  final FontWeight labelWeight;
  final double captionSize;

  /// Logical corner radius before ScreenUtil scaling.
  final double radius;

  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  bool get _isSolidSelected =>
      selected && style == SelectablePillStyle.solid;

  Color get _background {
    if (_isSolidSelected) return Pallets.blueBubbleColor;
    if (selected) return Pallets.blueBubbleColor.withValues(alpha: 0.08);
    return Pallets.grey95.withValues(alpha: 0.1);
  }

  Color get _border =>
      selected ? Pallets.blueBubbleColor : Pallets.grey90;

  Color get _labelColor {
    if (_isSolidSelected) return Colors.white;
    if (selected) return Pallets.blueBubbleColor;
    return Pallets.boldBlackV2;
  }

  @override
  Widget build(BuildContext context) {
    final pill = Container(
      width: width,
      height: height,
      alignment: height != null ? Alignment.center : null,
      padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(color: _border, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(
            text: label,
            align: TextAlign.center,
            fontSize: labelSize,
            fontWeight: labelWeight,
            color: _labelColor,
          ),
          if (caption != null) ...[
            2.verticalSpace,
            TextView(
              text: caption!,
              align: TextAlign.center,
              fontSize: captionSize,
              fontWeight: FontWeight.w500,
              color: Pallets.grey400,
            ),
          ],
        ],
      ),
    );

    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: pill,
      ),
    );
  }
}
