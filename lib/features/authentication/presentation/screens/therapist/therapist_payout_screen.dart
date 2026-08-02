import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/string_extension.dart';
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
    final rate = widget.bloc.state.payout.sessionRate;
    _rateController.text = rate.isEmpty ? '' : rate.formatNumber();
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

  /// "₦0" while the rate isn't valid yet, otherwise 85% of it, comma-formatted.
  String _earnings(PayoutInfo payout, {bool full = false}) {
    if (!payout.isSessionRateValid) return "₦0";

    final rate = double.tryParse(payout.sessionRate ?? '') ?? 0.0;
    final earnings = (full ? rate : rate * 0.85).round();

    return "₦${earnings.toString().formatNumber()}";
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
                InlineSelectField<String>(
                  hint: "Select your bank",
                  options: kNigerianBanks,
                  labelBuilder: (v) => v,
                  value: payout.bankName,
                  onSingleChanged: (v) =>
                      widget.bloc.add(SetBankNameEvent(v)),
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
                        inputFormatters: [_ThousandsInputFormatter()],
                        forceError:
                            rateTouched && !payout.isSessionRateValid,
                        onChanged: (v) => widget.bloc
                            .add(SetSessionRateEvent(v.removeCommas())),
                      ),
                      if (rateTouched && !payout.isSessionRateValid) ...[
                        6.verticalSpace,
                        TextView(
                          text:
                              "Amount can't exceed ₦${PayoutInfo.maxSessionRate.toString().formatNumber()}",
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
                            padding: EdgeInsetsGeometry.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Pallets.grey75),
                              borderRadius: BorderRadius.circular(8.r),
                              color: Pallets.white
                            ),
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
                      ? () =>
                          widget.bloc.add(const SubmitApplicationEvent())
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

/// Formats digits with thousand separators as they're typed (e.g. "20000" →
/// "20,000"). The comma-free digits still reach the bloc — see the Amount
/// field's `onChanged`, which strips them back out before dispatching.
class _ThousandsInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.removeCommas();
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }
    if (int.tryParse(digits) == null) return oldValue;

    final formatted = digits.formatNumber();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
