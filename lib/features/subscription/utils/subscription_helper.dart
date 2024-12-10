import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/navigation/routes.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class SubscriptionHelper {
  // Check if the user is subscribed
  static bool get isSubscribed => SessionManager.instance.isLoggedIn && _userIsSubscribed;

  static int get usedAnonymousCount => injector.get<ProfileBloc>().appUser?.anonymousPost;

  static bool get canPostAnonymously {
    if (SessionManager.instance.isLoggedIn) {
      if (_userIsSubscribed) {
        return true;
      } else {
        return injector.get<ProfileBloc>().appUser?.anonymousPost < 5;
      }
    } else {
      return false;
    }
  }

  static bool get canCreatePublicGroup {
    if (SessionManager.instance.isLoggedIn) {
      if (_userIsSubscribed) {
        return true;
      } else {
        return injector.get<ProfileBloc>().appUser?.anonymousPost + injector.get<ProfileBloc>().appUser?.anonymousComment < 5;
      }
    } else {
      return false;
    }
  }

  static bool get _userIsSubscribed => injector.get<ProfileBloc>().appUser?.activeSubscription?.plan.isPaid ?? false;

  static bool get canCommentAnonymously {
    if (SessionManager.instance.isLoggedIn) {
      if (_userIsSubscribed) {
        return true;
      } else {
        logger.w(injector.get<ProfileBloc>().appUser?.anonymousComment);
        return injector.get<ProfileBloc>().appUser?.anonymousComment < 5;
      }
    } else {
      return false;
    }
  }

  static void handleSubscriptionAction({
    required VoidCallback action,
    VoidCallback? unsubscribedUserAction,
    String? message,
  }) {
    if (isSubscribed) {
      action();
    } else {
      unsubscribedUserAction?.call();
      if (unsubscribedUserAction == null) {
        CustomRoutes.goRouter.pushNamed(PageUrl.login);
      }
    }
  }

  static Widget subscriptionWidget({
    required Widget widget,
    Widget? freeUserWidget,
  }) {
    return isSubscribed ? widget : freeUserWidget ?? const SubscriptionPrompt();
  }
}

class TalkamSubscriptionWidget extends StatelessWidget {
  const TalkamSubscriptionWidget({super.key, required this.subscribedUserWidget, this.freemiumUserWidget});

  final Widget subscribedUserWidget;
  final Widget? freemiumUserWidget;

  static bool get userIsSubscribed => injector.get<ProfileBloc>().appUser?.activeSubscription?.plan.isPaid ?? false;

  static bool isSubscribed() => SessionManager.instance.isLoggedIn && userIsSubscribed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: injector.get(),
      builder: (context, state) {
        return isSubscribed() ? subscribedUserWidget : freemiumUserWidget ?? 0.verticalSpace;
      },
    );
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
