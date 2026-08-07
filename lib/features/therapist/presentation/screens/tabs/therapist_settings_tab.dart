import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/settings_section.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/profile/presentation/widgets/delete_account_dialog.dart';
import 'package:talkam/gen/assets.gen.dart';

/// "Settings" tab of the therapist's own profile.
class TherapistSettingsTab extends StatelessWidget {
  const TherapistSettingsTab({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          SettingsSection(
            title: "Account management",
            tiles: [
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
                title: "Delete Account",
                titleColor: Pallets.dangerText,
                showChevron: false,
                onTap: () => DeleteAccountDialog.show(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
