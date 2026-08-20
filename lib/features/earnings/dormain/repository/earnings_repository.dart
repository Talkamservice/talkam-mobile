import 'package:talkam/features/earnings/data/models/earnings_dashboard.dart';
import 'package:talkam/features/earnings/data/models/earnings_transaction.dart';
import 'package:talkam/features/earnings/data/models/payout_result.dart';

abstract class EarningsRepository {
  Future<EarningsDashboard> getDashboard();

  Future<EarningsTransactionsPage> getTransactions({int page = 1});

  /// Withdraws the full available balance (subject to a config-driven
  /// minimum) — there's no amount to pass. Debits the ledger and starts the
  /// Flutterwave transfer immediately; a webhook resolves success/failure
  /// server-side afterward.
  Future<PayoutResult> withdraw();

  Future<PayoutResult> getPayoutStatus(int payoutId);
}
