import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

class CustomButton extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final bool? isExpanded;
  final BorderRadius? borderRadius;
  final double? elevation;
  final String? text;

  const CustomButton(
      {Key? key,
      this.child,
      required this.onPressed,
      this.bgColor,
      this.padding,
      this.isExpanded = true,
      this.foregroundColor,
      this.borderRadius,
      this.elevation,
      this.text})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            flex: widget.isExpanded! ? 1 : 0,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                elevation: widget.elevation,
                padding: widget.padding ?? const EdgeInsets.all(16),
                foregroundColor: widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r)),
                disabledBackgroundColor: widget.bgColor == null ? Theme.of(context).colorScheme.primary.withAlpha(-200) : widget.bgColor!.withAlpha(-200),
                backgroundColor: widget.bgColor ?? Pallets.blueBubbleColor,
              ),
              child: widget.child ??
                  TextView(
                    text: widget.text ?? "Button",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: context.colorScheme.onPrimary,
                  ),
            )),
      ],
    );
  }
}
