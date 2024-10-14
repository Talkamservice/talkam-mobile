import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/services/permission_handler/permission_handler_service.dart';
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
  State<NotificationsPreferencesGroup> createState() => _NotificationsPreferencesGroupState();
}

class _NotificationsPreferencesGroupState extends State<NotificationsPreferencesGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NotificationSettingHeader(tittle: "Notifications from us", subtittle: ""),
        20.verticalSpace,
        NotificationSettingItem(
          notificationItemType: NotificationItemType.switchType,
          tittle: 'Email Notifications',
          subtittle: 'Receive notifications via you email address',
          selected: widget.data.data.canReceiveEmail.toBool,
          onTap: () {
            widget.data.data.canReceiveEmail = (!widget.data.data.canReceiveEmail.toBool).toInt;

            context.read<SettingsBloc>().add(SettingsEvent.saveNotificationPreferences(UpdateSettingsPayload(
                  canReceiveEmail: (widget.data.data.canReceiveEmail.toBool).toInt,
                )));

            setState(() {});
          },
        ),

        16.verticalSpace,

        NotificationSettingItem(
          notificationItemType: NotificationItemType.switchType,
          tittle: 'Push Notifications',
          subtittle: 'Get Notifications on device push notifications',
          selected: widget.data.data.canReceivePush.toBool,
          onTap: () async {
            widget.data.data.canReceivePush = (!widget.data.data.canReceivePush.toBool).toInt;

            var granted = await PermissionHandlerService().requestPermission(Permission.notification);
            if (granted) {
              context.read<SettingsBloc>().add(SettingsEvent.saveNotificationPreferences(UpdateSettingsPayload(
                    canReceivePush: (widget.data.data.canReceivePush.toBool).toInt,
                  )));

              setState(() {});
            }
          },
        ),
        // 16.verticalSpace,
      ],
    );
  }
}
