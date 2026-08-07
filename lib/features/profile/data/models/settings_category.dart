import 'package:flutter/material.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/_utils.dart';
import 'package:talkam/features/profile/presentation/widgets/logout_dialog.dart';

class SettingsCategory {
  final String title;
  final List<SettingsItem> items;

  SettingsCategory({
    required this.title,
    required this.items,
  });
}

class SettingsItem {
  final String title;
  final Widget? trailingWidget;
  final void Function(BuildContext) onTap;

  SettingsItem({
    required this.title,
     this.trailingWidget,
    required this.onTap,
  });
}

SettingsCategory contentSettings = SettingsCategory(
  title: 'Content',
  items: [
    SettingsItem(
      title: 'Blocked users',
      onTap: (context) {
        context.pushNamed(PageUrl.blockedUsersScreen);
      },
    ),
    SettingsItem(
      title: 'Ads',
      onTap: (context) {
        context.pushNamed(PageUrl.adsPage);
      },
    ),
  ],
);

SettingsCategory accountSettings = SettingsCategory(
  title: 'Account',
  items: [
    SettingsItem(
      title: 'Notifications',
      onTap: (context) {
        context.pushNamed(PageUrl.notificationSettingsScreen);
      },
    ),
    SettingsItem(
      title: 'Account Settings',
      onTap: (context) {
        context.pushNamed(PageUrl.accountSettingsScreen);
      },
    ),
    SettingsItem(
      title: 'Log out',
      trailingWidget: 0.verticalSpace,
      onTap: (context) {
        LogoutDialog.show(context);
      },
    ),
  ],
);

SettingsCategory aboutSettings = SettingsCategory(
  title: 'About',
  items: [
    SettingsItem(
      title: 'Help center',
      onTap: (context) {
        Helpers.launchRawUrl("https://web.talkam.prodevs.io/help&info/faqs");
        // Handle onTap for Push Notifications
      },
    ),
    SettingsItem(
      title: 'Send feedback',
      onTap: (context) {
        Helpers.launchRawUrl("https://web.talkam.prodevs.io/help&info/feedback");

        // Handle onTap for Email Notifications
      },
    ),
    SettingsItem(
      title: 'Follow us',
      onTap: (context) {
        Helpers.launchRawUrl("https://web.talkam.prodevs.io/help&info/about");

      },
    ),
    SettingsItem(
      title: 'Privacy policy',
      onTap: (context) {
        Helpers.launchRawUrl("https://web.talkam.prodevs.io/help&info/privacy-policy");


      },
    ),
    SettingsItem(
      title: 'Copyright',
      onTap: (context) {
        Helpers.launchRawUrl("https://web.talkam.prodevs.io/help&info/terms");

      },
    ),
  ],
);
