import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/core/services/pusher/pusher_channel_service.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';
import 'package:talkam/features/messaging/dormain/mixins/messaging_formater_mixin.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/dormain/repository/messaging_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

import '../message_hive/message.dart';

part 'messaging_state.dart';

part 'messaging_cubit.freezed.dart';

class MessagingCubit extends Cubit<MessagingState>
    with MessagingFormatterMixin
    implements ResettableOnLogout {
  final MessagingRepository messagingRepository;

  TalkamConversation? currentConversation;
  List<AppMessageModel> messages = [];
  final ScrollController listController = ScrollController();

  int _currentPage = 1;
  bool _hasMorePages = false;
  bool _loadingMore = false;

  MessagingCubit(
    this.messagingRepository,
  ) : super(const MessagingState.initial());

  @override
  void resetForLogout() {
    currentConversation = null;
    messages = [];
    _currentPage = 1;
    _hasMorePages = false;
    _loadingMore = false;
    emit(const MessagingState.initial());
  }

  void _scrollToBottom({bool animate = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listController.hasClients) {
        if (animate) {
          listController.animateTo(
            listController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        } else {
          listController.jumpTo(listController.position.maxScrollExtent);
        }
      }
    });
  }

  Future<void> sendMessage(AppMessageModel message) async {
    final rawList = [
      ...messages.where((m) => m.messageType != "divider"),
      message,
    ];
    messages = sortAndInsertDividers(rawList);

    emit(const MessagingState.sendMessageLoading());
    _scrollToBottom();

    try {
      final response = await messagingRepository.sendMessage(message);

      _listenForMessages(currentConversation!.id.toString());

      // The message being tracked may no longer be in `messages` if a
      // concurrent fetch replaced the list while this send was in
      // flight — look it up defensively instead of assuming `.first`
      // always finds a match (that throws an uncaught StateError here).
      messages.firstWhereOrNull((element) => element.id == message.id)
          ?.sendingState = SendingState.success;

      emit(MessagingState.sendMessageSuccess(response));
    } catch (e) {
      messages.firstWhereOrNull((element) => element.id == message.id)
          ?.sendingState = SendingState.failed;
      emit(MessagingState.sendMessageFailure(e.toString()));
    }
  }

  Future<void> retryMessage(AppMessageModel message) async {
    messages.firstWhereOrNull((element) => element.id == message.id)
        ?.sendingState = SendingState.loading;

    emit(const MessagingState.sendMessageLoading());

    try {
      final response = await messagingRepository.sendMessage(message);

      _listenForMessages(currentConversation!.id.toString());
      messages.firstWhereOrNull((element) => element.id == message.id)
          ?.sendingState = SendingState.success;

      emit(MessagingState.sendMessageSuccess(response));
    } catch (e) {
      messages.firstWhereOrNull((element) => element.id == message.id)
          ?.sendingState = SendingState.failed;
      emit(MessagingState.sendMessageFailure(e.toString()));
    }
  }

  Future<void> getMessages(String conversationId, {bool refresh = true}) async {
    try {
      final response = await messagingRepository.getMessages(conversationId);
      final fetchedMessages = sortAndInsertDividers(response.data.data
          .map((e) => AppMessageModel.fromResponse(e))
          .where((msg) => msg.messageType != "divider")
          .toList());
      messages = fetchedMessages;
      _currentPage = response.data.paginationMeta.currentPage;
      _hasMorePages = response.data.paginationMeta.canLoadMore;
      final Box cacheBox = await Hive.openBox('chatCache');
      final messagesJson = fetchedMessages.map((e) => e.toJson()).toList();
      cacheBox.put(conversationId, messagesJson);
      emit(MessagingState.getMessagesSuccess(response));
      _scrollToBottom(animate: false);
      _listenForMessages(currentConversation!.id.toString());
    } catch (e, stack) {
      log(stack.toString());
      emit(MessagingState.getMessagesFailure(e.toString()));
    }
  }

  /// Loads the next page of older messages and merges them into the
  /// existing list (deduped by id, then re-sorted/re-dividered — the
  /// backend's own ordering doesn't need to be trusted since messages are
  /// always sorted by [time] locally anyway). Call when the user scrolls
  /// up towards the start of the conversation.
  Future<void> loadMoreMessages() async {
    if (_loadingMore || !_hasMorePages || currentConversation == null) return;
    _loadingMore = true;
    try {
      final nextPage = _currentPage + 1;
      final response = await messagingRepository.getMessages(
        currentConversation!.id.toString(),
        page: nextPage,
      );
      final olderMessages = response.data.data
          .map((e) => AppMessageModel.fromResponse(e))
          .where((msg) => msg.messageType != "divider")
          .toList();

      final existingIds = messages
          .where((m) => m.messageType != "divider")
          .map((m) => m.id)
          .toSet();
      final merged = [
        ...messages.where((m) => m.messageType != "divider"),
        ...olderMessages.where((m) => !existingIds.contains(m.id)),
      ];
      messages = sortAndInsertDividers(merged);
      _currentPage = response.data.paginationMeta.currentPage;
      _hasMorePages = response.data.paginationMeta.canLoadMore;
      emit(MessagingState.getMessagesSuccess(response));
    } catch (e, stack) {
      log(stack.toString());
      // Best-effort — leave the currently-loaded messages as they are
      // rather than surfacing an error for a background pagination
      // fetch the user didn't explicitly request.
    } finally {
      _loadingMore = false;
    }
  }

  /// Starts a brand-new conversation with its first message in one call —
  /// used when there's no existing conversation to fetch (e.g. messaging a
  /// client for the first time). Returned directly rather than through a
  /// bloc state since the caller needs the created conversation immediately
  /// to navigate into [ChatScreen].
  Future<TalkamConversation> startConversation({
    required int receiverId,
    required String message,
  }) {
    return messagingRepository.startConversation(
      receiverId: receiverId,
      message: message,
    );
  }

  Future<void> deleteConversation(String id) async {
    emit(const MessagingState.deleteConversationLoading());
    try {
      await messagingRepository.deleteConversation(id);
      emit(const MessagingState.deleteConversationSuccess());
    } catch (e, stack) {
      emit(MessagingState.deleteConversationFailure(e.toString()));
    }
  }

  Future<void> fetchCurrentConversation(String receiverId,
      {bool refresh = true}) async {
    String? storedConversationId = await getStoredConversationId(receiverId);
    final Box cacheBox = await Hive.openBox('chatCache');
    log("Cache keys: ${cacheBox.keys.toList()}");

    if (storedConversationId != null) {
      if (cacheBox.containsKey(storedConversationId)) {
        final cachedData =
            cacheBox.get(storedConversationId) as List<dynamic>? ?? [];
        if (cachedData.isNotEmpty) {
          final rawCachedMessages = sortAndInsertDividers(cachedData
              .map(
                  (e) => AppMessageModel.fromJson(Map<String, dynamic>.from(e)))
              .where((msg) => msg.messageType.toLowerCase() != "divider")
              .toList());
          final cachedMessages = rawCachedMessages;
          messages = cachedMessages;
          emit(MessagingState.getMessagesSuccess(cachedMessages));
          _scrollToBottom(animate: false);
          if (!refresh) {
            return;
          }
        }
      }
    }
    if (refresh) {
      // emit(const MessagingState.fetchCurrentConversationLoading());
    }

    try {
      // Fetch conversation details from the API.
      final response =
          await messagingRepository.fetchCurrentConversation(receiverId);
      currentConversation = response;
      // Store the conversation ID persistently.
      await storeConversationId(receiverId, response.id.toString());
      getMessages(response.id.toString(), refresh: refresh);
    } catch (e, stack) {
      emit(MessagingState.fetchCurrentConversationFailure(e.toString()));
    }
  }

  // Future<void> fetchCurrentConversation(String receiverId,  String conversationId, {bool? refresh = true}) async {
  //   final Box cacheBox = await Hive.openBox('chatCache');
  //   log("Cache keys: ${cacheBox.keys.toList()}");

  //   log("Cache keys: $conversationId");
  //   log("cache: ${cacheBox.containsKey(conversationId)}");
  //   if (cacheBox.containsKey(conversationId)) {
  //       log("cache box: $cacheBox");

  //     final cachedData = cacheBox.get(conversationId) as List<dynamic>? ?? [];
  //       log("from cache: $cachedData");

  //     if (cachedData.isNotEmpty) {
  //       final rawCachedMessages = cachedData
  //         .map((e) => AppMessageModel.fromJson(Map<String, dynamic>.from(e)))
  //         .where((element) => element.messageType != "divider")
  //         .toList();

  //     final cachedMessages = sortAndInsertDividers(rawCachedMessages);
  //     log("Fetched from cache: $cachedMessages");

  //       messages = cachedMessages;
  //       emit(MessagingState.getMessagesSuccess(cachedMessages));

  //       // If you don't want to refresh when cache exists, return early.
  //       if (!refresh!) {
  //         return;
  //       }
  //     }
  //   }
  //   if (refresh!) {
  //     // emit(const MessagingState.fetchCurrentConversationLoading());
  //   }

  //   try {

  //     final response = await messagingRepository.fetchCurrentConversation(receiverId);

  //     currentConversation = response;

  //     getMessages(response.id.toString(), refresh: refresh);
  //     // emit(MessagingState.fetchCurrentConversationSuccess(response));
  //   } catch (e, stack) {
  //     emit(MessagingState.fetchCurrentConversationFailure(e.toString()));
  //   }
  // }

  Future<void> updateConversationStatus(
      {required String conversationId, required String status}) async {
    emit(const MessagingState.updateConversationStatusLoading());
    try {
      final response = await messagingRepository.updateConversationStatus(
          conversationId: conversationId, status: status);
      currentConversation = null;

      emit(MessagingState.updateConversationStatusSuccess(response));
    } catch (e, stack) {
      emit(MessagingState.updateConversationStatusFailure(e.toString()));
    }
  }

  // void init({TalkamConversation? conversation, required String receiverId}) {
  //   if (conversation == null) {
  //     fetchCurrentConversation(receiverId, conversation!.id.toString());
  //   } else {
  //     currentConversation = conversation;
  //     emit(MessagingState.fetchCurrentConversationSuccess(currentConversation!));
  //   }
  // }
  void init({TalkamConversation? conversation, required String receiverId}) {
    if (conversation == null) {
      // If conversation is null, call fetchCurrentConversation with only the receiverId.
      fetchCurrentConversation(receiverId, refresh: true);
    } else {
      // If a conversation is provided, pass its id (as a string) to fetchCurrentConversation.
      currentConversation = conversation;
      storeConversationId(receiverId, conversation.id.toString());
      fetchCurrentConversation(receiverId);
      emit(
          MessagingState.fetchCurrentConversationSuccess(currentConversation!));
    }
  }

  Future<String?> getStoredConversationId(String receiverId) async {
    final Box conversationBox = await Hive.openBox('conversationCache');
    return conversationBox.get(receiverId) as String?;
  }

  Future<void> storeConversationId(
      String receiverId, String conversationId) async {
    final Box conversationBox = await Hive.openBox('conversationCache');
    await conversationBox.put(receiverId, conversationId);
  }

  void _listenForMessages(String conversationId) async {
    logger.w('listening');
    try {
      var pusherService = await PusherChannelService.getInstance;
      var pusher = await pusherService.getClient;
      if (pusher != null) {
        logger.w('connecting');

        if (!pusher.channels
            .containsKey("private-conversation.$conversationId")) {
          pusher.onAuthorizer = _authorize;

          PusherChannel channel = await pusher.subscribe(
            channelName: "private-conversation.$conversationId",
            onSubscriptionError: (message, d) =>
                onSubscriptionError(message, d),
            onSubscriptionSucceeded: (data) {
              // log('subscribed');
              // AppUtils.showCustomToast("onSubscriptionSucceeded:  data: $data");
              // return data;a
            },
            onEvent: (event) => onEventReceived(event),
          );
          logger.w('connected');
        } else {
          logger.w('connected2');
          pusher.onAuthorizer = _authorize;

          pusher
              .getChannel("private-conversation.${currentConversation?.id}")
              ?.onEvent = onEventReceived;
        }
        await pusher.connect();
      }
    } catch (e, s) {
      logger.w(e.toString());
      // SentryService.captureException(e, stackTrace: s);
    }
  }

  // TODO(backend): this signs the private-channel auth challenge
  // client-side with a key baked into the app, instead of verifying it
  // server-side. Whoever has the app's binary can derive a valid auth
  // response for any conversation id — fine for now, but move this to a
  // real backend auth endpoint before relying on it for anything private.
  _authorize(String channelName, String socketId, options) async {
    // Sign whichever channel is actually being authorized, not whatever
    // `currentConversation` happens to be at call time — those can
    // diverge if a reauth for a different conversation's channel comes
    // in while this cubit has since moved on to another one (the
    // underlying Pusher client is a process-wide singleton).
    return {
      "auth": "1934aa1e05c3acfdfd3f:${getSignature("$socketId:$channelName")}",
    };
  }

  getSignature(String value) {
    var key = utf8.encode('0bfd461496258bd6e236');
    var bytes = utf8.encode(value);
    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    logger.d("HMAC signature in string is: $digest");
    return digest;
  }

  onSubscriptionError(message, d) {
    logger.e(message);
  }

  onEventReceived(event) {
    try {
      var receivedEvent = (event as PusherEvent);
      logger.i('received chat message${receivedEvent.data}');

      if (receivedEvent.eventName ==
          'receive-message.${injector.get<ProfileBloc>().appUser?.id}') {
        logger.i('received chat message${receivedEvent.data}');
        // var dataMap = jsonDecode(receivedEvent.data);

        final newMessage = AppMessageModel.fromResponse(
            TalkamMessage.fromJson(jsonDecode(receivedEvent.data)["data"]));

        if (!newMessage.iAmSender) {
          logger.i('adding chat message');

          messages = sortAndInsertDividers(messages
            ..add(newMessage)
            ..removeWhere(
              (element) => element.messageType == "divider",
            ));
          emit(MessagingState.messageUpdated(newMessage));
          // listController.jumpTo(0);
        }

        logger.i(receivedEvent.data.runtimeType);
      }
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
    }
  }
}
