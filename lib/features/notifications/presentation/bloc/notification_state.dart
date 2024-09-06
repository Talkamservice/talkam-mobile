part of 'notification_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

// State classes
class GetNotificationsLoadingState extends NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class GetNotificationsSuccessState extends NotificationsState {
  final List<TalkamNotification> response;

  const GetNotificationsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetNotificationsFailureState extends NotificationsState {
  final String error;

  const GetNotificationsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

// State classes
class GetNotificationsStatsLoadingState extends NotificationsState {}

class GetNotificationsStatsSuccessState extends NotificationsState {
  final GetNotificationsStatsResponse response;

  const GetNotificationsStatsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetNotificationsStatsFailureState extends NotificationsState {
  final String error;

  const GetNotificationsStatsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ReadNotificationSuccessState extends NotificationsState {
  final ReadNotificationResponse response;

  const ReadNotificationSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ReadNotificationFailureState extends NotificationsState {
  final String error;

  const ReadNotificationFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ReadAllNotificationSuccessState extends NotificationsState {
  final dynamic response;

  const ReadAllNotificationSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ReadAllNotificationFailureState extends NotificationsState {
  final String error;

  const ReadAllNotificationFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ReadAllNotificationLoadingState extends NotificationsState {
  const ReadAllNotificationLoadingState();

  @override
  List<Object?> get props => [];
}

class GetNotificationsDetailsLoadingState extends NotificationsState {}

class GetNotificationsDetailsSuccessState extends NotificationsState {
  final dynamic details;

  const GetNotificationsDetailsSuccessState({required this.details});

  @override
  List<Object?> get props => [details];
}

class GetNotificationsDetailsFailureState extends NotificationsState {
  final String error;

  const GetNotificationsDetailsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class ClearNotificationsDetailsLoadingState extends NotificationsState {}

class ClearNotificationsDetailsSuccessState extends NotificationsState {
  final dynamic details;

  const ClearNotificationsDetailsSuccessState({required this.details});

  @override
  List<Object?> get props => [details];
}

class ClearNotificationsDetailsFailureState extends NotificationsState {
  final String error;

  const ClearNotificationsDetailsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetSenderDetailsLoadingState extends NotificationsState {}

class GetSenderDetailsSuccessState extends NotificationsState {
  final dynamic user;

  const GetSenderDetailsSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetSenderDetailsFailureState extends NotificationsState {
  final String error;

  const GetSenderDetailsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoadingMoreNotificationState extends NotificationsState {}
