import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

class CustomOutlinedButton extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? outlinedColr; // Backward compatibility alias
  final Color? foregroundColor;
  final Color? foreGroundColor; // Backward compatibility alias
  final Color? bgColor; // Backward compatibility
  final EdgeInsetsGeometry? padding;
  final bool? isExpanded;
  final BorderRadius? borderRadius;
  final double? radius; // Backward compatibility alias
  final double? borderWidth;
  final double? outlineWidth; // Backward compatibility alias
  final String? text;

  const CustomOutlinedButton({
    Key? key,
    this.child,
    required this.onPressed,
    this.borderColor,
    this.outlinedColr,
    this.padding,
    this.isExpanded = true,
    this.foregroundColor,
    this.foreGroundColor,
    this.bgColor,
    this.borderRadius,
    this.radius,
    this.borderWidth,
    this.outlineWidth,
    this.text,
  }) : super(key: key);

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        widget.borderColor ?? widget.outlinedColr ?? Pallets.borderGrey;
    final effectiveBorderWidth =
        widget.borderWidth ?? widget.outlineWidth ?? 1.5;
    final effectiveRadius = widget.borderRadius ??
        (widget.radius != null
            ? BorderRadius.circular(widget.radius!)
            : BorderRadius.circular(14.r));
    final effectiveFgColor = widget.foregroundColor ??
        widget.foreGroundColor ??
        Theme.of(context).colorScheme.onPrimary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: widget.isExpanded! ? 1 : 0,
          child: OutlinedButton(
            onPressed: widget.onPressed,
            style: OutlinedButton.styleFrom(
              padding: widget.padding ?? const EdgeInsets.all(14),
              foregroundColor: effectiveFgColor,
              backgroundColor: widget.bgColor,
              side: BorderSide(
                color: effectiveBorderColor,
                width: effectiveBorderWidth,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: effectiveRadius,
              ),
            ),
            child: widget.child ??
                TextView(
                  text: widget.text ?? "Button",
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: effectiveFgColor,
                ),
          ),
        ),
      ],
    );
  }
}
