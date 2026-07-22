import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/presentation/widgets/app_logo.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final GlobalKey<AppLogoWidgetState> _logoKey =
      GlobalKey<AppLogoWidgetState>();

  @override
  void initState() {
    super.initState();
    // Trigger the logo animation on the first rendered frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logoKey.currentState?.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ClipRect(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                // ── Logo (top, centred) ───────────────────────────────────
                Expanded(
                  child: Center(
                    child: AppLogoWidget(
                      key: _logoKey,
                      iconHeight: 72,
                    ),
                  ),
                ),

                // ── Buttons (bottom) ──────────────────────────────────────
                _GetStartedButton(
                  onPressed: () => context.pushNamed(PageUrl.signUp),
                ),

                16.verticalSpace,

                _SignInButton(
                  onPressed: () => context.pushNamed(PageUrl.login),
                ),

                20.verticalSpace,

                // "Browse anonymously" text link
                GestureDetector(
                  onTap: () {
                    SessionManager().hasOnboarded = true;
                    context.goNamed(PageUrl.homeScreen);
                  },
                  child: const TextView(
                    text: 'Browse anonymously',
                    color: Pallets.grey60,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                32.verticalSpace,
              ],
            ),
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
      padding: EdgeInsets.symmetric(vertical: 17.h),
      child: const TextView(
        text: 'Get Started',
        fontSize: 16,
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
      padding: EdgeInsets.symmetric(vertical: 17.h),
      child: const TextView(
        text: 'Sign In',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Pallets.boldBlack,
      ),
    );
  }
}
