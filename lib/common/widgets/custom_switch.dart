import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Pill toggle with a large white thumb, matching the Talkam design.
///
/// Material's [Switch] can't produce this shape — its thumb is small relative
/// to the track and it adds its own tap padding — so this is drawn directly.
class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = Pallets.blueBubbleColor,
    this.inactiveColor = Pallets.grey90,
    this.width,
    this.height,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final trackWidth = width ?? 52.w;
    final trackHeight = height ?? 30.w;
    final padding = trackHeight * 0.11;
    final thumbSize = trackHeight - (padding * 2);

    final isEnabled = onChanged != null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isEnabled ? () => onChanged!(!value) : null,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.5,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: trackWidth*1.1,
          height: trackHeight,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: value ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: thumbSize*1.3,
              height: thumbSize,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(14.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
