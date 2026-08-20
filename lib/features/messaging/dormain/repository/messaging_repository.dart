import 'package:talkam/features/messaging/data/models/conversation_state_response.dart';
import 'package:talkam/features/messaging/data/models/conversations_filter.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';

abstract class MessagingRepository {
  Future<GetConversationsResponse> getConversations(
      {ConversationsFilter? filter});

  /// `GET /user/messaging/conversations?archived=&starred=` (v2) —
  /// paginated, distinct from [getConversations] which stays on v1 for the
  /// pending-requests tab (no v2 equivalent is documented for that yet).
  Future<GetConversationsListResponse> getConversationsList(
      {int? page, bool? archived, bool? starred});

  /// `POST /user/messaging/conversations/{action}` where action is one of
  /// mute | unmute | archive | unarchive | star | unstar | seen.
  Future<ConversationStateResponse> updateConversationState({
    required String action,
    required String conversationId,
    String? mutedUntil,
  });

  Future<dynamic> getConversationById(String id);

  Future<dynamic> deleteConversationById(String id);

  Future<dynamic> createConversation(Map<String, dynamic> conversationData);

  Future<TalkamConversation> fetchCurrentConversation(String receiverId);

  Future<dynamic> updateConversationById(String id, bool status);

  Future<TalkamConversation> updateConversationStatus(
      {required String conversationId, required String status});

  Future<dynamic> reportConversation(Map<String, dynamic> reportData);

  Future<dynamic> sendMessage(AppMessageModel messageData);

  Future<GetMessagesResponse> getMessages(String conversationId);

  Future<dynamic> deleteConversation(String id);

  /// `POST /user/messaging/conversations` (v2) — therapist<->client pairs
  /// with a confirmed booking open Active immediately; sends the first
  /// message in the same call. Community DMs keep the v1 request flow via
  /// [fetchCurrentConversation].
  Future<TalkamConversation> startConversation({
    required int receiverId,
    required String message,
  });
}
