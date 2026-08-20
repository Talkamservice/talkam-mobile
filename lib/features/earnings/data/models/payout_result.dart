/// Shared shape for `POST /therapist/payouts` (Withdraw) and
/// `GET /therapist/payouts/{id}` (Payout Status) — the latter just adds
/// `completed_at` once resolved.
class PayoutResult {
  const PayoutResult({
    required this.id,
    required this.amount,
    required this.status,
    this.providerRef,
    this.completedAt,
  });

  final int id;
  final String amount;

  /// pending | successful | failed. On failure the ledger debit is
  /// reversed server-side — retrying just means withdrawing again.
  final String status;
  final String? providerRef;
  final String? completedAt;

  bool get isPending => status == 'pending';
  bool get isSuccessful => status == 'successful' || status == 'completed';
  bool get isFailed => status == 'failed';

  factory PayoutResult.fromJson(Map<String, dynamic> json) => PayoutResult(
        id: json['id'],
        amount: json['amount']?.toString() ?? '0',
        status: json['status'] ?? '',
        providerRef: json['provider_ref'],
        completedAt: json['completed_at'],
      );
}
