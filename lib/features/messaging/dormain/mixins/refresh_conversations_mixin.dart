import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';

mixin RefreshConversationsMixin {
  void refreshAllConversations() {
    // NOT injector.get<ConversationsCubit>().getConversations() — that v1
    // call's state (getConversationsSuccess) has zero consumers anywhere in
    // the app, but it shares this same cubit with getConversationsList
    // (v2, what MessagesScreen actually renders). Calling it here raced
    // the two against each other: whichever resolved last overwrote
    // ConversationsCubit.state, so roughly half the time this silently
    // clobbered the v2 state with a shape neither MessagesScreen nor
    // patchConversationPreview recognize — the actual cause of the list
    // not updating after sending a message.
    injector.get<ConversationsCubit>().getPendingRequest();
    // Drives `MessagesScreen`'s actual list (the v1 calls above only feed
    // the pending-requests tab). Always refetches the "All" tab's filters —
    // this doesn't know which tab is currently selected there. `reload:
    // false` skips the loading shimmer since a list is likely already
    // visible.
    injector.get<ConversationsCubit>().getConversationsList(reload: false);
    injector.get<NotificationsBloc>().add(GetNotificationsStatsEvent());
  }
}
