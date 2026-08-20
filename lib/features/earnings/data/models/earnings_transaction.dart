/// `GET /therapist/earnings/transactions` (v2) — paginated ledger: one
/// credit per completed session, one debit per payout.
class EarningsTransactionsPage {
  const EarningsTransactionsPage({
    required this.transactions,
    required this.canLoadMore,
    required this.currentPage,
  });

  final List<EarningsTransaction> transactions;
  final bool canLoadMore;
  final int currentPage;

  factory EarningsTransactionsPage.fromJson(Map<String, dynamic> json) {
    final meta = json['pagination_meta'] ?? {};
    return EarningsTransactionsPage(
      transactions: (json['data'] as List? ?? [])
          .map(
              (e) => EarningsTransaction.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      canLoadMore: meta['can_load_more'] ?? false,
      currentPage: meta['current_page'] ?? 1,
    );
  }
}

class EarningsTransaction {
  const EarningsTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.status,
    required this.reference,
    required this.createdAt,
  });

  final int id;

  /// "credit" (a completed session's earning) or "debit" (a payout).
  final String type;
  final String amount;
  final String status;
  final String reference;
  final String createdAt;

  bool get isCredit => type == 'credit';

  factory EarningsTransaction.fromJson(Map<String, dynamic> json) =>
      EarningsTransaction(
        id: json['id'],
        type: json['type'] ?? '',
        amount: json['amount']?.toString() ?? '0',
        status: json['status'] ?? '',
        reference: json['reference'] ?? '',
        createdAt: json['created_at'] ?? '',
      );
}
