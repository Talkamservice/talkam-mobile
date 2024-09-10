import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/update_settings_payload.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'notification_setting_item.dart';
import 'notifications_settings_header.dart';

class MoreActivitiesPreferenceGroup extends StatefulWidget {
  MoreActivitiesPreferenceGroup({super.key, required this.data});

  NotificationsPreferenceResponse data;

  @override
  State<MoreActivitiesPreferenceGroup> createState() =>
      _MoreActivitiesPreferenceGroupState();
}

class _MoreActivitiesPreferenceGroupState
    extends State<MoreActivitiesPreferenceGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationSettingHeader(
            tittle: "More activity about you",
            subtittle:
                "These are notifications for posts on your profile, likes and other reactions to your posts, and more."),
        20.verticalSpace,
        NotificationSettingItem(
          notificationItemType: NotificationItemType.radio,
          tittle: 'Do not notifiy me',
          subtittle: '',
          selected:  widget.data.data.userActivities == 0,
          onTap: () {
            widget.data.data.userActivities = 0;

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  userActivities: (widget.data.data.userActivities),
                )));

            setState(() {});
          },
        ),
        16.verticalSpace,
        NotificationSettingItem(
          notificationItemType: NotificationItemType.radio,
          tittle: 'All reminders',
          subtittle: 'Notify me for all other activity.',
          selected: widget.data.data.userActivities == 1,
          onTap: () {
            widget.data.data.userActivities = 1;

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  userActivities: (widget.data.data.userActivities),
                )));

            setState(() {});
          },
        ),
        // 16.verticalSpace,
      ],
    );
  }
}
