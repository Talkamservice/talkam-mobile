import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talkam/core/di/injector.dart';

part 'deep_link_event.dart';

part 'deep_link_state.dart';

class PushNotificationNavigatorBloc extends Bloc<PushNotificationNavigatorEvent, PushNotificationNavigatorState> {
  PushNotificationNavigatorBloc() : super(DeepLinkInitial()) {
    dynamic data;

    on<PushNotificationNavigatorEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<DeepLinkReceived>((event, emit) {
      data = event.deepLink;
      logger.w("Data Received${data.toString()}");
      emit(ActiveDeepLink(event.deepLink));
    });

    on<CheckForDeepLink>((event, emit) {
      logger.w("Checking ${data}");
      if (data != null) {
        emit(ActiveDeepLink(data));
      }
    });

    on<DeepLinkCleared>((event, emit) {
      data = null;
      emit(NoDeepLink());
    });
  }
}
