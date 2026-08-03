import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// "STEP X OF Y — LABEL" caption with a percentage-filled progress line.
///
/// Used across the therapist application wizard so every step shares one
/// progress implementation instead of each screen computing its own percent.
class StepProgressBar extends StatelessWidget {
  const StepProgressBar({
    super.key,
    required this.step,
    required this.totalSteps,
    required this.label,
    this.customPercentage,
  });

  /// 1-based step index (e.g. 1 for the first step).
  final int step;
  final int totalSteps;
  final String label;
  final double? customPercentage;

  @override
  Widget build(BuildContext context) {
    final percent = (customPercentage ?? (step / totalSteps)).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextView(
                text: "STEP $step OF $totalSteps — ${label.toUpperCase()}",
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Pallets.blueBubbleColor,
              ),
            ),
            TextView(
              text: "${(percent * 100).round()}%",
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Pallets.grey400,
            ),
          ],
        ),
        6.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 5.h,
            backgroundColor: Pallets.grey90,
            valueColor:
                const AlwaysStoppedAnimation<Color>(Pallets.blueBubbleColor),
          ),
        ),
      ],
    );
  }
}
