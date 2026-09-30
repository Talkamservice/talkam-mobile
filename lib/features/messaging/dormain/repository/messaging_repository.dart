import 'package:talkam/core/services/network/network_service.dart' show RequestMethod;
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

  Future<GetMessagesResponse> getMessages(String conversationId, {int page = 1});

  /// `{method} /user/messaging/messages/{action}` where action is one of
  /// edit | delete | forward | pin | unpin | react. The HTTP method isn't
  /// uniform across actions — confirmed per action, from real device logs
  /// (2026-09-29):
  /// - `edit`, `pin`, `unpin`: `POST`, body includes `message_id` (+
  ///   `message` for edit) — confirmed working (200, or a real 422
  ///   business-rule rejection, e.g. edit's 15-min window).
  /// - `delete`: `DELETE`, not POST — POST 405s ("Supported methods:
  ///   DELETE").
  /// - `react` (remove): `DELETE` on the same `react` path — POST 405s
  ///   the same way.
  /// - `react` (add): still unconfirmed — POST 405s there too, and unlike
  ///   delete/remove-reaction, no working verb is known yet for adding.
  /// - `forward`: untested.
  ///
  /// Given `delete` and `react` both turned out to need DELETE against a
  /// path that "looks like" a POST action-endpoint, don't assume any
  /// remaining unconfirmed action here defaults to POST — verify each one
  /// individually.
  Future<dynamic> updateMessageState({
    required String action,
    required String messageId,
    Map<String, dynamic>? extra,
    RequestMethod method = RequestMethod.post,
  });

  /// `POST /user/messaging/messages/bulk-mark-read`, body `{conversation_id}`.
  ///
  /// UNVERIFIED — same caveat as [updateMessageState] (which this mirrors
  /// the URL shape of): CHAT_AND_SESSION_API_REFERENCE.md confirms
  /// `MessageActionService::bulkMarkRead()` exists but not its route or
  /// payload. Conversation-scoped (marks every unread message in it),
  /// hence its own method rather than routing through [updateMessageState]
  /// (which is single-message-scoped via `message_id`).
  Future<dynamic> bulkMarkRead(String conversationId);

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
