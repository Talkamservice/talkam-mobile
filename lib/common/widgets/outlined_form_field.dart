import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

class OutlinedFormField extends StatefulWidget {
  const OutlinedFormField(
      {super.key,
      required this.hint,
      this.suffix,
      this.validator,
      this.preffix,
      this.textCapitalization = TextCapitalization.none,
      this.maxLine,
      this.inputType,
      this.obscure,
      this.controller,
      this.onChange,
      this.onFieldSubmitted,
      this.enabled,
      this.inputFormatters,
      this.placeHolder,
      this.showRequiredAsterics = false,
      this.maxLength,
      this.radius,
      this.fillColor,
      this.filled,
      this.padding,
      this.hintStyle,
      this.minLine});

  final String hint;
 final TextCapitalization textCapitalization;
  final String? placeHolder;
  final bool? showRequiredAsterics;
  final bool? obscure;
  final Widget? suffix;
  final Widget? preffix;
  final int? maxLine;
  final int? minLine;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Function(String d)? onChange;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final double? radius;
  final bool? filled;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;

  final Color? fillColor;

  @override
  State<OutlinedFormField> createState() => _OutlinedFormFieldState();
}

class _OutlinedFormFieldState extends State<OutlinedFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: widget.placeHolder != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextView(
                            text: widget.placeHolder!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          if (widget.showRequiredAsterics!)
                            TextView(
                              text: " *",
                              fontSize: 15.sp,
                              color: Pallets.red,
                              fontWeight: FontWeight.w600,
                            ),
                        ],
                      )
                    : 0.verticalSpace,
              ),
              if (widget.maxLength != null)
                TextView(
                    text:
                        "${widget.controller?.text.length ?? 0}/${widget.maxLength}")
            ],
          ),
          8.verticalSpace,
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            maxLines: widget.maxLine ?? 1,
            minLines: widget.minLine ?? 1,
            onChanged: widget.onChange,
            keyboardType: widget.inputType,
            onFieldSubmitted: widget.onFieldSubmitted,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength ?? 200000,
            obscureText: widget.obscure == null ? false : widget.obscure!,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14.sp),
            decoration: InputDecoration(
                filled: widget.filled ?? false,
                counter: 0.verticalSpace,
                focusedBorder: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10)),
                border: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide:
                        const BorderSide(color: Pallets.borderGrey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                fillColor: widget.fillColor ?? Theme.of(context).cardColor,
                hintText: widget.hint,
                suffixIcon: widget.suffix,
                prefixIcon: widget.preffix,
                iconColor: Colors.grey,
                enabled: widget.enabled ?? true,
                prefixIconColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide:
                        const BorderSide(color: Pallets.borderGrey, width: 1),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10)),
                contentPadding: widget.padding ??
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                suffixIconColor: Pallets.grey75,
                hintStyle: widget.hintStyle ??
                    TextStyle(
                        color: Pallets.grey75,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
