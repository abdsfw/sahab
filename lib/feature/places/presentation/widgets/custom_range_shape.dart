import 'package:flutter/material.dart';

class CustomRangeThumbShape extends RangeSliderThumbShape {
  static const double _thumbSize = 24.0;
  static const double _borderRadius = 5.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(_thumbSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    bool? isPressed,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
    Thumb thumb = Thumb.start,
  }) {
    final Canvas canvas = context.canvas;
    final double size = _thumbSize;

    Paint paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    // Draw rounded rectangle using RRect
    RRect thumbRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: size,
        height: size,
      ),
      Radius.circular(_borderRadius),
    );

    canvas.drawRRect(thumbRRect, paint);
  }
}
