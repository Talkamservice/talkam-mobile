import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Shown right after a therapist submits their application. Static — the
/// wizard's bloc is closed by the payout screen before navigating here.
class TherapistVerificationPendingScreen extends StatelessWidget {
  const TherapistVerificationPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: _buildCheckMark()),
              32.verticalSpace,
              const TextView(
                text: "Your verification process is ongoing",
                align: TextAlign.center,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Pallets.boldBlackV2,
                lineHeight: 1.2,
              ),
              12.verticalSpace,
              const TextView(
                text:
                    "It takes 3–5 business days to verify your account. You can browse the app while you wait — we'll notify you the moment you're approved.",
                align: TextAlign.center,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Pallets.grey400,
                lineHeight: 1.5,
              ),
              32.verticalSpace,
              CustomButton(
                elevation: 0,
                onPressed: () => context.goNamed(PageUrl.homeScreen),
                bgColor: Pallets.blueBubbleColor,
                borderRadius: BorderRadius.circular(24.r),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const TextView(
                  text: "Explore TalkAm",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckMark() {
    return Container(
      height: 160.w,
      width: 160.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Pallets.successGreen.withValues(alpha: 0.12),
      ),
      child: Icon(
        Icons.check_rounded,
        size: 72.sp,
        color: Pallets.successGreen,
      ),
    );
  }
}
