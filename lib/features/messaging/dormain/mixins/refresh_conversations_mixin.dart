import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';

mixin RefreshConversationsMixin {
  void refreshAllConversations() {
    injector.get<ConversationsCubit>().getConversations();
    injector.get<ConversationsCubit>().getPendingRequest();
    injector.get<NotificationsBloc>().add(GetNotificationsStatsEvent());
  }
}
