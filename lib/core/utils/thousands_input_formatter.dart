import 'package:flutter/services.dart';
import 'package:talkam/core/utils/string_extension.dart';

/// Formats a whole-number amount with thousands separators as it is typed:
/// `25000` renders as `25,000`.
///
/// Strips every non-digit rather than only commas. `String.removeCommas()`
/// would leave a locale that groups with `.` intact and corrupt the value —
/// `NumberFormat` follows the ambient locale, so the separator this inserts is
/// not guaranteed to be a comma.
///
/// The bound field therefore always holds a formatted string while the model
/// holds raw digits; callers convert with `.removeCommas()` on the way in.
class ThousandsInputFormatter extends TextInputFormatter {
  const ThousandsInputFormatter({this.maxDigits});

  /// Rejects the edit once the raw digit count would exceed this.
  /// `LengthLimitingTextInputFormatter` counts the separators too, so it
  /// cannot express "at most N digits".
  final int? maxDigits;

  static final _nonDigits = RegExp(r'[^0-9]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(_nonDigits, '');
    if (digits.isEmpty) return const TextEditingValue();
    if (maxDigits != null && digits.length > maxDigits!) return oldValue;
    if (int.tryParse(digits) == null) return oldValue;

    final formatted = digits.formatNumber();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
