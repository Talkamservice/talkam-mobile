import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/authentication/data/models/onboarding_user_type.dart';
import 'package:talkam/features/privacy/data/models/consent_settings.dart';
import 'package:talkam/features/privacy/presentation/bloc/privacy_bloc.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class DataPrivacyScreen extends StatefulWidget {
  const DataPrivacyScreen({super.key});

  @override
  State<DataPrivacyScreen> createState() => _DataPrivacyScreenState();
}

class _DataPrivacyScreenState extends State<DataPrivacyScreen> {
  final privacyBloc = PrivacyBloc(injector.get());

  @override
  void initState() {
    super.initState();
    privacyBloc.add(const LoadConsentsEvent());
  }

  @override
  void dispose() {
    privacyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivacyBloc, PrivacyState>(
      bloc: privacyBloc,
      listener: _listenToPrivacyBloc,
      builder: (context, state) {
        final settings =
            state is ConsentsLoaded ? state.settings : privacyBloc.settings;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            padding: EdgeInsets.all(0.0),
            tittleText: "Privacy",
            centerTile: false,
            bgColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Info banner ────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Pallets.blueBubbleColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Pallets.blueBubbleColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: const TextView(
                    text:
                        "You are in control of your data. Review and manage your consents below. Required consents are needed to use TalkAM.",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Pallets.blueBubbleColor,
                    lineHeight: 1.4,
                  ),
                ),

                24.verticalSpace,

                // ── Consent cards ──────────────────────────────────────
                ...ConsentType.values
                    .where((type) =>
                        !(SessionManager.instance.isTherapistAccount &&
                            type == ConsentType.anonymousCommunity))
                    .map(
                      (type) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _ConsentCard(
                          type: type,
                          value: settings.valueOf(type),
                          onChanged: (value) =>
                              privacyBloc.add(ToggleConsentEvent(type, value)),
                        ),
                      ),
                    ),

                12.verticalSpace,

                // ── Confirm ────────────────────────────────────────────
                CustomButton(
                  elevation: 0,
                  onPressed: settings.hasRequiredConsents
                      ? () => privacyBloc.add(const SaveConsentsEvent())
                      : null,
                  child: const TextView(
                    text: "Save Preferences",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                12.verticalSpace,

                // ── Privacy policy ─────────────────────────────────────
                CustomOutlinedButton(
                  borderColor: Pallets.grey90,
                  onPressed: () =>
                      context.pushNamed(PageUrl.privacyPolicyScreen),
                  child: const TextView(
                    text: "Privacy Policy",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Pallets.boldBlackV2,
                  ),
                ),

                32.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  void _listenToPrivacyBloc(BuildContext context, PrivacyState state) async {
    if (state is ConsentsFailure) {
      CustomDialogs.error(state.error);
    }
    if (state is ConsentsSaved) {
      // Best-effort — the user has finished every in-app step regardless of
      // whether this stamp succeeds, so it never blocks navigation. But when
      // it DOES succeed, its response is the authoritative final onboarding
      // state — cache it, otherwise a restart before any other /user/me
      // refresh happens would still show stale (incomplete) progress and
      // bounce the user back into onboarding.
      try {
        final onboarding =
            await injector.get<ProfileRepository>().completeOnboarding();
        final currentUser = injector.get<ProfileBloc>().appUser;
        if (onboarding != null && currentUser != null) {
          injector.get<ProfileBloc>().add(SaveUserLocallyEvent(
                currentUser.copyWith(onboarding: onboarding),
              ));
        }
      } catch (_) {}

      if (!context.mounted) return;
      SessionManager().hasOnboarded = true;

      // Consent is the last shared onboarding step — therapists still need
      // to complete the application wizard, everyone else is done.
      final userType =
          injector.get<ProfileBloc>().appUser?.onboarding?.userType;
      if (userType == kMentalHealthProUserType) {
        context.goNamed(PageUrl.therapistOnboardingScreen);
        return;
      }

      context.goNamed(PageUrl.welcomeScreen);
    }
  }
}

/// Single consent row — title, optional "Required" chip, description, switch.
class _ConsentCard extends StatelessWidget {
  const _ConsentCard({
    required this.type,
    required this.value,
    required this.onChanged,
  });

  final ConsentType type;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.bgLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextView(
                        text: type.title,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Pallets.boldBlackV2,
                      ),
                    ),
                    if (type.isRequired) ...[
                      8.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Pallets.grey95,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const TextView(
                          text: "Required",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Pallets.grey400,
                        ),
                      ),
                    ],
                  ],
                ),
                6.verticalSpace,
                TextView(
                  text: type.description,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.boldBlackV2,
                  lineHeight: 1.4,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          12.horizontalSpace,
          CustomSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
