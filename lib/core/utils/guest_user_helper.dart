import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/navigation/routes.dart';
import 'package:talkam/core/services/data/session_manager.dart';

class GuestUserHelper {
  static void handleGuestUserAction({
    required VoidCallback action,
    VoidCallback? guestAction,
    String? message,
  }) {
    if (SessionManager.instance.isLoggedIn) {
      action();
    } else {
      guestAction?.call();
      if (guestAction == null) {
        // Show a toast here
        // CustomDialogs.showToast( message ??"Please login to access this feature");
        CustomRoutes.goRouter.pushNamed(PageUrl.login);
      }
    }
  }

  static Widget guestUserWidget({
    required Widget widget,
    Widget? guestWidget,
  }) {
    return SessionManager.instance.isLoggedIn
        ? widget
        : guestWidget ??
            TextButton(
                onPressed: () {
                  rootNavigatorKey.currentContext
                      ?.goNamed(PageUrl.onboardingIntro);
                },
                child: const TextView(text: "Login/Signup"));
  }
}
