import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/settings_section.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/settings/presentation/widgets/delete_account_dialog.dart';
import 'package:talkam/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_response.dart';
import 'package:talkam/features/therapist_application/dormain/repository/therapist_application_repository.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

/// "Settings" tab of the therapist's own profile.
class TherapistSettingsTab extends StatefulWidget {
  const TherapistSettingsTab({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  State<TherapistSettingsTab> createState() => _TherapistSettingsTabState();
}

class _TherapistSettingsTabState extends State<TherapistSettingsTab> {
  final _repository = injector.get<TherapistApplicationRepository>();

  /// Null while loading or once we know the application is complete (or the
  /// check failed) — in every one of those cases the "continue application"
  /// tile just stays hidden rather than showing a broken/uncertain state.
  TherapistApplicationSteps? _incompleteSteps;

  @override
  void initState() {
    super.initState();
    _loadApplicationStatus();
  }

  Future<void> _loadApplicationStatus() async {
    try {
      final response = await _repository.getApplicationStatus();
      if (!mounted) return;
      setState(() {
        _incompleteSteps = response.steps.isComplete ? null : response.steps;
      });
    } catch (_) {
      // No draft application, not a therapist yet, or a transient network
      // error — either way the tile just doesn't show.
    }
  }

  void _continueApplication(BuildContext context) {
    final steps = _incompleteSteps;
    if (steps == null) return;
    context.pushNamed(
      steps.firstIncompleteStepRoute,
      extra: TherapistApplicationBloc(_repository),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          SettingsSection(
            title: "Account management",
            tiles: [
              if (_incompleteSteps != null)
                SettingsTile(
                  iconPath: Assets.images.svgV2.userInActive,
                  title: "Continue Application",
                  subtitle: "Finish setting up your therapist profile",
                  onTap: () => _continueApplication(context),
                ),
              SettingsTile(
                iconPath: Assets.images.svgV2.userInActive,
                title: "Edit Profile",
                subtitle: "Edit name, experience, availability, and rate",
                onTap: () =>
                    context.pushNamed(PageUrl.therapistEditProfileScreen),
              ),
              SettingsTile(
                iconPath: Assets.images.svgV2.notificationIcon,
                title: "Notification Settings",
                subtitle: "Manage alerts and reminders",
                onTap: () =>
                    context.pushNamed(PageUrl.notificationSettingsScreen),
              ),
            ],
          ),
          24.verticalSpace,
          SettingsSection(
            title: "Privacy & payments",
            tiles: [
              SettingsTile(
                iconPath: Assets.images.svgV2.card,
                title: "Account Settings",
                subtitle: "2 saved cards",
                onTap: () => context.pushNamed(PageUrl.accountSettingsScreen),
              ),
              SettingsTile(
                iconPath: Assets.images.svgV2.shield,
                title: "Privacy Settings",
                subtitle: "Manage privacy",
                onTap: () => context.pushNamed(PageUrl.privacySettingsScreen),
              ),
              SettingsTile(
                iconPath: Assets.images.svgV2.gear,
                title: "Data & Content",
                subtitle: "Control your data and consent usage.",
                onTap: () => context.pushNamed(PageUrl.dataPrivacyScreen),
              ),
              SettingsTile(
                iconPath: Assets.images.svgV2.delete,
                iconBackground: Pallets.dangerSurface,
                iconColor: Pallets.dangerText,
                title: "Delete Account",
                titleColor: Pallets.dangerText,
                showChevron: false,
                onTap: () => DeleteAccountDialog.show(context),
              ),
              SettingsTile(
                iconPath: Assets.images.svgV2.userInActive,
                iconBackground: Pallets.dangerSurface,
                iconColor: Pallets.dangerText,
                title: "Logout",
                titleColor: Pallets.dangerText,
                showChevron: false,
                onTap: () => LogoutDialog.show(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
