part of 'notification_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class GetNotificationsEvent extends NotificationsEvent {
   final String? tab;

   GetNotificationsEvent({this.tab});

  @override
  List<Object?> get props => [tab];
}
class GetNotificationsStatsEvent extends NotificationsEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReadNotificationEvent extends NotificationsEvent {
  final String id;

  const ReadNotificationEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class ReadAllNotificationEvent extends NotificationsEvent {


  const ReadAllNotificationEvent();

  @override
  List<Object?> get props => [];

}

class GetNotificationsDetailsEvent extends NotificationsEvent {
  final String id;

  const GetNotificationsDetailsEvent(this.id);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ClearNotificationsEvent extends NotificationsEvent {
  const ClearNotificationsEvent();

  @override
  List<Object?> get props => [];
}

class GetSenderDetailsEvent extends NotificationsEvent {
  const GetSenderDetailsEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [];
}

class LoadMoreNotificationsEvent extends NotificationsEvent {
  final List<TalkamNotification> previousNotifications;
  final String? tab;



  const LoadMoreNotificationsEvent({required this.previousNotifications,this.tab});

  @override
  List<Object?> get props => [previousNotifications];
}
