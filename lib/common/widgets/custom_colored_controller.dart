import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomColoredTextController extends TextEditingController {
  final int maxText;

  CustomColoredTextController({required this.maxText});

  @override
  TextSpan buildTextSpan({BuildContext? context, TextStyle? style, required bool withComposing}) {
    final text = this.text;

    // Split text based on maxText value
    final firstPart = text.length > maxText ? text.substring(0, maxText) : text;
    final remainingPart = text.length > maxText ? text.substring(maxText) : '';

    return TextSpan(
      style: style,
      children: [
        TextSpan(
          text: firstPart,
          style: const TextStyle(color: Colors.black),
        ),
        if (remainingPart.isNotEmpty)
          TextSpan(
            text: remainingPart,
            style: const TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}

