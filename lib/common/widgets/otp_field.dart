import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../core/theme/pallets.dart';

class OtpField extends StatelessWidget {
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool useNativeKeyboard;
  final bool obscureText;
  final int count;
  final TextEditingController? controller;

  /// Forces the red error styling on the boxes — use it to reflect a failed
  /// verification coming back from the API, not just local validation.
  final bool hasError;

  const OtpField({
    Key? key,
    this.onCompleted,
    this.validator,
    this.count = 4,
    this.obscureText = false,
    this.useNativeKeyboard = true,
    this.controller,
    this.onChanged,
    this.hasError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Shrink the boxes when there are more of them so 6 digits still fit
    // inside the 24.w screen gutters on narrow devices.
    final boxWidth = count > 4 ? 48.w : 56.w;
    final boxHeight = count > 4 ? 60.h : 64.h;

    final defaultPinTheme = PinTheme(
      width: boxWidth,
      height: boxHeight,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: Pallets.boldBlackV2,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Pallets.grey90, width: 1),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Pallets.blueBubbleColor, width: 1.5),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Pallets.grey75, width: 1),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Pallets.errorRed.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Pallets.errorRed, width: 1.5),
      ),
    );

    return Pinput(
      obscureText: obscureText,
      length: count,
      obscuringWidget: const Text(
        '⬤',
        style: TextStyle(fontSize: 12),
      ),
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      forceErrorState: hasError,
      controller: controller,
      useNativeKeyboard: useNativeKeyboard,

      ///For autofill on otp received
      // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      onChanged: onChanged,

      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      validator: validator,
      onCompleted: onCompleted,
    );
  }
}
