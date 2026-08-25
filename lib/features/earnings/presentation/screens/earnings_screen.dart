import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/features/earnings/data/models/earnings_dashboard.dart';
import 'package:talkam/features/earnings/dormain/repository/earnings_repository.dart';
import 'package:talkam/features/earnings/presentation/bloc/earnings_cubit.dart';

import 'package:talkam/core/navigation/route_url.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  final cubit = EarningsCubit(injector.get<EarningsRepository>());

  @override
  void initState() {
    super.initState();
    cubit.getDashboard();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  static String _naira(num amount) =>
      "₦${amount.toInt().toString().formatNumber()}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        child: BlocBuilder<EarningsCubit, EarningsState>(
          bloc: cubit,
          builder: (context, state) {
            switch (state.dashboardStatus) {
              case LoadStatus.idle:
              case LoadStatus.loading:
                return Center(child: CustomDialogs.getLoading(size: 50));
              case LoadStatus.error:
                return AppErrorWidget(
                  message: state.dashboardError ?? "Something went wrong",
                  onTap: cubit.getDashboard,
                );
              case LoadStatus.success:
                return _buildBody(context, state.dashboard!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, EarningsDashboard dashboard) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Earnings",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlackV2,
              ),
              InkWell(
                onTap: () => context.pushNamed(PageUrl.payoutScreen),
                borderRadius: BorderRadius.circular(24.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Pallets.blueBubbleColor,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_outward,
                        color: Colors.white,
                        size: 16,
                      ),
                      8.horizontalSpace,
                      const TextView(
                        text: "Withdraw",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          24.verticalSpace,

          // Available Payout Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Pallets.blueBubbleColor,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    8.horizontalSpace,
                    const TextView(
                      text: "AVAILABLE PAYOUT",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ],
                ),
                12.verticalSpace,
                TextView(
                  text: _naira(dashboard.balance),
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                4.verticalSpace,
                // Dummy — no endpoint exposes a payout BVN. Kept visible as
                // a placeholder rather than omitted.
                const TextView(
                  text: "BVN: ******11",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                12.verticalSpace,
                Divider(color: Colors.white.withValues(alpha: 0.3), height: 1),
                12.verticalSpace,
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatColumn(
                          title: "This week",
                          amount: _naira(dashboard.totals.thisWeek)),
                      Container(
                          width: 1,
                          height: 40.h,
                          color: Colors.white.withValues(alpha: 0.3)),
                      _StatColumn(
                          title: "This month",
                          amount: _naira(dashboard.totals.thisMonth)),
                      Container(
                          width: 1,
                          height: 40.h,
                          color: Colors.white.withValues(alpha: 0.3)),
                      _StatColumn(
                          title: "All time",
                          amount: _naira(dashboard.totals.allTime)),
                    ],
                  ),
                )
              ],
            ),
          ),
          16.verticalSpace,

          // Warning Info
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xFFF59E0B),
                size: 16,
              ),
              8.horizontalSpace,
              const Expanded(
                child: TextView(
                  text: "Payouts are processed weekly on Wednesdays.",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFD97706),
                ),
              ),
            ],
          ),
          24.verticalSpace,

          // Earnings Chart Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: "Earnings",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Pallets.boldBlackV2,
                        ),
                        // Dummy — no endpoint provides a period label or a
                        // period-over-period change. Kept visible as
                        // placeholders rather than omitted.
                        const TextView(
                          text: "Last 7 days",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9CA3AF),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6FDF4),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: const TextView(
                        text: "+18%",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F9D58),
                      ),
                    ),
                  ],
                ),
                24.verticalSpace,
                SizedBox(
                  height: 120.h,
                  child: _EarningsChart(points: dashboard.chart),
                ),
              ],
            ),
          ),
          24.verticalSpace,

          // 2x2 Grid
          Row(
            children: [
              Expanded(
                // Subtitle is a dummy — no endpoint provides a week-over-week
                // comparison. Kept visible as a placeholder rather than
                // omitted.
                child: _GridCard(
                  title: "Sessions this week",
                  value: dashboard.tiles.sessionsThisWeek.toString(),
                  subtitle: "1 from last week",
                  subtitleColor: Pallets.blueBubbleColor,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                // Subtitle is a dummy — same reason as above.
                child: _GridCard(
                  title: "Avg per session",
                  value: _naira(dashboard.tiles.avgPerSession),
                  subtitle: "Fixed rate",
                  subtitleColor: const Color(0xFF0F9D58),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: _GridCard(
                  title: "Pending payout",
                  value: _naira(dashboard.tiles.pendingPayout.amount),
                  subtitle:
                      "${dashboard.tiles.pendingPayout.sessions} sessions pending",
                  subtitleColor: const Color(0xFFD97706),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: _GridCard(
                  title: "Pending settlement",
                  value: _naira(dashboard.tiles.pendingSettlement.amount),
                  subtitle:
                      "${dashboard.tiles.pendingSettlement.sessions} sessions",
                  subtitleColor: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          32.verticalSpace,

          // Recent Payouts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextView(
                text: "Recent payouts",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Pallets.boldBlackV2,
              ),
              InkWell(
                onTap: () =>
                    context.pushNamed(PageUrl.earningsTransactionsScreen),
                child: const TextView(
                  text: "See all",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Pallets.blueBubbleColor,
                ),
              ),
            ],
          ),
          16.verticalSpace,

          if (dashboard.recentPayouts.isEmpty)
            TextView(
              text: "No payouts yet",
              fontSize: 13,
              color: Pallets.grey400,
            )
          else
            for (final payout in dashboard.recentPayouts) ...[
              _PayoutRow(payout: payout, naira: _naira),
              16.verticalSpace,
            ],
        ],
      ),
    );
  }
}

