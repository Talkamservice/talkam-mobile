import 'package:flutter_test/flutter_test.dart';
import 'package:talkam/features/therapist/data/models/session_rate.dart';

void main() {
  group('SessionRate.error', () {
    test('empty is reported as empty, not as a parse failure', () {
      expect(const SessionRate('').error, SessionRateError.empty);
      expect(const SessionRate('   ').error, SessionRateError.empty);
    });

    test('non-numeric input is reported', () {
      expect(const SessionRate('abc').error, SessionRateError.notANumber);
      expect(const SessionRate('25,000').error, SessionRateError.notANumber);
    });

    test('boundaries', () {
      expect(SessionRate('${SessionRate.min - 1}').error,
          SessionRateError.belowMin);
      expect(SessionRate('${SessionRate.min}').error, isNull);
      expect(SessionRate('${SessionRate.max}').error, isNull);
      expect(SessionRate('${SessionRate.max + 1}').error,
          SessionRateError.aboveMax);
    });

    test('zero is rejected — a free "paid" session is not a valid rate', () {
      expect(const SessionRate('0').error, SessionRateError.belowMin);
    });

    test('tolerates surrounding whitespace and leading zeros', () {
      expect(const SessionRate(' 25000 ').isValid, isTrue);
      expect(const SessionRate('025000').amount, 25000);
    });

    test('the rates the seeded therapists charge are valid', () {
      // The previous ₦20,000 ceiling rejected every one of these.
      for (final rate in ['25000', '20000', '30000']) {
        expect(SessionRate(rate).isValid, isTrue, reason: rate);
      }
    });
  });

  group('SessionRate.therapistEarnings', () {
    test('applies the platform fee', () {
      expect(const SessionRate('25000').therapistEarnings, 21250);
      expect(const SessionRate('10000').therapistEarnings, 8500);
    });

    test('is zero while the rate is invalid', () {
      expect(const SessionRate('').therapistEarnings, 0);
      expect(const SessionRate('10').therapistEarnings, 0);
    });

    test('rounds rather than truncates', () {
      // 5001 * 0.85 = 4250.85
      expect(const SessionRate('5001').therapistEarnings, 4251);
    });
  });
}
