import 'package:flutter/material.dart';



class CustomThumbShape extends SliderComponentShape {
  final double thumbSize;
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;
  ImageInfo? _currentImageInfo;

  CustomThumbShape({this.thumbSize = 20.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbSize, thumbSize);
  }

  void _resolveImage() {
    const ImageProvider imageProvider = AssetImage('assets/images/png/thumb.png');
    final ImageStream newStream = imageProvider.resolve(const ImageConfiguration());

    if (_imageStream?.key != newStream.key) {
      // Remove old listener if it exists
      _imageStream?.removeListener(_imageStreamListener!);

      // Set up new stream and listener
      _imageStream = newStream;
      _imageStreamListener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        _currentImageInfo = imageInfo;
      });

      _imageStream!.addListener(_imageStreamListener!);
    }
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
    final canvas = context.canvas;
    _resolveImage();

    if (_currentImageInfo != null) {
      final Rect imageRect = Rect.fromCenter(
        center: center,
        width: 30,
        height: 20,
      );

      canvas.drawImageRect(
        _currentImageInfo!.image,
        Rect.fromLTWH(0, 0, _currentImageInfo!.image.width.toDouble(), _currentImageInfo!.image.height.toDouble()),
        imageRect,
        Paint(),
      );
    }
  }

  void dispose() {
    // Clean up listeners to avoid memory leaks
    _imageStream?.removeListener(_imageStreamListener!);
  }
}


class CustomRangeSliderThumbImage extends RangeSliderThumbShape {
  final ImageProvider image;
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;
  ImageInfo? _currentImageInfo;

  CustomRangeSliderThumbImage({required this.image});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(30.0, 30.0); // Customize the thumb size
  }

  void _resolveImage() {
    final ImageStream newStream = image.resolve(const ImageConfiguration());

    if (_imageStream?.key != newStream.key) {
      _imageStream?.removeListener(_imageStreamListener!);
      _imageStream = newStream;
      _imageStreamListener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        _currentImageInfo = imageInfo;
      });
      _imageStream!.addListener(_imageStreamListener!);
    }
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
    _resolveImage();

    if (_currentImageInfo != null) {
      paintImage(
        canvas: canvas,
        rect: Rect.fromCenter(center: center, width: 30.0, height: 30.0),
        image: _currentImageInfo!.image,
        fit: BoxFit.contain,
      );
    }
  }


}

