import 'dart:io';
import 'package:dio/dio.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/firebase_storage/firebase_storage_service.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/messaging/data/models/conversation_state_response.dart';
import 'package:talkam/features/messaging/data/models/conversations_filter.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/dormain/repository/messaging_repository.dart';

class MessagingRepositoryImpl extends MessagingRepository {
  final NetworkService _networkService;
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  MessagingRepositoryImpl(this._networkService);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  /// The Authorization header is automatically injected by the network
  /// service's auth interceptor.
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

  @override
  Future<GetConversationsResponse> getConversations(
      {ConversationsFilter? filter}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getConversations, RequestMethod.get,
          queryParams: filter?.toJson());

      return GetConversationsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e("${e}${stack}");

      rethrow;
    }
  }

  @override
  Future<GetConversationsListResponse> getConversationsList(
      {int? page, bool? archived, bool? starred}) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.messagingConversations,
        RequestMethod.get,
        queryParams: {
          "page": (page ?? 1).toString(),
          if (archived == true) "archived": "1",
          if (starred == true) "starred": "1",
        },
      );
      return GetConversationsListResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ConversationStateResponse> updateConversationState({
    required String action,
    required String conversationId,
    String? mutedUntil,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.conversationState(action),
        RequestMethod.post,
        formData: FormData.fromMap({
          "conversation_id": conversationId,
          if (mutedUntil != null) "muted_until": mutedUntil,
        }),
        options: _formOptions,
      );
      return ConversationStateResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getConversationById(String id) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.getConversationById}/$id',
        RequestMethod.get,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteConversationById(String id) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.deleteConversation}/$id',
        RequestMethod.delete,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> createConversation(
      Map<String, dynamic> conversationData) async {
    try {
      final response = await _networkService.call(
        UrlConfig.createConversation,
        RequestMethod.post,
        data: conversationData,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamConversation> fetchCurrentConversation(String receiverId) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.fetchCurrentConversation}?receiver_id=$receiverId',
        RequestMethod.get,
      );

      return TalkamConversation.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> updateConversationById(String id, bool status) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.updateConversationById}/$id',
        RequestMethod.put,
        data: {"notification_status": status.toInt},
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamConversation> updateConversationStatus(
      {required String conversationId, required String status}) async {
    try {
      final response = await _networkService.call(
        UrlConfig.updateConversationStatus,
        RequestMethod.post,
        data: {"status": status, "conversation_id": conversationId},
      );
      return TalkamConversation.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> reportConversation(Map<String, dynamic> reportData) async {
    try {
      final response = await _networkService.call(
        UrlConfig.reportConversation,
        RequestMethod.post,
        data: reportData,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> sendMessage(AppMessageModel messageData) async {
    var imageUrl = messageData.assetUrl != null
        ? (await FirebaseStorageService().uploadMultipleFiles(
                FirebaseStoragePaths.chatFiles, [File(messageData.assetUrl!)]))
            .first
        : null;

    try {
      final response = await _v2.call(
        UrlConfigV2.messagingMessagesSend,
        RequestMethod.post,
        data: messageData.copyWith(assetUrl: imageUrl).toJson(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetMessagesResponse> getMessages(String conversationId) async {
    try {
      final response = await _v2.call(
          UrlConfigV2.messagingMessagesList, RequestMethod.get,
          queryParams: {"conversation_id": conversationId});
      return GetMessagesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteConversation(String id) async {
    try {
      final response = await _networkService.call(
        '${UrlConfig.deleteConversation}/$id',
        RequestMethod.delete,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TalkamConversation> startConversation({
    required int receiverId,
    required String message,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.messagingConversations,
        RequestMethod.post,
        formData: FormData.fromMap({
          "receiver_id": receiverId,
          "message": message,
        }),
        options: _formOptions,
      );
      return TalkamConversation.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
