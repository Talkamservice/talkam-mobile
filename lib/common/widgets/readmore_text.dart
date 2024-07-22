import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int trimLines;
  final double? fontSize;
  final FontWeight? fontWeight;

  ReadMoreText(
      {required this.text, this.trimLines = 2, this.fontSize, this.fontWeight});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = false;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Colors.blue);

    return Column(
      children: [
        12.verticalSpace,
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
              return TextView(
                text: widget.text,
                fontWeight: widget.fontWeight,
                fontSize: widget.fontSize,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextView(
                  text: _readMore
                      ? widget.text
                      : '${widget.text.substring(0, tp.getPositionForOffset(Offset(size.maxWidth, tp.size.height)).offset)}...',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: widget.fontWeight,
                        fontSize: widget.fontSize,
                      ),
                ),
                InkWell(
                  child: Text(_readMore ? 'Read Less' : 'Read More', style: style),
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
