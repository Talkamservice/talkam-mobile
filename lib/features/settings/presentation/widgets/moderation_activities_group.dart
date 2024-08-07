import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/update_settings_payload.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';

import 'notification_setting_item.dart';
import 'notifications_settings_header.dart';

class ModerationActivitiesGroup extends StatefulWidget {
  ModerationActivitiesGroup({super.key, required this.data});

  NotificationsPreferenceResponse data;

  @override
  State<ModerationActivitiesGroup> createState() =>
      _ModerationActivitiesGroupState();
}

class _ModerationActivitiesGroupState extends State<ModerationActivitiesGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationSettingHeader(
            tittle: "Moderation activities",

            subtittle:
                "These are notifications to remind you of updates you might have missed."),
        20.verticalSpace,
        NotificationSettingItem(

          notificationItemType: NotificationItemType.radio,
          tittle: 'Do not notify me',
          subtittle: '',
          selected: widget.data.data.moderationActivities == 0,
          onTap: () {
            widget.data.data.moderationActivities = 0;

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  moderationActivities: (widget.data.data.moderationActivities),
                )));

            setState(() {});
          },
        ),
        // 16.verticalSpace,
        // NotificationSettingItem(
        //   notificationItemType: NotificationItemType.switchType,
        //   tittle: 'Mentions only',
        //   subtittle: 'Only notify me if I’m mentioned in a comment',
        //   selected: false,
        //   onTap: () {},
        // ),

        16.verticalSpace,
        NotificationSettingItem(
          notificationItemType: NotificationItemType.radio,
          tittle: 'All comments',
          subtittle: 'Notify me for all comments on my post.',
          selected: widget.data.data.moderationActivities == 1,
          onTap: () {
            widget.data.data.moderationActivities = 1;

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  moderationActivities: (widget.data.data.moderationActivities),
                )));

            setState(() {});
          },
        ),
        // 16.verticalSpace,
      ],
    );
  }
}
