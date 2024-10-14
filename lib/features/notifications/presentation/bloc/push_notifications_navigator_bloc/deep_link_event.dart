part of 'deep_link_bloc.dart';

abstract class PushNotificationNavigatorEvent {
  const PushNotificationNavigatorEvent();
}

class DeepLinkReceived extends PushNotificationNavigatorEvent {
  final dynamic deepLink;

  const DeepLinkReceived(this.deepLink);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeepLinkCleared extends PushNotificationNavigatorEvent {
  @override
  List<Object?> get props => [];
}

class CheckForDeepLink extends PushNotificationNavigatorEvent {
  @override
  List<Object?> get props => [];
}
