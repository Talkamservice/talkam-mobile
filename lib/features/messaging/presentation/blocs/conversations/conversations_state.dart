part of 'conversations_cubit.dart';



@freezed
class ConversationsState with _$ConversationsState {
  const factory ConversationsState.initial() = _Initial;

  // Get All Conversations States
  const factory ConversationsState.getConversationsLoading() = _GetConversationsLoading;

  const factory ConversationsState.getConversationsSuccess(GetConversationsResponse response) = _GetConversationsSuccess;
  const factory ConversationsState.getConversationsFailure(String error) = _GetConversationsFailure;

  // Get Conversation By ID States
  const factory ConversationsState.getConversationByIdLoading() = _GetConversationByIdLoading;
  const factory ConversationsState.getConversationByIdSuccess(dynamic response) = _GetConversationByIdSuccess;
  const factory ConversationsState.getConversationByIdFailure(String error) = _GetConversationByIdFailure;

  // Delete Conversation By ID States
  const factory ConversationsState.deleteConversationByIdLoading() = _DeleteConversationByIdLoading;
  const factory ConversationsState.deleteConversationByIdSuccess() = _DeleteConversationByIdSuccess;
  const factory ConversationsState.deleteConversationByIdFailure(String error) = _DeleteConversationByIdFailure;

  // Create Conversation States
  const factory ConversationsState.createConversationLoading() = _CreateConversationLoading;
  const factory ConversationsState.createConversationSuccess(dynamic response) = _CreateConversationSuccess;
  const factory ConversationsState.createConversationFailure(String error) = _CreateConversationFailure;

  // Fetch Current Conversation States
  const factory ConversationsState.fetchCurrentConversationLoading() = _FetchCurrentConversationLoading;
  const factory ConversationsState.fetchCurrentConversationSuccess(dynamic response) = _FetchCurrentConversationSuccess;
  const factory ConversationsState.fetchCurrentConversationFailure(String error) = _FetchCurrentConversationFailure;

  // Update Conversation By ID States
  const factory ConversationsState.updateConversationByIdLoading() = _UpdateConversationByIdLoading;
  const factory ConversationsState.updateConversationByIdSuccess(dynamic response) = _UpdateConversationByIdSuccess;
  const factory ConversationsState.updateConversationByIdFailure(String error) = _UpdateConversationByIdFailure;

  // Update Conversation Status States
  const factory ConversationsState.updateConversationStatusLoading() = _UpdateConversationStatusLoading;
  const factory ConversationsState.updateConversationStatusSuccess(dynamic response) = _UpdateConversationStatusSuccess;
  const factory ConversationsState.updateConversationStatusFailure(String error) = _UpdateConversationStatusFailure;

  // Report Conversation States
  const factory ConversationsState.reportConversationLoading() = _ReportConversationLoading;
  const factory ConversationsState.reportConversationSuccess(dynamic response) = _ReportConversationSuccess;
  const factory ConversationsState.reportConversationFailure(String error) = _ReportConversationFailure;




  // Report Conversation States
  const factory ConversationsState.getPendingRequestsLoading() = _GetPendingRequestsLoading;
  const factory ConversationsState.getPendingRequestsSuccess(GetConversationsResponse response) = _GetPendingRequestsSuccess;
  const factory ConversationsState.getPendingRequestsFailure(String error) = _GetPendingRequestsFailure;
}

