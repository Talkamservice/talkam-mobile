import 'package:talkam/features/messaging/data/models/conversations_filter.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';

abstract class MessagingRepository {
  Future<GetConversationsResponse> getConversations(
      {ConversationsFilter? filter});

  Future<dynamic> getConversationById(String id);




  Future<dynamic> deleteConversationById(String id);

  Future<dynamic> createConversation(Map<String, dynamic> conversationData);

  Future<TalkamConversation> fetchCurrentConversation(String receiverId);

  Future<dynamic> updateConversationById(
      String id,bool status);

  Future<TalkamConversation> updateConversationStatus(
      {required String conversationId, required String status});

  Future<dynamic> reportConversation(Map<String, dynamic> reportData);

  Future<dynamic> sendMessage(AppMessageModel messageData);

  Future<GetMessagesResponse> getMessages(String conversationId);

  Future<dynamic> deleteConversation(String id);
}
