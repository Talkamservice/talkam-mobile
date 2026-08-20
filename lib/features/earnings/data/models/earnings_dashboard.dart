/// `GET /therapist/earnings/dashboard` (v2). Balance is ledger-derived —
/// there's deliberately no BVN anywhere in this response.
class EarningsDashboard {
  const EarningsDashboard({
    required this.balance,
    required this.currency,
    required this.totals,
    required this.chart,
    required this.tiles,
    required this.recentPayouts,
  });

  final num balance;
  final String currency;
  final EarningsTotals totals;
  final List<EarningsChartPoint> chart;
  final EarningsTiles tiles;
  final List<PayoutSummary> recentPayouts;

  factory EarningsDashboard.fromJson(Map<String, dynamic> json) =>
      EarningsDashboard(
        balance: json['balance'] ?? 0,
        currency: json['currency'] ?? 'NGN',
        totals: EarningsTotals.fromJson(json['totals'] ?? {}),
        chart: (json['chart'] as List? ?? [])
            .map((e) =>
                EarningsChartPoint.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        tiles: EarningsTiles.fromJson(json['tiles'] ?? {}),
        recentPayouts: (json['recent_payouts'] as List? ?? [])
            .map((e) => PayoutSummary.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
}

class EarningsTotals {
  const EarningsTotals({
    required this.thisWeek,
    required this.thisMonth,
    required this.allTime,
  });

  final num thisWeek;
  final num thisMonth;
  final num allTime;

  factory EarningsTotals.fromJson(Map<String, dynamic> json) => EarningsTotals(
        thisWeek: json['this_week'] ?? 0,
        thisMonth: json['this_month'] ?? 0,
        allTime: json['all_time'] ?? 0,
      );
}

class EarningsChartPoint {
  const EarningsChartPoint({required this.date, required this.amount});

  final String date;
  final num amount;

  factory EarningsChartPoint.fromJson(Map<String, dynamic> json) =>
      EarningsChartPoint(
        date: json['date'] ?? '',
        amount: json['amount'] ?? 0,
      );
}

class EarningsTiles {
  const EarningsTiles({
    required this.sessionsThisWeek,
    required this.avgPerSession,
    required this.pendingPayout,
    required this.pendingSettlement,
  });

  final int sessionsThisWeek;
  final num avgPerSession;
  final PendingBucket pendingPayout;
  final PendingBucket pendingSettlement;

  factory EarningsTiles.fromJson(Map<String, dynamic> json) => EarningsTiles(
        sessionsThisWeek: json['sessions_this_week'] ?? 0,
        avgPerSession: json['avg_per_session'] ?? 0,
        pendingPayout: PendingBucket.fromJson(json['pending_payout'] ?? {}),
        pendingSettlement:
            PendingBucket.fromJson(json['pending_settlement'] ?? {}),
      );
}

class PendingBucket {
  const PendingBucket({required this.sessions, required this.amount});

  final int sessions;
  final num amount;

  factory PendingBucket.fromJson(Map<String, dynamic> json) => PendingBucket(
        sessions: json['sessions'] ?? 0,
        amount: json['amount'] ?? 0,
      );
}

class PayoutSummary {
  const PayoutSummary({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
  });

  final int id;
  final String date;
  final num amount;
  final String status;

  factory PayoutSummary.fromJson(Map<String, dynamic> json) => PayoutSummary(
        id: json['id'],
        date: json['date'] ?? '',
        amount: json['amount'] ?? 0,
        status: json['status'] ?? '',
      );
}
