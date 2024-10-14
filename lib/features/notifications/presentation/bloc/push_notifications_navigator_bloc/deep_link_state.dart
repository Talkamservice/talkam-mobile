part of 'deep_link_bloc.dart';

abstract class PushNotificationNavigatorState {
  const PushNotificationNavigatorState();
}

class DeepLinkInitial extends PushNotificationNavigatorState {
  @override
  List<Object> get props => [];
}

class NoDeepLink extends PushNotificationNavigatorState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ActiveDeepLink extends PushNotificationNavigatorState {
  final dynamic data;

  const ActiveDeepLink(this.data);

  @override
  List<Object?> get props => [];
}
