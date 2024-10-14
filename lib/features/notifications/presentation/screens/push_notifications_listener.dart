import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/firebase/deep_link_naigator.dart';
import 'package:talkam/features/notifications/presentation/bloc/push_notifications_navigator_bloc/deep_link_bloc.dart';

class PushNotificationListener extends StatelessWidget {
  final Widget child;

  const PushNotificationListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PushNotificationNavigatorBloc, PushNotificationNavigatorState>(
      bloc: injector.get<PushNotificationNavigatorBloc>(),
      listener: (context, state) {
        if (state is ActiveDeepLink) {
          try {
            if (state.data != null) {
              final Map<String, dynamic> notificationPayload = state.data is String ? jsonDecode(state.data) : state.data;
              DeepLinkNavigator.handlePushNotificationClick(notificationPayload);
            }
          } catch (e, stack) {
            logger.e(e.toString());
            logger.e(stack.toString());
          }
        }
      },
      child: child,
    );
  }
}
