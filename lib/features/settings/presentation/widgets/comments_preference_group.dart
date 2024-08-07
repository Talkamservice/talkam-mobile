import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/update_settings_payload.dart';
import 'package:talkam/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'notification_setting_item.dart';
import 'notifications_settings_header.dart';

class CommentsPreferencesGroup extends StatefulWidget {
  CommentsPreferencesGroup({super.key, required this.data});

  NotificationsPreferenceResponse data;

  @override
  State<CommentsPreferencesGroup> createState() =>
      _CommentsPreferencesGroupState();
}

class _CommentsPreferencesGroupState extends State<CommentsPreferencesGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationSettingHeader(
            tittle: "Comments",
            subtittle:
                "These are notifications to remind you of updates you might have missed."),
        20.verticalSpace,
        NotificationSettingItem(
          notificationItemType: NotificationItemType.radio,
          tittle: 'Do not notify me',
          subtittle: '',
          selected: widget.data.data.comments == "off",
          onTap: () {
            widget.data.data.comments = "off";

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  comments: (widget.data.data.comments),
                )));

            setState(() {});
          },
        ),
        16.verticalSpace,
        NotificationSettingItem(
          notificationItemType: NotificationItemType.radio,
          tittle: 'Mentions only',
          subtittle: 'Only notify me if I’m mentioned in a comment',
          selected: widget.data.data.comments == "mentions",
          onTap: () {
            widget.data.data.comments = "mentions";

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  comments: (widget.data.data.comments),
                )));

            setState(() {});
          },
        ),
        16.verticalSpace,
        NotificationSettingItem(
          notificationItemType: NotificationItemType.radio,
          tittle: 'All comments',
          subtittle: 'Notify me for all comments on my post.',
          selected: widget.data.data.comments == "all",
          onTap: () {
            widget.data.data.comments = "all";

            context.read<SettingsBloc>().add(
                    SettingsEvent.saveNotificationPreferences(
                        UpdateSettingsPayload(
                  comments: (widget.data.data.comments),
                )));

            setState(() {});
          },
        ),
        // 16.verticalSpace,
      ],
    );
  }
}
