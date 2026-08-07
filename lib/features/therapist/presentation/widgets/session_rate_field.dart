import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/core/utils/thousands_input_formatter.dart';
import 'package:talkam/features/therapist/data/models/session_rate.dart';

/// Naira session rate with live validation and a net-earnings preview.
class SessionRateField extends StatelessWidget {
  const SessionRateField({
    super.key,
    required this.controller,
    required this.rate,
    required this.sessionDurationMinutes,
    required this.onChanged,
    this.showError = false,
  });

  final TextEditingController controller;
  final SessionRate rate;

  /// Drives the label, so "per 50 min" can never drift from the configured
  /// session length.
  final int sessionDurationMinutes;

  /// Receives raw digits — separators are stripped before this is called.
  final ValueChanged<String> onChanged;

  /// Errors stay hidden until the field is touched or Save is attempted.
  final bool showError;

  static String _naira(int amount) => "₦${amount.toString().formatNumber()}";

  String? get _errorText {
    switch (rate.error) {
      case null:
        return null;
      case SessionRateError.empty:
        return "Enter your session rate.";
      case SessionRateError.notANumber:
        return "Enter a valid amount.";
      case SessionRateError.belowMin:
        return "Minimum session rate is ${_naira(SessionRate.min)}.";
      case SessionRateError.aboveMax:
        return "Maximum session rate is ${_naira(SessionRate.max)}.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final touched = !rate.isEmpty;
    final showsError = (touched || showError) && !rate.isValid;
    final feePercent = (SessionRate.platformFeeRate * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: "Session Rate (per $sessionDurationMinutes min)",
          hint: "${_naira(SessionRate.min)} - ${_naira(SessionRate.max)}",
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: const [ThousandsInputFormatter(maxDigits: 7)],
          forceError: showsError,
          forceValid: touched && rate.isValid,
          prefixIcon: SizedBox(
            width: 36.w,
            child: Center(
              child: TextView(
                text: "₦",
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Pallets.grey400,
              ),
            ),
          ),
          onChanged: (value) => onChanged(value.replaceAll(RegExp(r'[^0-9]'), '')),
        ),
        6.verticalSpace,
        if (showsError)
          TextView(
            text: _errorText ?? '',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Pallets.errorRed,
          )
        else if (rate.isValid)
          TextView(
            text: "You'll receive ${_naira(rate.therapistEarnings)} per "
                "session after the $feePercent% platform fee.",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Pallets.successGreen,
            lineHeight: 1.4,
          ),
      ],
    );
  }
}
