import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/core/utils/thousands_input_formatter.dart';
import 'package:talkam/features/therapist/data/models/session_rate.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_availability_screen.dart'
    show kSessionDurations;
import 'package:talkam/features/therapist_application/data/models/therapist_application_data.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_response.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';
import 'package:talkam/features/therapist_application/presentation/widgets/select_bank_sheet.dart';

/// Step 5 of 5 — Payout.
class TherapistPayoutScreen extends StatefulWidget {
  const TherapistPayoutScreen({super.key, required this.bloc});

  final TherapistApplicationBloc bloc;

  @override
  State<TherapistPayoutScreen> createState() => _TherapistPayoutScreenState();
}

class _TherapistPayoutScreenState extends State<TherapistPayoutScreen> {
  final _accountController = TextEditingController();
  final _rateController = TextEditingController();
  Timer? _verifyDebounce;

  @override
  void initState() {
    super.initState();
    _accountController.text = widget.bloc.state.payout.accountNumber;
    final rate = widget.bloc.state.payout.sessionRate;
    _rateController.text = rate.isEmpty ? '' : rate.formatNumber();
    // Prefetched here so the bank picker sheet opens instantly instead of
    // fetching (and flashing a loading state) on every open.
    widget.bloc.add(const LoadBanksEvent());
  }

  @override
  void dispose() {
    _accountController.dispose();
    _rateController.dispose();
    _verifyDebounce?.cancel();
    super.dispose();
  }

  void _maybeVerifyAccount() {
    _verifyDebounce?.cancel();
    _verifyDebounce = Timer(const Duration(milliseconds: 500), () {
      final payout = widget.bloc.state.payout;
      if (payout.bankCode != null && payout.isAccountValid) {
        widget.bloc.add(const VerifyAccountEvent());
      }
    });
  }

  Future<void> _selectBank(BuildContext context) async {
    final bank = await CustomDialogs.showBottomSheet(
      context,
      SelectBankSheet(bloc: widget.bloc),
    );
    if (bank is TherapistBank) {
      widget.bloc.add(SetBankEvent(code: bank.code, name: bank.name));
      _maybeVerifyAccount();
    }
  }

  String _durationLabel(int minutes) {
    final match = kSessionDurations.where((d) => d.minutes == minutes);
    return match.isEmpty
        ? "$minutes min"
        : "${match.first.label} (${minutes}min)";
  }

  /// "₦0" while the rate isn't valid yet, otherwise the therapist's share
  /// (or the gross amount when [full]), comma-formatted.
  String _earnings(PayoutInfo payout, {bool full = false}) {
    final rate = SessionRate(payout.sessionRate);
    if (!rate.isValid) return "₦0";

    final earnings = full ? rate.amount! : rate.therapistEarnings;
    return "₦${earnings.toString().formatNumber()}";
  }

