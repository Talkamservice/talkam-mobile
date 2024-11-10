import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:talkam/gen/assets.gen.dart';

class CustomThumbShape extends SliderComponentShape {
  final double thumbSize;

  CustomThumbShape({this.thumbSize = 20.0}); // Adjust thumbSize if needed

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
    const ImageProvider imageProvider = AssetImage('assets/images/png/thumb.png');
    final paint = Paint();

    imageProvider.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        final Rect imageRect = Rect.fromCenter(
          center: center,
          width: 30,
          height: 20,
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

class CustomRangeSliderThumbImage extends RangeSliderThumbShape {
  final ImageProvider image;

  CustomRangeSliderThumbImage({required this.image});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(30.0, 30.0); // Customize the thumb size
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool? isDiscrete,
        bool? isEnabled,
        bool? isOnTop,
        TextDirection? textDirection,
        required SliderThemeData sliderTheme,
        Thumb? thumb,
        bool? isPressed,
      }) {
    final canvas = context.canvas;
    final thumbImage = image.resolve(ImageConfiguration());

    thumbImage.addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        paintImage(
          canvas: canvas,
          rect: Rect.fromCenter(center: center, width: 30.0, height: 30.0),
          image: imageInfo.image,
          fit: BoxFit.contain,
        );
      }),
    );
  }
}