class _EarningsChart extends StatelessWidget {
  const _EarningsChart({required this.points});

  final List<EarningsChartPoint> points;

  @override
  Widget build(BuildContext context) {
    final maxAmount =
        points.fold<num>(0, (max, p) => p.amount > max ? p.amount : max);
    final maxY = maxAmount <= 0 ? 10.0 : (maxAmount * 1.25).toDouble();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                );
                final index = value.toInt();
                if (index < 0 || index >= points.length) {
                  return const SizedBox.shrink();
                }
                final dt = DateTime.tryParse(points[index].date);
                final isLast = index == points.length - 1;
                final label = isLast
                    ? "Today"
                    : (dt == null ? "" : "${dt.month}/${dt.day}");
                return SideTitleWidget(
                  meta: meta,
                  child: Text(label, style: style),
                );
              },
              reservedSize: 22,
            ),
          ),
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          for (var i = 0; i < points.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: points[i].amount.toDouble(),
                  color: i == points.length - 1
                      ? Pallets.blueBubbleColor
                      : const Color(0xFFE5E7EB),
                  width: 20.w,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    topRight: Radius.circular(4.r),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.title, required this.amount});
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: title,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        8.verticalSpace,
        TextView(
          text: amount,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ],
    );
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.subtitleColor,
  });

  final String title;
  final String value;
  final String subtitle;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
          TextView(
            text: value,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlackV2,
          ),
          TextView(
            text: subtitle,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: subtitleColor,
          ),
        ],
      ),
    );
  }
}

class _PayoutRow extends StatelessWidget {
  const _PayoutRow({required this.payout, required this.naira});

  final PayoutSummary payout;
  final String Function(num) naira;

  @override
  Widget build(BuildContext context) {
    final isPending = payout.status == 'pending';
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color:
                isPending ? const Color(0xFFFFFBEB) : const Color(0xFFFEF2F2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_outward,
            color:
                isPending ? const Color(0xFFD97706) : const Color(0xFFEF4444),
            size: 20,
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "Payout",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Pallets.boldBlackV2,
              ),
              4.verticalSpace,
              TextView(
                text: "${payout.date} • ${payout.status}",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
        TextView(
          text: "-${naira(payout.amount)}",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFEF4444),
        ),
      ],
    );
  }
}