  String? _rateErrorText(PayoutInfo payout) {
    switch (SessionRate(payout.sessionRate).error) {
      case null:
      case SessionRateError.empty:
        return null;
      case SessionRateError.notANumber:
        return "Enter a valid amount";
      case SessionRateError.belowMin:
        return "Amount can't be lower than ₦${PayoutInfo.minSessionRate.toString().formatNumber()}";
      case SessionRateError.aboveMax:
        return "Amount can't exceed ₦${PayoutInfo.maxSessionRate.toString().formatNumber()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<TherapistApplicationBloc, TherapistApplicationState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state.submitStatus == SubmitStatus.submitting) {
            CustomDialogs.showLoading(context);
          }
          if (state.submitStatus == SubmitStatus.submitted) {
            SessionManager.instance.isTherapistAccount = true;
            context.pop();
            widget.bloc.close();
            context.goNamed(PageUrl.therapistVerificationPendingScreen);
          }
          if (state.submitStatus == SubmitStatus.error) {
            context.pop();
            CustomDialogs.error(state.submitError ?? "Something went wrong");
          }
        },
        builder: (context, state) {
          final payout = state.payout;
          final accountTouched = payout.accountNumber.isNotEmpty;
          final rateTouched = payout.sessionRate.isNotEmpty;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StepProgressBar(step: 5, totalSteps: 5, label: "Payout"),
                20.verticalSpace,
                const TextView(
                  text: "Where should we pay you?",
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                const TextView(
                  text:
                      "80% of each session fee goes directly to you. Paid weekly every Friday.",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),
                24.verticalSpace,
                const TextView(
                  text: "Bank Name",
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Pallets.grey400,
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () => _selectBank(context),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      hint: "Select your bank",
                      controller: TextEditingController(text: payout.bankName),
                      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ),
                ),
                16.verticalSpace,
                const TextView(
                  text: "Account Number",
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Pallets.grey400,
                ),
                10.verticalSpace,
                CustomTextField(
                  hint: "Enter your 10-digit account number",
                  controller: _accountController,
                  keyboardType: TextInputType.number,
                  forceError: accountTouched && !payout.isAccountValid,
                  forceValid: accountTouched &&
                      payout.isAccountValid &&
                      payout.resolvedAccountName != null,
                  onChanged: (v) {
                    widget.bloc.add(SetAccountNumberEvent(v));
                    _maybeVerifyAccount();
                  },
                ),
                if (accountTouched) ...[
                  6.verticalSpace,
                  if (!payout.isAccountValid)
                    const TextView(
                      text: "Invalid Account No.",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Pallets.errorRed,
                    )
                  else if (state.verifyingAccount)
                    const TextView(
                      text: "Verifying account...",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Pallets.grey400,
                    )
                  else if (payout.resolvedAccountName != null)
                    TextView(
                      text: payout.resolvedAccountName!,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Pallets.successGreen,
                    )
                  else if (state.verifyError != null)
                    TextView(
                      text: state.verifyError!,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Pallets.errorRed,
                    ),
                ],
                24.verticalSpace,
                const TextView(
                  text: "SET YOUR SESSION RATE",
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Pallets.grey400,
                ),
                10.verticalSpace,
                // ── Session rate card ───────────────────────────────────
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Pallets.blueBubbleColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "Amount",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Pallets.grey400,
                      ),
                      4.verticalSpace,
                      CustomTextField(
                        hint:
                            "Min: ₦${PayoutInfo.minSessionRate.toString().formatNumber()} - Max: ₦${PayoutInfo.maxSessionRate.toString().formatNumber()}",
                        controller: _rateController,
                        keyboardType: TextInputType.number,
                        inputFormatters: const [
                          ThousandsInputFormatter(maxDigits: 7)
                        ],
                        forceError: rateTouched && !payout.isSessionRateValid,
                        onChanged: (v) => widget.bloc
                            .add(SetSessionRateEvent(v.removeCommas())),
                      ),
                      if (rateTouched && _rateErrorText(payout) != null) ...[
                        6.verticalSpace,
                        TextView(
                          text: _rateErrorText(payout)!,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Pallets.errorRed,
                        ),
                      ],
                      14.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: _durationLabel(
                                state.availability.sessionDurationMinutes),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Pallets.boldBlackV2,
                          ),
                          Container(
                            padding: EdgeInsetsGeometry.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Pallets.grey75),
                                borderRadius: BorderRadius.circular(8.r),
                                color: Pallets.white),
                            child: TextView(
                              text: _earnings(payout, full: true),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Pallets.surfaceDark,
                            ),
                          )
                        ],
                      ),
                      10.verticalSpace,
                      Divider(height: 1, color: Pallets.grey75),
                      10.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextView(
                                  text: "Your earnings per session",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.boldBlackV2,
                                ),
                                const TextView(
                                  text: "15% platform share",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.grey400,
                                ),
                              ],
                            ),
                          ),
                          TextView(
                            text: _earnings(payout),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Pallets.successGreen,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                12.verticalSpace,

                // ── Info notices ─────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Pallets.blueBubbleColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded,
                          size: 16.sp, color: Pallets.blueBubbleColor),
                      8.horizontalSpace,
                      const Expanded(
                        child: TextView(
                          text:
                              "Your BVN is used only for tax compliance. Account verified via Flutterwave, not stored by TalkAm.",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Pallets.blueBubbleColor,
                          lineHeight: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                8.verticalSpace,
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Pallets.transparentOrage,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Pallets.noticeAmber, width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded,
                          size: 16.sp, color: Pallets.noticeAmber),
                      8.horizontalSpace,
                      const Expanded(
                        child: TextView(
                          text: "Payouts are processed weekly on Wednesdays.",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Pallets.noticeAmber,
                        ),
                      ),
                    ],
                  ),
                ),

                24.verticalSpace,
                CustomButton(
                  elevation: 0,
                  onPressed: payout.isValid
                      ? () => widget.bloc.add(const SubmitApplicationEvent())
                      : null,
                  bgColor: Pallets.blueBubbleColor,
                  child: const TextView(
                    text: "Submit Application",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                24.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
