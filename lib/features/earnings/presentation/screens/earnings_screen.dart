import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

import 'package:talkam/core/navigation/route_url.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                    const TextView(
                      text: "₦84,000",
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    4.verticalSpace,
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
                          _StatColumn(title: "This week", amount: "₦84,000"),
                          Container(width: 1, height: 40.h, color: Colors.white.withValues(alpha: 0.3)),
                          _StatColumn(title: "This month", amount: "₦312,500"),
                          Container(width: 1, height: 40.h, color: Colors.white.withValues(alpha: 0.3)),
                          _StatColumn(title: "All time", amount: "₦1.24M"),
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
                  const TextView(
                    text: "Payouts are processed weekly on Wednesdays.",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFD97706),
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
                            const TextView(
                              text: "July 2025",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9CA3AF),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 20,
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
                                  String text = '';
                                  switch (value.toInt()) {
                                    case 0:
                                      text = 'Jul 1';
                                      break;
                                    case 3:
                                      text = 'Jul 7';
                                      break;
                                    case 6:
                                      text = 'Jul 14';
                                      break;
                                    case 9:
                                      text = 'Today';
                                      break;
                                  }
                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(text, style: style),
                                  );
                                },
                                reservedSize: 22,
                              ),
                            ),
                            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barGroups: [
                            _makeGroupData(0, 5),
                            _makeGroupData(1, 8),
                            _makeGroupData(2, 6),
                            _makeGroupData(3, 11),
                            _makeGroupData(4, 13),
                            _makeGroupData(5, 10),
                            _makeGroupData(6, 9),
                            _makeGroupData(7, 12),
                            _makeGroupData(8, 14),
                            _makeGroupData(9, 11, isToday: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

              // 2x2 Grid
              Row(
                children: [
                  Expanded(
                    child: _GridCard(
                      title: "Sessions this week",
                      value: "4",
                      subtitle: "1 from last week",
                      subtitleColor: Pallets.blueBubbleColor,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: _GridCard(
                      title: "Avg per session",
                      value: "₦25k",
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
                      title: "pending payout",
                      value: "₦84k",
                      subtitle: "2 sessions pending",
                      subtitleColor: const Color(0xFFD97706),
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: _GridCard(
                      title: "This month",
                      value: "3",
                      subtitle: "1 new this month",
                      subtitleColor: const Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
              32.verticalSpace,

              // Recent Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextView(
                    text: "Recent transactions",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlackV2,
                  ),
                  InkWell(
                    onTap: () {},
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

              // Mock Transaction
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_outward,
                      color: Color(0xFFEF4444),
                      size: 20,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: "Payout to First Bank",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Pallets.boldBlackV2,
                        ),
                        4.verticalSpace,
                        const TextView(
                          text: "Today, 3:00 PM",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9CA3AF),
                        ),
                      ],
                    ),
                  ),
                  const TextView(
                    text: "-₦80,000",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFEF4444),
                  ),
                ],
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Pallets.blueBubbleColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, {bool isToday = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isToday ? Pallets.blueBubbleColor : const Color(0xFFE5E7EB),
          width: 20.w,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            topRight: Radius.circular(4.r),
          ),
        ),
      ],
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
