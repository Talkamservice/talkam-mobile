import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';

class AllNotificationsListener extends StatefulWidget {
  const AllNotificationsListener({super.key, required this.onReadAll});

  final VoidCallback onReadAll;

  @override
  State<AllNotificationsListener> createState() => _AllNotificationsListenerState();
}

class _AllNotificationsListenerState extends State<AllNotificationsListener> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsBloc, NotificationsState>(
        bloc: injector.get(),
        child: 0.verticalSpace,
        listener: (_, state) {
          if (state is ReadAllNotificationSuccessState) {
            widget.onReadAll();
          }
        });
  }
}
