import 'dart:ui';

import 'package:flutter/material.dart';

class RoundedSliderTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 2.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool isEnabled = false,
      bool isDiscrete = false,
      required TextDirection textDirection}) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint activeTrackPaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? Colors.blue
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final Paint inactiveTrackPaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.grey
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final Radius trackRadius = Radius.circular(trackRect.height / 2);

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
            trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom),
        trackRadius,
      ),
      activeTrackPaint,
    );

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
            thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom),
        trackRadius,
      ),
      inactiveTrackPaint,
    );
  }

// @override
// void paint(
//   PaintingContext context,
//   Offset offset, {
//   required RenderBox parentBox,
//   required SliderThemeData sliderTheme,
//   required Animation<double> enableAnimation,
//   required TextDirection textDirection,
//   required Offset thumbCenter,
//   bool isEnabled = false,
//   bool isDiscrete = false,
//   required double additionalActiveTrackHeight,
// }) {
//   if (sliderTheme.trackHeight == 0) {
//     return;
//   }
//
//   final Rect trackRect = getPreferredRect(
//     parentBox: parentBox,
//     offset: offset,
//     sliderTheme: sliderTheme,
//     isEnabled: isEnabled,
//     isDiscrete: isDiscrete,
//   );
//
//   final Paint activeTrackPaint = Paint()
//     ..color = sliderTheme.activeTrackColor ?? Colors.blue
//     ..style = PaintingStyle.fill
//     ..strokeCap = StrokeCap.round;
//
//   final Paint inactiveTrackPaint = Paint()
//     ..color = sliderTheme.inactiveTrackColor ?? Colors.grey
//     ..style = PaintingStyle.fill
//     ..strokeCap = StrokeCap.round;
//
//   final Radius trackRadius = Radius.circular(trackRect.height / 2);
//
//   context.canvas.drawRRect(
//     RRect.fromRectAndRadius(
//       Rect.fromLTRB(
//           trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom),
//       trackRadius,
//     ),
//     activeTrackPaint,
//   );
//
//   context.canvas.drawRRect(
//     RRect.fromRectAndRadius(
//       Rect.fromLTRB(
//           thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom),
//       trackRadius,
//     ),
//     inactiveTrackPaint,
//   );
// }
}
