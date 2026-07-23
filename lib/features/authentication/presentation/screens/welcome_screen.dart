import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Final onboarding step — confirms the account is ready.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              // ── Success mark ───────────────────────────────────────
              Center(child: _buildCheckMark()),

              32.verticalSpace,

              const TextView(
                text: "You’re In!",
                align: TextAlign.center,
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Pallets.boldBlackV2,
              ),

              12.verticalSpace,

              Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 28.w),
                child:
                const TextView(
                  text:
                  "Welcome to TalkAM. Your account is ready. Explore topics, communities, and therapists.",
                  align: TextAlign.center,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.5,
                ),
              ),

              32.verticalSpace,

              // ── Continue ───────────────────────────────────────────
              CustomButton(
                elevation: 0,
                onPressed: () => context.goNamed(PageUrl.homeScreen),
                bgColor: Pallets.blueBubbleColor,
                child: const TextView(
                  text: "Start exploring",
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

  /// Green tick inside two concentric tints, giving the soft halo from the
  /// design without any decorative confetti.
  Widget _buildCheckMark() {
    return Container(
      height: 220.w,
      width: 220.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Pallets.successGreen.withValues(alpha: 0.05),
      ),
      child: Icon(
        Icons.check_rounded,
        size: 90.sp,
        color: Pallets.successGreen,
      ),
    );
  }
}
