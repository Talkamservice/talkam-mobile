import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/navigation/routes.dart';
import 'package:talkam/core/services/data/session_manager.dart';

class SubscriptionHelper {
  // Check if the user is subscribed
  static bool get isSubscribed => SessionManager.instance.isLoggedIn && false;

  static bool get canPostAnonymously => SessionManager.instance.isLoggedIn && false;
  static bool get canCommentAnonymously => SessionManager.instance.isLoggedIn && false;

  static void handleSubscriptionAction({
    required VoidCallback action,
    VoidCallback? guestAction,
    String? message,
  }) {
    if (isSubscribed) {
      action();
    } else {
      guestAction?.call();
      if (guestAction == null) {
        // Show a toast here
        // CustomDialogs.showToast(message ?? "Please subscribe to access this feature");
        CustomRoutes.goRouter.pushNamed(PageUrl.login);
      }
    }
  }

  static Widget subscriptionWidget({
    required Widget widget,
    Widget? guestWidget,
  }) {
    return isSubscribed ? widget : guestWidget ?? const SubscriptionPrompt();
  }
}

class TalkamSubscriptionWidget extends StatelessWidget {
  const TalkamSubscriptionWidget({super.key, required this.subscribedUserWidget, this.freemiumUserWidget});

  final Widget subscribedUserWidget;
  final Widget? freemiumUserWidget;

  static bool get isSubscribed => SessionManager.instance.isLoggedIn && false;

  @override
  Widget build(BuildContext context) {
    return isSubscribed ? subscribedUserWidget : freemiumUserWidget ?? 0.verticalSpace;
  }
}

class SubscriptionPrompt extends StatelessWidget {
  const SubscriptionPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        rootNavigatorKey.currentContext?.goNamed(PageUrl.onboardingIntro);
      },
      child: const TextView(text: "Login/Signup to Subscribe"),
    );
  }
}
