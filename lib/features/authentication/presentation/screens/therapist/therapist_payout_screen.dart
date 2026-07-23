import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_text_field.dart';
import 'package:talkam/common/widgets/inline_select_field.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_availability_screen.dart'
    show kSessionDurations;
import 'package:talkam/features/therapist_application/data/models/therapist_application_data.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

const List<String> kNigerianBanks = [
  "Access Bank",
  "First Bank Nigeria",
  "Guaranty Trust Bank",
  "United Bank for Africa",
  "Zenith Bank",
  "Fidelity Bank",
  "Union Bank",
];

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

  @override
  void initState() {
    super.initState();
    _accountController.text = widget.bloc.state.payout.accountNumber;
    _rateController.text = widget.bloc.state.payout.sessionRate;
  }

  @override
  void dispose() {
    _accountController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  String _durationLabel(int minutes) {
    final match = kSessionDurations.where((d) => d.minutes == minutes);
    return match.isEmpty ? "$minutes min" : "${match.first.label} (${minutes}min)";
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
            context.pop();
            widget.bloc.close();
            context.goNamed(PageUrl.therapistVerificationPendingScreen);
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
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),
                24.verticalSpace,
                InlineSelectField<String>(
                  label: "Bank Name",
                  hint: "Select your bank",
                  options: kNigerianBanks,
                  labelBuilder: (v) => v,
                  value: payout.bankName,
                  onSingleChanged: (v) =>
                      widget.bloc.add(SetBankNameEvent(v)),
                ),
                16.verticalSpace,
                CustomTextField(
                  label: "Account Number",
                  hint: "Enter your 10-digit account number",
                  controller: _accountController,
                  keyboardType: TextInputType.number,
                  forceError: accountTouched && !payout.isAccountValid,
                  forceValid: accountTouched && payout.isAccountValid,
                  onChanged: (v) => widget.bloc.add(SetAccountNumberEvent(v)),
                ),
                if (accountTouched) ...[
                  6.verticalSpace,
                  TextView(
                    text: payout.isAccountValid
                        ? (payout.resolvedAccountName ?? '')
                        : "Invalid Account No.",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: payout.isAccountValid
                        ? Pallets.successGreen
                        : Pallets.errorRed,
                  ),
                ],
                24.verticalSpace,

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
                        text: "SET YOUR SESSION RATE",
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Pallets.grey400,
                      ),
                      10.verticalSpace,
                      CustomTextField(
                        label: "Amount",
                        hint:
                            "Min: ₦${PayoutInfo.minSessionRate} - Max: ₦${PayoutInfo.maxSessionRate}",
                        controller: _rateController,
                        keyboardType: TextInputType.number,
                        forceError:
                            rateTouched && !payout.isSessionRateValid,
                        onChanged: (v) =>
                            widget.bloc.add(SetSessionRateEvent(v)),
                      ),
                      if (rateTouched && !payout.isSessionRateValid) ...[
                        6.verticalSpace,
                        TextView(
                          text:
                              "Amount can't exceed ₦${PayoutInfo.maxSessionRate}",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Pallets.errorRed,
                        ),
                      ],
                      14.verticalSpace,
                      TextView(
                        text: _durationLabel(
                            state.availability.sessionDurationMinutes),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlackV2,
                      ),
                      10.verticalSpace,
                      Divider(height: 1, color: Pallets.grey90),
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
                            text: payout.isSessionRateValid
                                ? "₦${(int.parse(payout.sessionRate) * 0.85).round()}"
                                : "₦0",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Pallets.successGreen,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                20.verticalSpace,

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
                10.verticalSpace,
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
                      ? () =>
                          widget.bloc.add(const SubmitApplicationEvent())
                      : null,
                  bgColor: Pallets.blueBubbleColor,
                  borderRadius: BorderRadius.circular(24.r),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
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
