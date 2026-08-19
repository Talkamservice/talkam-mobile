import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/presentation/widgets/app_logo.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // ── Logo (top, centred) ───────────────────────────────────
              const Expanded(
                child: Center(
                  child: AppLogoWidget(iconHeight: 72),
                ),
              ),

              // ── Buttons (bottom) ──────────────────────────────────────
              _GetStartedButton(
                onPressed: () =>
                    context.pushNamed(PageUrl.userTypeSelectionScreen),
              ),

              16.verticalSpace,

              _SignInButton(
                onPressed: () => context.pushNamed(PageUrl.login),
              ),

              32.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

// ── Filled "Get Started" button ─────────────────────────────────────────────

class _GetStartedButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _GetStartedButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      elevation: 0,
      bgColor: Pallets.blueBubbleColor,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: const TextView(
        text: 'Get Started',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Pallets.white,
      ),
    );
  }
}

// ── Outlined "Sign In" button ───────────────────────────────────────────────

class _SignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SignInButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: onPressed,
      borderColor: Pallets.borderGrey,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: const TextView(
        text: 'Sign In',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Pallets.boldBlack,
      ),
    );
  }
}
