import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/navigation/routes.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_response.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkNavigator {
  static Future handleBackgroundMessages(RemoteMessage message) async {}

  static void handleForegroundMessages(RemoteMessage message) {}

  static Future<void> handlePushNotificationClick(Map<String, dynamic> payload) async {
    logger.w(payload);
    switch (payload['type']) {
      case 'file':
        final filePath = payload['filePath'];

        if (await Permission.manageExternalStorage.request().isGranted) {
          final result = await OpenFilex.open(filePath);
        }

        // openDownloadsFolder(filePath);
        break;
      case "post" || "comment":
        if(isAuthenticated){
          CustomRoutes.goRouter.pushNamed(PageUrl.postDetailsScreen, extra: payload['id'].toString());

        }
        break;

      case "conversation":
        if (isAuthenticated) {
          if (ExtraClass.fromJson(jsonDecode(payload['extra'])).sender != null) {
            var user = ExtraClass.fromJson(jsonDecode(payload['extra'])).sender!;
            CustomRoutes.goRouter.pushNamed(
              PageUrl.chatScreen,
              extra: ChatScreenParam(
                user: ConversationUser(id: user.id, name: user.name, username: user.username, email: user.email, avatar: user.avatar),
              ),
            );
          }
        }

      // logger.w(notification.userId);
      // var user = ExtraClass.fromJson(notification.extra);

      case "group":
        if (isAuthenticated) {
          CustomRoutes.goRouter.pushNamed(PageUrl.groupsInfoScreen, extra: payload['id'].toString());
        }
      case "group_request":
        if (isAuthenticated) {
          CustomRoutes.goRouter.pushNamed(PageUrl.pendingRequestsScreen, extra: payload['id'].toString());
        }
      case "request":
        if (isAuthenticated) {
          CustomRoutes.goRouter.pushNamed(PageUrl.pendingRequestsScreen, extra: payload['id'].toString());
        }
      case "mention":
        if (isAuthenticated) {
          CustomRoutes.goRouter.pushNamed(PageUrl.postDetailsScreen, extra: payload['id'].toString());
        }
      case "notification" || "user":
        if (isAuthenticated) {
          CustomRoutes.goRouter.pushNamed(
            PageUrl.notificationScreen,
          );
        }


        // showDialog(
        //   context: rootNavigatorKey.currentState!.context,
        //   builder: (context) {
        //
        //     return AdminNotificationDialog(
        //       notification: notification,
        //     );
        //   },
        // );
        // context.pushNamed(PageUrl.postDetailsScreen, extra: notification.dataId.toString());
        break;
    }
  }

  static get isAuthenticated => SessionManager.instance.isLoggedIn;

  static Future<void> openDownloadsFolder(String path) async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      final downloadsPath = '${directory?.path}/Download';
      await Process.run('open', [path]); // Or use a specific file manager app
    } else if (Platform.isIOS) {
      await launch('file:///var/mobile/Media/Downloads'); // Or use a specific file manager app
    }
  }
}
