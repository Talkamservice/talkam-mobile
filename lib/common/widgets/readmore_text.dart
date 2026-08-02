import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/helper_utils.dart';

class CustomReadMoreText extends StatefulWidget {
  final dynamic text;
  final int trimLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Function(String mention)? mentionCallback;

  CustomReadMoreText({
    required this.text,
    this.trimLines = 2,
    this.fontSize,
    this.fontWeight,
    this.mentionCallback,
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
      children: [
        3.verticalSpace,
        if(widget.text!=null)
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
              return   Helpers.buildTextWithMentions(widget.text,context,mentionCallback: widget.mentionCallback);
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
