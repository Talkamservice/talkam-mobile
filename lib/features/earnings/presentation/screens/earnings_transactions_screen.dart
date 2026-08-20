import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/features/earnings/data/models/earnings_transaction.dart';
import 'package:talkam/features/earnings/dormain/repository/earnings_repository.dart';
import 'package:talkam/features/earnings/presentation/bloc/earnings_cubit.dart';

/// `GET /therapist/earnings/transactions` (v2) — the full paginated ledger,
/// reached from the Earnings dashboard's "See all".
class EarningsTransactionsScreen extends StatefulWidget {
  const EarningsTransactionsScreen({super.key});

  @override
  State<EarningsTransactionsScreen> createState() =>
      _EarningsTransactionsScreenState();
}

class _EarningsTransactionsScreenState
    extends State<EarningsTransactionsScreen> {
  final cubit = EarningsCubit(injector.get<EarningsRepository>());
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit.getTransactions();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    cubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = cubit.state;
      if (state.transactionsStatus != LoadStatus.loading &&
          state.transactionsCanLoadMore) {
        cubit.getTransactions(loadMore: true);
      }
    }
  }

  static String _naira(String rawAmount) {
    final value = double.tryParse(rawAmount)?.toInt() ?? 0;
    return "₦${value.toString().formatNumber()}";
  }

  static String _formatDate(String raw) {
    final dt = DateTime.tryParse(raw);
    if (dt == null) return raw;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[dt.month - 1]} ${dt.day}, ${dt.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: const CustomAppBar(
        tittle: TextView(
          text: "Transactions",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
        centerTile: false,
      ),
      body: BlocBuilder<EarningsCubit, EarningsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.transactionsStatus == LoadStatus.loading &&
              state.transactions.isEmpty) {
            return Center(child: CustomDialogs.getLoading(size: 50));
          }
          if (state.transactionsStatus == LoadStatus.error &&
              state.transactions.isEmpty) {
            return Center(
              child: TextView(
                text: state.transactionsError ?? "Something went wrong",
                fontSize: 14,
                color: Pallets.grey400,
                align: TextAlign.center,
              ),
            );
          }
          if (state.transactions.isEmpty) {
            return Center(
              child: TextView(
                text: "No transactions yet",
                fontSize: 14,
                color: Pallets.grey400,
              ),
            );
          }
          return ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: state.transactions.length +
                (state.transactionsCanLoadMore ? 1 : 0),
            separatorBuilder: (context, index) => 16.verticalSpace,
            itemBuilder: (context, index) {
              if (index >= state.transactions.length) {
                return Center(child: CustomDialogs.getLoading(size: 24));
              }
              final tx = state.transactions[index];
              return _TransactionRow(
                transaction: tx,
                naira: _naira,
                formattedDate: _formatDate(tx.createdAt),
              );
            },
          );
        },
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({
    required this.transaction,
    required this.naira,
    required this.formattedDate,
  });

  final EarningsTransaction transaction;
  final String Function(String) naira;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: isCredit ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCredit ? Icons.arrow_downward : Icons.arrow_outward,
            color: isCredit ? const Color(0xFF0F9D58) : const Color(0xFFEF4444),
            size: 20,
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: isCredit ? "Session earning" : "Payout",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Pallets.boldBlackV2,
              ),
              4.verticalSpace,
              TextView(
                text: "$formattedDate • ${transaction.status}",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
        TextView(
          text: "${isCredit ? '+' : '-'}${naira(transaction.amount)}",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: isCredit ? const Color(0xFF0F9D58) : const Color(0xFFEF4444),
        ),
      ],
    );
  }
}
