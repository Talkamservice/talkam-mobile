import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/helper_utils.dart';

class CustomReadMoreText extends StatefulWidget {
  final dynamic text;
  final int trimLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Function(String mention)? mentionCallback;

  /// Space above the text, before it even starts — defaults to matching
  /// existing call sites (post bodies). A caller with its own tighter
  /// spacing above (e.g. a comment sitting right under its name row) can
  /// pass 0 instead, rather than trying to cancel it out with negative
  /// padding from outside, which Flutter's Padding rejects at runtime.
  final double topSpace;

  /// Overrides the text's line-height multiplier — null keeps the theme's
  /// own bodyMedium height (existing behavior everywhere). A tighter value
  /// (e.g. 1) trims the font's built-in leading above the first line, which
  /// [topSpace] alone doesn't reach since it's space added before the text,
  /// not the text's own natural line box.
  final double? lineHeight;

  CustomReadMoreText({
    required this.text,
    this.trimLines = 2,
    this.fontSize,
    this.fontWeight,
    this.mentionCallback,
    this.topSpace = 3,
    this.lineHeight,
  });

  @override
  _CustomReadMoreTextState createState() => _CustomReadMoreTextState();
}

class _CustomReadMoreTextState extends State<CustomReadMoreText> {
  bool _readMore = false;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.blue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.topSpace.h),
        if (widget.text != null)
          LayoutBuilder(
            builder: (context, size) {
              final span = TextSpan(
                text: widget.text,
                style: Theme.of(context).textTheme.bodyMedium,
              );

              final tp = TextPainter(
                text: span,
                maxLines: widget.trimLines,
                textDirection: TextDirection.ltr,
              )..layout(maxWidth: size.maxWidth);

              if (!tp.didExceedMaxLines) {
                return Helpers.buildTextWithMentions(widget.text, context,
                    fontSize: widget.fontSize,
                    fontWeight: widget.fontWeight,
                    height: widget.lineHeight,
                    mentionCallback: widget.mentionCallback);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Helpers.buildTextWithMentions(
                    _readMore
                        ? widget.text
                        : '${widget.text.substring(0, tp.getPositionForOffset(Offset(size.maxWidth, tp.size.height)).offset)}...',
                    context,
                    fontSize: widget.fontSize,
                    fontWeight: widget.fontWeight,
                    height: widget.lineHeight,
                    mentionCallback: widget.mentionCallback,
                  ),
                  8.verticalSpace,
                  InkWell(
                    child: Text(
                      _readMore ? 'Read less' : 'Read more',
                      style: style,
                    ),
                    onTap: () {
                      setState(() {
                        _readMore = !_readMore;
                      });
                    },
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
