import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:talkam/features/earnings/data/models/earnings_dashboard.dart';
import 'package:talkam/features/earnings/data/models/earnings_transaction.dart';
import 'package:talkam/features/earnings/data/models/payout_result.dart';
import 'package:talkam/features/earnings/dormain/repository/earnings_repository.dart';

enum LoadStatus { idle, loading, success, error }

class EarningsState {
  const EarningsState({
    this.dashboardStatus = LoadStatus.idle,
    this.dashboard,
    this.dashboardError,
    this.transactionsStatus = LoadStatus.idle,
    this.transactions = const [],
    this.transactionsCanLoadMore = false,
    this.transactionsPage = 1,
    this.transactionsError,
    this.withdrawing = false,
  });

  final LoadStatus dashboardStatus;
  final EarningsDashboard? dashboard;
  final String? dashboardError;

  final LoadStatus transactionsStatus;
  final List<EarningsTransaction> transactions;
  final bool transactionsCanLoadMore;
  final int transactionsPage;
  final String? transactionsError;

  final bool withdrawing;

  EarningsState copyWith({
    LoadStatus? dashboardStatus,
    EarningsDashboard? dashboard,
    String? dashboardError,
    LoadStatus? transactionsStatus,
    List<EarningsTransaction>? transactions,
    bool? transactionsCanLoadMore,
    int? transactionsPage,
    String? transactionsError,
    bool? withdrawing,
  }) =>
      EarningsState(
        dashboardStatus: dashboardStatus ?? this.dashboardStatus,
        dashboard: dashboard ?? this.dashboard,
        dashboardError: dashboardError,
        transactionsStatus: transactionsStatus ?? this.transactionsStatus,
        transactions: transactions ?? this.transactions,
        transactionsCanLoadMore:
            transactionsCanLoadMore ?? this.transactionsCanLoadMore,
        transactionsPage: transactionsPage ?? this.transactionsPage,
        transactionsError: transactionsError,
        withdrawing: withdrawing ?? this.withdrawing,
      );
}

/// Drives the Earnings dashboard, the full transactions list, and the
/// Withdraw flow against the real v2 `/therapist/earnings*`/`/therapist/payouts`
/// endpoints. Screen-scoped, constructed locally like the other
/// wizard/session/client cubits in this app.
class EarningsCubit extends Cubit<EarningsState> {
  final EarningsRepository _repository;

  EarningsCubit(this._repository) : super(const EarningsState());

  Future<void> getDashboard() async {
    emit(state.copyWith(dashboardStatus: LoadStatus.loading));
    try {
      final dashboard = await _repository.getDashboard();
      emit(state.copyWith(
        dashboardStatus: LoadStatus.success,
        dashboard: dashboard,
      ));
    } catch (e) {
      emit(state.copyWith(
        dashboardStatus: LoadStatus.error,
        dashboardError: e.toString(),
      ));
    }
  }

  Future<void> getTransactions({bool loadMore = false}) async {
    final page = loadMore ? state.transactionsPage + 1 : 1;
    emit(state.copyWith(transactionsStatus: LoadStatus.loading));
    try {
      final result = await _repository.getTransactions(page: page);
      emit(state.copyWith(
        transactionsStatus: LoadStatus.success,
        transactions: loadMore
            ? [...state.transactions, ...result.transactions]
            : result.transactions,
        transactionsCanLoadMore: result.canLoadMore,
        transactionsPage: result.currentPage,
      ));
    } catch (e) {
      emit(state.copyWith(
        transactionsStatus: LoadStatus.error,
        transactionsError: e.toString(),
      ));
    }
  }

  /// Initiates a withdrawal, then briefly polls the payout's status since
  /// the withdraw call itself always comes back "pending" (the transfer
  /// resolves async via a server-side webhook). Gives up after ~10s and
  /// returns whatever the last-seen status was, rather than blocking the UI
  /// indefinitely — the balance/recent-payouts list will reflect the true
  /// outcome once the dashboard is next refreshed either way.
  Future<PayoutResult> withdrawAndAwaitResult() async {
    emit(state.copyWith(withdrawing: true));
    try {
      var result = await _repository.withdraw();
      for (var attempt = 0; result.isPending && attempt < 5; attempt++) {
        await Future.delayed(const Duration(seconds: 2));
        result = await _repository.getPayoutStatus(result.id);
      }
      emit(state.copyWith(withdrawing: false));
      // Refresh so the balance/recent-payouts list reflects the debit (and
      // its reversal if the payout ended up failing).
      unawaited(getDashboard());
      return result;
    } catch (e) {
      emit(state.copyWith(withdrawing: false));
      rethrow;
    }
  }
}
