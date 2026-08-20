// Model for GET /user/bookings/:id/receipt

class SessionReceiptSummary {
  final String startsAt;
  final int durationMinutes;
  final String format;
  final String? therapistName;

  const SessionReceiptSummary({
    required this.startsAt,
    required this.durationMinutes,
    required this.format,
    this.therapistName,
  });

  factory SessionReceiptSummary.fromJson(Map<String, dynamic> json) =>
      SessionReceiptSummary(
        startsAt: json['starts_at']?.toString() ?? '',
        durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
        format: json['format']?.toString() ?? '',
        therapistName: json['therapist_name']?.toString(),
      );
}

class SessionReceipt {
  final String reference;
  final String amount;
  final String? fees;
  final String currency;
  final String? narration;
  final String? paidAt;
  final SessionReceiptSummary session;

  const SessionReceipt({
    required this.reference,
    required this.amount,
    this.fees,
    required this.currency,
    this.narration,
    this.paidAt,
    required this.session,
  });

  factory SessionReceipt.fromJson(Map<String, dynamic> json) => SessionReceipt(
        reference: json['reference']?.toString() ?? '',
        amount: json['amount']?.toString() ?? '',
        fees: json['fees']?.toString(),
        currency: json['currency']?.toString() ?? '',
        narration: json['narration']?.toString(),
        paidAt: json['paid_at']?.toString(),
        session: SessionReceiptSummary.fromJson(
            json['session'] as Map<String, dynamic>? ?? {}),
      );
}
