import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/update_settings_payload.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';

import 'notification_setting_item.dart';
import 'notifications_settings_header.dart';

class NotificationsPreferencesGroup extends StatefulWidget {
  NotificationsPreferencesGroup({super.key, required this.data});

  NotificationsPreferenceResponse data;

  @override
  State<NotificationsPreferencesGroup> createState() =>
      _NotificationsPreferencesGroupState();
}

class _NotificationsPreferencesGroupState
    extends State<NotificationsPreferencesGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationSettingHeader(
            tittle: "Notifications from us",
            subtittle:
                "Receive the latest news, updates and industry tutorials from us."),
        20.verticalSpace,
        NotificationSettingItem(
          notificationItemType: NotificationItemType.switchType,
          tittle: 'News and updates',
          subtittle: 'News about product and feature updates.',
          selected: widget.data.data.talkamNews.toBool,
          onTap: () {
            widget.data.data.talkamNews = (!widget.data.data.talkamNews.toBool).toInt;

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  talkamNews: (widget.data.data.talkamNews.toBool).toInt,
                )));

            setState(() {});
          },
        ),

        16.verticalSpace,

        NotificationSettingItem(
          notificationItemType: NotificationItemType.switchType,
          tittle: 'User research',
          subtittle:
              'Get involved in our beta testing program or participate in paid product user research.',
          selected: widget.data.data.talkamResearch.toBool,
          onTap: () {
            widget.data.data.talkamResearch =
                (!widget.data.data.talkamResearch.toBool).toInt;

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  talkamNews: (widget.data.data.talkamResearch.toBool).toInt,
                )));

            setState(() {});
          },
        ),
        // 16.verticalSpace,
      ],
    );
  }
}
