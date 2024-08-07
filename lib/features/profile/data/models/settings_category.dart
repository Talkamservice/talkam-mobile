import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';

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
  final void Function(BuildContext) onTap;

  SettingsItem({
    required this.title,
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
      onTap: (context) {
        SessionManager.instance.logOut();
        context.goNamed(PageUrl.onboardingIntro);
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
        // Handle onTap for Push Notifications
      },
    ),
    SettingsItem(
      title: 'Send feedback',
      onTap: (context) {
        // Handle onTap for Email Notifications
      },
    ),
    SettingsItem(
      title: 'Follow us',
      onTap: (context) {
        // Handle onTap for Email Notifications
      },
    ),
    SettingsItem(
      title: 'Privacy policy',
      onTap: (context) {
        // Handle onTap for Email Notifications
      },
    ),
    SettingsItem(
      title: 'Copyright',
      onTap: (context) {
        // Handle onTap for Email Notifications
      },
    ),
  ],
);
