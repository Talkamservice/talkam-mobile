import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/navigation/routes.dart';
import 'package:talkam/core/services/data/session_manager.dart';

class DeepLinkNavigator {
  static Future handleBackgroundMessages(RemoteMessage message) async {}

  static void handleForegroundMessages(RemoteMessage message) {}

  static void handlePushNotificationClick(Map<String, dynamic> payload) {
    switch (payload['type']) {
      case 'session':
        if (isAuthenticated) {
          // CustomRoutes.goRouter.goNamed(PageUrl.therapyScreen);
          // injector.get<DeepLinkBloc>().add(DeepLinkCleared());
        }
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
}
