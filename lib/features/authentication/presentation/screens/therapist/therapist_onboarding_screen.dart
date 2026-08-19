import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist_application/dormain/repository/therapist_application_repository.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Landing screen for the therapist sign-up flow — shown when a user picks
/// "I'm a mental health pro" on [UserTypeSelectionScreen].
///
/// This is the pitch/intro step only; starting the application hands off to
/// the real 5-step wizard (personal info → documents → specialties →
/// availability → payout), each step sharing one [TherapistApplicationBloc]
/// instance via `state.extra`.
class TherapistOnboardingScreen extends StatelessWidget {
  const TherapistOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Background photo ────────────────────────────────────────
          ImageWidget(
            imageUrl: Assets.images.jpegs.therapistSplashJpg.path,
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
          ),

          // ── Dark scrim so the white text stays readable ─────────────
          Container(
            width: 1.sw,
            height: 1.sh,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.45, 0.7, 1.0],
                colors: [
                  Colors.black.withValues(alpha: 0.25),
                  Colors.black.withValues(alpha: 0.35),
                  Colors.black.withValues(alpha: 0.85),
                  Colors.black.withValues(alpha: 0.95),
                ],
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Row(
                    children: [
                      const Expanded(child: _BrandHeader()),
                      TextView(
                        text: "Back",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        onTap: () => context.pop(),
                      ),
                    ],
                  ),

                  const Spacer(),

                  const TextView(
                    text: "Be the support to someone.",
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    lineHeight: 1.15,
                  ),

                  12.verticalSpace,

                  TextView(
                    text:
                        "Thousands of Nigerians on TalkAM seek help. Join as a verified therapist and help on your schedule.",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.85),
                    lineHeight: 1.4,
                  ),

                  24.verticalSpace,

                  _FeatureRow(
                    icon: Assets.images.svgs.scheduleIcon,
                    label: "Set your own schedule, video or voice sessions",
                  ),
                  8.verticalSpace,
                  _FeatureRow(
                    icon: Assets.images.svgs.earningsIcon,
                    label: "Keep 80% of weekly session earnings",
                  ),
                  8.verticalSpace,
                  _FeatureRow(
                    icon: Assets.images.svgs.verificationIcon,
                    label: "Verified in under 5 business days",
                  ),

                  28.verticalSpace,

                  // ── Start Application ───────────────────────────────
                  CustomButton(
                    elevation: 0,
                    onPressed: () => _startApplication(context),
                    bgColor: Pallets.blueBubbleColor,
                    child: const TextView(
                      text: "Start Application",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),

                  12.verticalSpace,

                  // ── Privacy Policy ───────────────────────────────────
                  CustomOutlinedButton(
                    onPressed: () => _openPrivacyPolicy(context),
                    bgColor: Colors.white,
                    borderColor: Colors.white,
                    child: const TextView(
                      text: "Privacy Policy",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Pallets.boldBlackV2,
                    ),
                  ),

                  16.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startApplication(BuildContext context) {
    context.pushNamed(
      PageUrl.therapistRequirementsScreen,
      extra: TherapistApplicationBloc(
          injector.get<TherapistApplicationRepository>()),
    );
  }

  void _openPrivacyPolicy(BuildContext context) {
    context.pushNamed(PageUrl.privacyPolicyScreen);
  }
}

/// Small mask icon + "TalkAm" wordmark + professional-audience subtitle.
class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageWidget(
          imageUrl: Assets.images.svgs.appIcon,
          size: 36.w,
        ),
        10.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextView(
              text: "TalkAm",
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            TextView(
              text: "For Mental Health Professionals",
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ],
        ),
      ],
    );
  }
}

/// Outlined icon + label row used for the three selling points.
class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          child: Center(
            child: ImageWidget(
              imageUrl: icon,
              size: 28.w,
              color: Pallets.blueBubbleColor,
            ),
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: TextView(
            text: label,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            lineHeight: 1.3,
          ),
        ),
      ],
    );
  }
}
