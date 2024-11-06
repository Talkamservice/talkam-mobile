import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:talkam/gen/assets.gen.dart';

class CustomThumbShape extends SliderComponentShape {
  final double thumbSize;

  CustomThumbShape({this.thumbSize = 30.0}); // Adjust thumbSize if needed

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbSize, thumbSize);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {

    const ImageProvider imageProvider = AssetImage('assets/svg/thumb.svg');
    final paint = Paint();

    imageProvider.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        final Rect imageRect = Rect.fromCenter(
          center: center,
          width: thumbSize,
          height: thumbSize,
        );

        context.canvas.drawImageRect(
          imageInfo.image,
          Rect.fromLTWH(0, 0, imageInfo.image.width.toDouble(), imageInfo.image.height.toDouble()),
          imageRect,
          paint,
        );
      }),
    );
  }
}