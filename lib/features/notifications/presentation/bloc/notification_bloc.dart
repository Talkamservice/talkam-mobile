import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/pusher/pusher_channel_service.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/notifications/data/models/get_announcements_response.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_response.dart';
import 'package:talkam/features/notifications/data/models/get_notifications_stats_response.dart';
import 'package:talkam/features/notifications/data/models/read_notification_response.dart';
import 'package:talkam/features/notifications/dormain/repository/notifications_repository.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

part 'notification_event.dart';

part 'notification_state.dart';

// Bloc class
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository _notificationsRepository;
  final ProfileRepository _profileRepository;

  // final FirebaseMessagingService _firebaseMessagingService;

  int _currentPage = 1;
  bool _hasReachedEndOfList = false;
  NotificationsStats stats = NotificationsStats.initial();

  NotificationsBloc(this._profileRepository, this._notificationsRepository) : super(NotificationsInitial()) {
    // add(GetNotificationsStatsEvent());

    _listenForMessages();
    on<GetNotificationsEvent>(_mapGetNotificationsEventToState);
    on<GetNotificationsStatsEvent>(_mapGetNotificationsStatsEventToState);
    on<ReadNotificationEvent>(_mapReadNotificationEventToState);
    on<GetNotificationsDetailsEvent>(_mapGetNotificationsDetailsEventToState);
    on<ClearNotificationsEvent>(_mapClearNotificationsEventToState);
    on<ReadAllNotificationEvent>(_mapReadAllNotificationEventToState);
    on<LoadMoreNotificationsEvent>(_mapLoadMoreNotificationsEvent);
    on<GetAnnouncementsEvent>(_mapGetAnnouncementsEvent);
    on<GetAnnouncementByIdEvent>(_mapGetAnnouncementByIdEvent);
  }

  Future<void> _mapGetNotificationsEventToState(
    GetNotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    if (SessionManager().isLoggedIn) {
      emit(GetNotificationsLoadingState());
      try {
        _currentPage = 1;
        _hasReachedEndOfList = false;
        final notificationResponse = await _notificationsRepository.getNotifications(_currentPage, tab: event.tab);
        // await _firebaseMessagingService.onUpdatePalynxNotification(false);
        emit(GetNotificationsSuccessState(response: notificationResponse.data));
      } catch (e, stack) {
        logger.e(stack);
        logger.e(e);
        emit(GetNotificationsFailureState(error: e.toString()));
      }
    }
  }

  Future<void> _mapReadNotificationEventToState(
    ReadNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    // emit(ReadNotificationLoading());
    try {
      final response = await _notificationsRepository.readNotification(event.id);
      emit(ReadNotificationSuccessState(response: response));
    } catch (e) {
      emit(ReadNotificationFailureState(error: e.toString()));
    }
  }

  Future<void> _mapGetNotificationsDetailsEventToState(
    GetNotificationsDetailsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(GetNotificationsDetailsLoadingState());

    try {
      final details = await _notificationsRepository.getNotificationDetails(event.id);
      emit(GetNotificationsDetailsSuccessState(details: details));
    } catch (e) {
      emit(GetNotificationsDetailsFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapClearNotificationsEventToState(ClearNotificationsEvent event, Emitter<NotificationsState> emit) async {
    emit(ClearNotificationsDetailsLoadingState());
    try {
      final details = await _notificationsRepository.clearAllNotifications();
      emit(ClearNotificationsDetailsSuccessState(details: details));
    } catch (e) {
      emit(ClearNotificationsDetailsFailureState(error: e.toString()));
    }
  }

  // FutureOr<void> _mapGetSenderDetailsEventToState(GetSenderDetailsEvent event, Emitter<NotificationsState> emit) async {
  //   emit(GetSenderDetailsLoadingState());
  //   try {
  //     final user = await _profileRepository.getUserInfoById(event.id);
  //     emit(GetSenderDetailsSuccessState(user: user));
  //   } catch (e) {
  //     emit(GetSenderDetailsFailureState(error: e.toString()));
  //   }
  // }

  FutureOr<void> _mapLoadMoreNotificationsEvent(LoadMoreNotificationsEvent event, Emitter<NotificationsState> emit) async {
    return;
    if (state is LoadingMoreNotificationState || _hasReachedEndOfList) return;
    emit(LoadingMoreNotificationState());
    try {
      _currentPage += 1;
      final paginatedNotificationResponse = await _notificationsRepository.getNotifications(_currentPage, tab: event.tab);
      _hasReachedEndOfList = paginatedNotificationResponse.data.isEmpty;
      final allNotifications = [...event.previousNotifications, ...paginatedNotificationResponse.data];
      emit(GetNotificationsSuccessState(response: allNotifications));
    } catch (e, stack) {
      logger.e(stack);
      logger.e(e);
      _currentPage -= 1;

      emit(GetNotificationsSuccessState(response: event.previousNotifications));
    }
  }

  FutureOr<void> _mapReadAllNotificationEventToState(ReadAllNotificationEvent event, Emitter<NotificationsState> emit) async {
    emit(const ReadAllNotificationLoadingState());
    try {
      final response = await _notificationsRepository.readAllNotifications();
      add(GetNotificationsStatsEvent());
      emit(ReadAllNotificationSuccessState(response: response));
    } catch (e) {
      emit(ReadAllNotificationFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapGetNotificationsStatsEventToState(GetNotificationsStatsEvent event, Emitter<NotificationsState> emit) async {
    if (SessionManager().isLoggedIn) {
      emit(GetNotificationsStatsLoadingState());
      try {
        final notificationResponse = await _notificationsRepository.getNotificationsStats();
        stats = notificationResponse.data;
        _listenForMessages();
        emit(GetNotificationsStatsSuccessState(response: notificationResponse));
      } catch (e, stack) {
        logger.e(stack);
        logger.e(e);
        emit(GetNotificationsFailureState(error: e.toString()));
      }
    }
  }

  void _listenForMessages() async {
    logger.i('listening');
    var userId = injector.get<ProfileBloc>().appUser?.id.toString();

    try {
      var pusherService = await PusherChannelService.getInstance;
      var pusher = await pusherService.getClient;
      if (pusher != null) {
        logger.i('connecting');

        if (!pusher.channels.containsKey("refresh-notification.$userId")) {
          pusher.onAuthorizer = _authorize;

          PusherChannel channel = await pusher.subscribe(
            channelName: "refresh-notification.$userId",
            onSubscriptionError: (message, d) => onSubscriptionError(message, d),
            onSubscriptionSucceeded: (data) {
              // log('subscribed');
              // AppUtils.showCustomToast("onSubscriptionSucceeded:  data: $data");
              // return data;a
            },
            onEvent: (event) => onEventReceived(event),
          );
          logger.w('connected');
        } else {
          logger.w('connected2');
          pusher.onAuthorizer = _authorize;

          pusher.getChannel("refresh-notification.$userId")?.onEvent = onEventReceived;
        }
        await pusher.connect();
      }
    } catch (e, s) {
      logger.w(e.toString());
      // SentryService.captureException(e, stackTrace: s);
    }
  }

  _authorize(String channelName, String socketId, options) async {
    return {
      "auth": "1934aa1e05c3acfdfd3f:${getSignature("$socketId:refresh-notification.$channelName)}")}",
    };
  }

  getSignature(String value) {
    var key = utf8.encode('0bfd461496258bd6e236');
    var bytes = utf8.encode(value);
    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC signature in string is: $digest");
    return digest;
  }

  onSubscriptionError(message, d) {
    logger.e(message);
  }

  onEventReceived(event) {
    try {
      var receivedEvent = (event as PusherEvent);
      logger.i('received message${receivedEvent.data}');

      if (receivedEvent.eventName == 'refresh') {
        logger.i('received message${receivedEvent.data}');
        add(GetNotificationsStatsEvent());
        injector.get<ConversationsCubit>().getConversations(reload: false);
      }
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
    }
  }

  FutureOr<void> _mapGetAnnouncementsEvent(GetAnnouncementsEvent event, Emitter<NotificationsState> emit) async {
    if (SessionManager().isLoggedIn) {
      emit(const GetAnnouncementsLoading());
      try {
        final notificationResponse = await _notificationsRepository.getAllAnnouncements();
        // await _firebaseMessagingService.onUpdatePalynxNotification(false);
        // logger.w(notificationResponse.message);
        emit(GetAnnouncementsSuccessState(response: notificationResponse));
      } catch (e, stack) {
        logger.e(stack);
        logger.e(e);
        emit(GetAnnouncementsFailureState(error: e.toString()));
      }
    }
  }

  FutureOr<void> _mapGetAnnouncementByIdEvent(GetAnnouncementByIdEvent event, Emitter<NotificationsState> emit) async {
    if (SessionManager().isLoggedIn) {
      emit(const GetAnnouncementsLoading());
      try {
        final notificationResponse = await _notificationsRepository.getAnnouncementById(event.id);
        // await _firebaseMessagingService.onUpdatePalynxNotification(false);
        emit(GetAnnouncementByIdSuccessState(response: notificationResponse));
      } catch (e, stack) {
        logger.e(stack);
        logger.e(e);
        emit(GetAnnouncementByIdFailureState(error: e.toString()));
      }
    }
  }
}
