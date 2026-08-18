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
  const factory MessagingState.getMessagesSuccess(dynamic response) =
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
