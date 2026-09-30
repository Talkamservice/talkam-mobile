part of 'messaging_cubit.dart';

@freezed
class MessagingState with _$MessagingState {
  const factory MessagingState.initial() = _Initial;

  // Send Message States
  const factory MessagingState.sendMessageLoading() = _SendMessageLoading;
  const factory MessagingState.sendMessageSuccess(dynamic response) =
      _SendMessageSuccess;
  const factory MessagingState.sendMessageFailure(String error) =
      _SendMessageFailure;

  // Get Messages States
  const factory MessagingState.getMessagesLoading() = _GetMessagesLoading;
  // [revision] carries no meaning beyond making consecutive emissions
  // distinct — this state has no other data (chat_screen.dart reads
  // messages straight off the cubit's `messages` field). Without it, Cubit's
  // emit() silently no-ops when this exact state is emitted twice in a row
  // (e.g. once from cache, once from the real fetch that follows), since
  // Cubit skips re-emitting a state equal to the current one — dropping the
  // rebuild that would've shown the freshly-fetched messages.
  const factory MessagingState.getMessagesSuccess(int revision) =
      _GetMessagesSuccess;
  const factory MessagingState.getMessagesFailure(String error) =
      _GetMessagesFailure;

  // Delete Conversation States
  const factory MessagingState.deleteConversationLoading() =
      _DeleteConversationLoading;
  const factory MessagingState.deleteConversationSuccess() =
      _DeleteConversationSuccess;
  const factory MessagingState.deleteConversationFailure(String error) =
      _DeleteConversationFailure;

  // Fetch Current Conversation States
  const factory MessagingState.fetchCurrentConversationLoading() =
      _FetchCurrentConversationLoading;
  const factory MessagingState.fetchCurrentConversationSuccess(
      TalkamConversation response) = _FetchCurrentConversationSuccess;
  const factory MessagingState.fetchCurrentConversationFailure(String error) =
      _FetchCurrentConversationFailure;

  // Update Conversation Status States
  const factory MessagingState.updateConversationStatusLoading() =
      _UpdateConversationStatusLoading;
  const factory MessagingState.updateConversationStatusSuccess(
      TalkamConversation response) = _UpdateConversationStatusSuccess;
  const factory MessagingState.updateConversationStatusFailure(String error) =
      _UpdateConversationStatusFailure;

//   Message Updated
  const factory MessagingState.messageUpdated(AppMessageModel message) =
      _MessageUpdated;
}
