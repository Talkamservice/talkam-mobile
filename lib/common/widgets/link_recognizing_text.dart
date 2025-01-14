import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkRecognizingText extends StatelessWidget {
  final String text;
  final Color? linkColor;
  final Color? mainTextColor;
  final double? fontSize;
  final TextStyle? linkTextStyle;
  final TextStyle? mainTextStyle;
  final FontWeight? fontWeight;

  const LinkRecognizingText({
    Key? key,
    required this.text,
    this.linkColor,
    this.mainTextColor,
    this.fontSize,
    this.linkTextStyle,
    this.mainTextStyle,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultMainTextStyle = GoogleFonts.nunito(
      fontSize: fontSize ?? 16.0,
      color: mainTextColor ?? Colors.black,
      fontWeight: fontWeight,
    );

    final defaultLinkTextStyle = GoogleFonts.nunito(
      color: linkColor ?? Colors.blue,
      decoration: TextDecoration.underline,
      fontWeight: fontWeight,
    );

    final linkRegex = RegExp(
      r'((http|https):\/\/[^\s]+)|(www\.[^\s]+)|([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)',
    );

    final matches = linkRegex.allMatches(text);
    final spans = <TextSpan>[];
    int start = 0;

    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: mainTextStyle ?? defaultMainTextStyle,
        ));
      }

      final matchedText = match.group(0)!;
      spans.add(TextSpan(
        text: matchedText,
        style: linkTextStyle ?? defaultLinkTextStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final uri = Uri.parse(
              matchedText.startsWith('http') ? matchedText : 'https://$matchedText',
            );
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Could not open link: $matchedText")),
              );
            }
          },
      ));
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: mainTextStyle ?? defaultMainTextStyle,
      ));
    }

    return GestureDetector(

      onLongPress: () {

        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Copied to clipboard!")),
        );
      },
      child: SelectableText.rich(
        TextSpan(children: spans),
      ),
    );
  }
}
