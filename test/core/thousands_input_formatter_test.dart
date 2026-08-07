import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talkam/core/utils/thousands_input_formatter.dart';

TextEditingValue _v(String text) => TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );

String _format(String input, {String previous = '', int? maxDigits}) =>
    ThousandsInputFormatter(maxDigits: maxDigits)
        .formatEditUpdate(_v(previous), _v(input))
        .text;

void main() {
  group('ThousandsInputFormatter', () {
    test('groups thousands', () {
      expect(_format('1'), '1');
      expect(_format('1000'), '1,000');
      expect(_format('25000'), '25,000');
      expect(_format('1000000'), '1,000,000');
    });

    test('deleting to empty yields empty, not a placeholder', () {
      expect(_format('', previous: '1,000'), '');
    });

    test('re-formats already-grouped input idempotently', () {
      // The field holds the formatted string, so every keystroke re-enters it.
      expect(_format('25,000'), '25,000');
      expect(_format('25,000', previous: '25,000'), '25,000');
    });

    test('strips non-digits rather than only commas', () {
      // A locale grouping with '.' would otherwise survive and corrupt the
      // value; pasted currency symbols would too.
      expect(_format('₦25,000'), '25,000');
      expect(_format('25.000'), '25,000');
      expect(_format('2a5b0c0d0'), '25,000');
    });

    test('maxDigits rejects the edit and keeps the previous value', () {
      expect(_format('12345678', previous: '1,234,567', maxDigits: 7),
          '1,234,567');
      expect(_format('1234567', maxDigits: 7), '1,234,567');
    });

    test('places the caret at the end', () {
      final result = const ThousandsInputFormatter()
          .formatEditUpdate(_v(''), _v('25000'));
      expect(result.selection.baseOffset, result.text.length);
    });
  });
}
