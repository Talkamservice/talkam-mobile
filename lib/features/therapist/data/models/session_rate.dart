import 'package:equatable/equatable.dart';

enum SessionRateError { empty, notANumber, belowMin, aboveMax }

/// What a therapist charges for one session, held as raw digits.
///
/// Digits rather than an `int` because the field it backs is free text: the
/// user can transiently have an empty or unparseable value, and collapsing
/// that to `0` would make "not filled in yet" indistinguishable from "free".
class SessionRate extends Equatable {
  const SessionRate(this.raw);

  const SessionRate.empty() : raw = '';

  /// Digits only — commas are stripped on the way in.
  final String raw;

  /// Bounds are shared with the onboarding payout step so the two surfaces
  /// cannot diverge.
  static const int min = 5000;
  static const int max = 20000;

  /// Share of the session fee the platform keeps.
  static const double platformFeeRate = 0.15;

  int? get amount => int.tryParse(raw.trim());

  bool get isEmpty => raw.trim().isEmpty;

  bool get isValid => error == null;

  SessionRateError? get error {
    if (isEmpty) return SessionRateError.empty;
    final value = amount;
    if (value == null) return SessionRateError.notANumber;
    if (value < min) return SessionRateError.belowMin;
    if (value > max) return SessionRateError.aboveMax;
    return null;
  }

  /// What the therapist keeps per session. Single source of truth for the
  /// split — the onboarding payout screen reads this rather than re-deriving
  /// its own `* 0.85`.
  int get therapistEarnings =>
      isValid ? (amount! * (1 - platformFeeRate)).round() : 0;

  @override
  List<Object?> get props => [raw];
}
