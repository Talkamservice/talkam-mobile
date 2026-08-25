import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/features/earnings/dormain/repository/earnings_repository.dart';
import 'package:talkam/features/earnings/presentation/bloc/earnings_cubit.dart';
import 'package:talkam/features/earnings/presentation/widgets/payout_modals.dart';
import 'package:talkam/gen/assets.gen.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<PayoutScreen> createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen> {
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

  Future<void> _confirmPayout() async {
    try {
      final result = await cubit.withdrawAndAwaitResult();
      if (!mounted) return;
      if (result.isFailed) {
        showFailedModal(context, onRetry: _confirmPayout);
      } else {
        showSuccessModal(context, stillPending: result.isPending);
      }
    } catch (e) {
      if (!mounted) return;
      CustomDialogs.error(e.toString());
    }
  }

  static String _naira(num amount) =>
      "₦${amount.toInt().toString().formatNumber()}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_ios,
                    size: 20, color: Pallets.boldBlackV2),
              ),
              24.verticalSpace,
              const TextView(
                text: "Payout",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlackV2,
              ),
              8.verticalSpace,
              const TextView(
                text: "Funds transferred within 1 business day",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
              24.verticalSpace,
              Expanded(
                child: BlocBuilder<EarningsCubit, EarningsState>(
                  bloc: cubit,
                  builder: (context, state) {
                    switch (state.dashboardStatus) {
                      case LoadStatus.idle:
                      case LoadStatus.loading:
                        return Center(
                            child: CustomDialogs.getLoading(size: 50));
                      case LoadStatus.error:
                        return AppErrorWidget(
                          message:
                              state.dashboardError ?? "Something went wrong",
                          onTap: cubit.getDashboard,
                        );
                      case LoadStatus.success:
                        final dashboard = state.dashboard!;
                        final canWithdraw = dashboard.balance > 0;
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                    const TextView(
                                      text: "AVAILABLE BALANCE",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    12.verticalSpace,
                                    TextView(
                                      text: _naira(dashboard.balance),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                    8.verticalSpace,
                                    TextView(
                                      text:
                                          "From ${dashboard.tiles.pendingPayout.sessions} completed sessions",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              32.verticalSpace,
                              const TextView(
                                text: "ACCOUNT",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B7280),
                              ),
                              12.verticalSpace,
                              // Dummy — no endpoint exposes the therapist's
                              // saved payout account (bank/number). The
                              // withdraw call pays out to whatever's on file
                              // server-side; kept visible as a placeholder
                              // rather than omitted.
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9FAFB),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24.w,
                                      height: 24.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: ImageWidget(
                                        imageUrl: Assets.images.svgV2.money03,
                                        color: Pallets.darkGrey,
                                      ),
                                    ),
                                    16.horizontalSpace,
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            text: "First Bank Nigeria",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Pallets.boldBlackV2,
                                          ),
                                          TextView(
                                            text: "•••• •••• 9170",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF9CA3AF),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ImageWidget(
                                          imageUrl: Assets
                                              .images.svgs.verificationIcon,
                                          color: const Color(0xFF0F9D58),
                                        ),
                                        4.horizontalSpace,
                                        const TextView(
                                          text: "Verified",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF0F9D58),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              32.verticalSpace,
                              CustomButton(
                                text: canWithdraw
                                    ? "Confirm Payout"
                                    : "No balance available",
                                onPressed: (canWithdraw && !state.withdrawing)
                                    ? _confirmPayout
                                    : null,
                                child: state.withdrawing
                                    ? CustomDialogs.getLoading(
                                        size: 24, color: Colors.white)
                                    : null,
                              ),
                              16.verticalSpace,
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59E0B)
                                      .withValues(alpha: 0.1),
                                  border: Border.all(
                                      color: const Color(0xFFF59E0B)),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.info_outline,
                                      color: Color(0xFFF59E0B),
                                      size: 20,
                                    ),
                                    12.horizontalSpace,
                                    const Expanded(
                                      child: TextView(
                                        text:
                                            "Payouts are processed weekly on Wednesdays.",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFD97706),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
