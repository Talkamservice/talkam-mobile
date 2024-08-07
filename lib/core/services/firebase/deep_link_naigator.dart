import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/navigation/routes.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkNavigator {
  static Future handleBackgroundMessages(RemoteMessage message) async {}

  static void handleForegroundMessages(RemoteMessage message) {}

  static Future<void> handlePushNotificationClick(
      Map<String, dynamic> payload) async {
    logger.w(payload);
    switch (payload['type']) {
      case 'file':
        final filePath = payload['filePath'];

        if (await Permission.manageExternalStorage.request().isGranted) {
          final result = await OpenFilex.open(filePath);
        }

        // openDownloadsFolder(filePath);
        break;
      case 'badge':
        if (isAuthenticated) {
          // CustomRoutes.goRouter.pushNamed(PageUrl.badgesScreen);
        }
        break;
      case "welness_course":
        if (isAuthenticated) {
          // CustomRoutes.goRouter.pushNamed(PageUrl.wellnessLibraryScreen);
        }
        break;
      case "worksheet":
        if (isAuthenticated) {
          // context.pop();
          // CustomRoutes.goRouter.pushNamed(PageUrl.summariesScreen,
          //     queryParameters: {PathParam.tabIndex: '2'});
        }
        break;
      case 'subscription':
        if (isAuthenticated) {
          // context.pop();

          // CustomRoutes.goRouter.pushNamed(PageUrl.selectPlanScreen);
        }
        break;
      case 'conversation':
        if (isAuthenticated) {
          // logger.w();
          // rootNavigatorKey.currentState?.context
          //     .pushNamed(PageUrl.therapistChatScreen, queryParameters: {
          //   PathParam.therapist:
          //       jsonEncode(jsonDecode(payload["extra"])["therapist"])
          // });
        }
        break;
      // case 'ai_session': (This case seems unrelated to authentication)
      //   // ... your existing code for ai_session ...
      //   break;
    }
  }

  static get isAuthenticated =>
      CustomRoutes
              .goRouter.routerDelegate.currentConfiguration.last.route.path !=
          "/${PageUrl.onboardingIntro}" &&
      SessionManager.instance.isLoggedIn;

  static Future<void> openDownloadsFolder(String path) async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      final downloadsPath = '${directory?.path}/Download';
      await Process.run('open', [path]); // Or use a specific file manager app
    } else if (Platform.isIOS) {
      await launch(
          'file:///var/mobile/Media/Downloads'); // Or use a specific file manager app
    }
  }
}
