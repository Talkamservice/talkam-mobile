import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;

  /// Forces the red error style regardless of [validator] — for live
  /// validation that isn't driven by an ancestor [Form] (e.g. an account
  /// number checked as the user types). Mirrors OtpField's `hasError`.
  final bool forceError;

  /// Forces a green "looks good" style. Ignored when [forceError] is true.
  final bool forceValid;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.forceError = false,
    this.forceValid = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final hasError = widget.forceError || _hasError;
    final isValid = !hasError && widget.forceValid;
    final activeColor =
        hasError ? Pallets.errorRed : (isValid ? Pallets.successGreen : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          TextView(
            text: widget.label!,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Pallets.boldBlackV2,
          ),
          8.verticalSpace,
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          inputFormatters: widget.inputFormatters,
          textAlignVertical: (widget.maxLines ?? 1) > 1
              ? TextAlignVertical.top
              : TextAlignVertical.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: Pallets.boldBlack,
            fontWeight: FontWeight.w500,
          ),
          validator: (val) {
            final error = widget.validator?.call(val);
            // Update error state after the frame so setState is safe inside build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() => _hasError = error != null);
              }
            });
            return error;
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Pallets.grey75,
              fontWeight: FontWeight.w400,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            filled: true,
            fillColor: hasError
                ? Pallets.errorRed.withOpacity(0.06)
                : (isValid
                    ? Pallets.successGreen.withOpacity(0.06)
                    : Colors.white),
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: activeColor ?? Pallets.grey90,
                width: activeColor != null ? 1.5 : 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: activeColor ?? Pallets.grey90,
                width: activeColor != null ? 1.5 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: activeColor ?? Pallets.blueBubbleColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: Pallets.errorRed, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide:
                  const BorderSide(color: Pallets.errorRed, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
