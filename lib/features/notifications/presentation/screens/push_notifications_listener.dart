import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/firebase/deep_link_naigator.dart';
import 'package:talkam/features/notifications/presentation/bloc/push_notifications_navigator_bloc/deep_link_bloc.dart';

class PushNotificationListener extends StatefulWidget {
  final Widget child;

  const PushNotificationListener({super.key, required this.child});

  @override
  State<PushNotificationListener> createState() =>
      _PushNotificationListenerState();
}

class _PushNotificationListenerState extends State<PushNotificationListener> {
  @override
  void initState() {
    super.initState();
    // A cold-start notification tap dispatches DeepLinkReceived via
    // getInitialMessage() before runApp() returns — whether the
    // BlocListener below is already subscribed by then is a race.
    // CheckForDeepLink re-emits whatever the bloc last cached, so firing it
    // once we're guaranteed to be subscribed (post first frame) closes that
    // race. It's a no-op if the live listener already handled and cleared
    // the link, so this never causes a duplicate navigation.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      injector.get<PushNotificationNavigatorBloc>().add(CheckForDeepLink());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PushNotificationNavigatorBloc,
        PushNotificationNavigatorState>(
      bloc: injector.get<PushNotificationNavigatorBloc>(),
      listener: (context, state) {
        if (state is ActiveDeepLink) {
          try {
            if (state.data != null) {
              final Map<String, dynamic> notificationPayload =
                  state.data is String
                      ? jsonDecode(state.data)
                      : state.data;
              DeepLinkNavigator.handlePushNotificationClick(
                  notificationPayload);
            }
          } catch (e, stack) {
            logger.e(e.toString());
            logger.e(stack.toString());
          } finally {
            // Consumed — clear it so a stray later CheckForDeepLink doesn't
            // replay the same navigation a second time.
            injector.get<PushNotificationNavigatorBloc>().add(DeepLinkCleared());
          }
        }
      },
      child: widget.child,
    );
  }
}
