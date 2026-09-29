import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/chat_local_store.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/core/services/pusher/pusher_channel_service.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';
import 'package:talkam/features/messaging/dormain/mixins/messaging_formater_mixin.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/dormain/repository/messaging_repository.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

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

  /// [_listenForMessages] never unsubscribes as chat screens come and go —
  /// without this, a closed cubit's stale [onEventReceived] stays registered
  /// as the channel's handler and throws ("Cannot emit new states after
  /// calling close") the next time a message arrives while this screen
  /// isn't open, silently skipping the local-store write-through too.
  @override
  Future<void> close() async {
    final conversationId = currentConversation?.id;
    if (conversationId != null) {
      try {
        final pusherService = await PusherChannelService.getInstance;
        await pusherService.unsubscribe("private-conversation.$conversationId");
      } catch (e) {
        logger.w(e.toString());
      }
    }
    return super.close();
  }

  /// Every async operation in this cubit can outlive it — the user can
  /// leave the chat (which calls [close]) while a request is still in
  /// flight. Emitting after close throws ("Bad state: Cannot emit new
  /// states after calling close"), including from inside a `catch` block
  /// handling that very exception — which then escapes uncaught, since
  /// nothing wraps the catch body itself. Every emit in this class goes
  /// through here instead of calling `emit` directly.
  void _safeEmit(MessagingState state) {
    if (!isClosed) emit(state);
  }

  @override
  void resetForLogout() {
    currentConversation = null;
    messages = [];
    _currentPage = 1;
    _hasMorePages = false;
    _loadingMore = false;
    // ChatLocalStore.clearAll() is called centrally from
    // SessionManager.logOut() rather than here.
    _safeEmit(const MessagingState.initial());
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

    _safeEmit(const MessagingState.sendMessageLoading());
    _scrollToBottom();

    try {
      final response = await messagingRepository.sendMessage(message);

      _listenForMessages(currentConversation!.id.toString());

      // Reconciles the optimistic client-UUID entry with the server's real
      // id and writes it through to ChatLocalStore — mirrors what
      // onEventReceived already does for messages we receive. Without this,
      // a sent message only ever lived in this cubit's in-memory `messages`
      // list; navigating away (which closes this cubit) lost it from every
      // local source, leaving the next fetch as the only way to recover it.
      _reconcileSentMessage(message.id, response);

      // Called directly here rather than left to chat_screen.dart's
      // sendMessageSuccess listener: if the user has already navigated
      // away, ChatScreen.dispose() already closed this cubit, _safeEmit
      // below silently no-ops, and that listener never runs. This method
      // itself keeps running to completion regardless (Dart doesn't cancel
      // in-flight futures on cubit close), and ConversationsCubit is a
      // separate, persistent singleton — so this fires either way.
      _patchConversationsListFromSendResponse(response);

      _safeEmit(MessagingState.sendMessageSuccess(response));
    } catch (e) {
      messages.firstWhereOrNull((element) => element.id == message.id)
          ?.sendingState = SendingState.failed;
      _safeEmit(MessagingState.sendMessageFailure(e.toString()));
    }
  }

  Future<void> retryMessage(AppMessageModel message) async {
    messages.firstWhereOrNull((element) => element.id == message.id)
        ?.sendingState = SendingState.loading;

    _safeEmit(const MessagingState.sendMessageLoading());

    try {
      final response = await messagingRepository.sendMessage(message);

      _listenForMessages(currentConversation!.id.toString());
      _reconcileSentMessage(message.id, response);

      _patchConversationsListFromSendResponse(response);

      _safeEmit(MessagingState.sendMessageSuccess(response));
    } catch (e) {
      messages.firstWhereOrNull((element) => element.id == message.id)
          ?.sendingState = SendingState.failed;
      _safeEmit(MessagingState.sendMessageFailure(e.toString()));
    }
  }

  /// Replaces the optimistic entry (client-generated UUID `id`) with one
  /// carrying the server's real id, and persists it. The `id` swap matters
  /// beyond bookkeeping: ChatLocalStore.appendMessage and
  /// loadMoreMessages' merge both dedupe by `id` — a message stuck on its
  /// client UUID would never match the server's copy of itself once a real
  /// fetch reconciles the list, risking a visible duplicate.
  void _reconcileSentMessage(String localMessageId, dynamic response) {
    final index = messages.indexWhere((m) => m.id == localMessageId);
    try {
      final raw = Map<String, dynamic>.from(response);
      final data = raw['data'] is Map
          ? Map<String, dynamic>.from(raw['data'])
          : raw;
      if (index == -1) return;
      final reconciled = messages[index].copyWith(
        id: data['id'].toString(),
        sendingState: SendingState.success,
      );
      messages[index] = reconciled;
      ChatLocalStore.instance
          .appendMessage(reconciled.conversationId, reconciled.toJson());
    } catch (e) {
      logger.e('Failed to reconcile sent message: $e');
      // Still mark it as sent even if the id/persistence step failed —
      // better an un-reconciled optimistic entry than one stuck "sending".
      if (index != -1) messages[index].sendingState = SendingState.success;
    }
  }

  void _patchConversationsListFromSendResponse(dynamic response) {
    final conversationsCubit = injector.get<ConversationsCubit>();
    try {
      final raw = Map<String, dynamic>.from(response);
      // Every other endpoint observed this session wraps its payload in
      // {message, data, success, code} — unwrap if present, otherwise
      // assume the flat shape.
      final data = raw['data'] is Map
          ? Map<String, dynamic>.from(raw['data'])
          : raw;
      conversationsCubit.patchConversationPreview(
            conversationId: data['conversation_id'].toString(),
            lastMessageId: data['id'],
            senderId: data['sender_id'],
            message: data['message'] ?? '',
            createdAt: DateTime.parse(data['created_at']),
          );
    } catch (e) {
      logger.e('Failed to patch conversation preview after send: $e');
    }
    // patchConversationPreview only updates an already-loaded
    // getConversationsListSuccess state. In practice ConversationsCubit
    // usually isn't in that state at this point: opening a chat from the
    // Messages list calls markConversationSeen() first, which routes
    // through _updateConversationState('seen', ...) — that deliberately
    // skips its own list refetch (to avoid hitting the endpoint on every
    // single tap), leaving the cubit sitting on conversationStateSuccess
    // for the rest of the session. So the patch above is a no-op most of
    // the time; this real refetch is what actually keeps the list
    // in sync, and — unlike refreshAllConversations() in chat_screen.dart's
    // listener — it doesn't depend on the chat screen still being mounted.
    conversationsCubit.getConversationsList(reload: false);
  }

  Future<void> getMessages(String conversationId) async {
    try {
      final response = await messagingRepository.getMessages(conversationId);
      final fetchedMessages = sortAndInsertDividers(response.data.data
          .map((e) => AppMessageModel.fromResponse(e))
          .where((msg) => msg.messageType != "divider")
          .toList());
      messages = fetchedMessages;
      _currentPage = response.data.paginationMeta.currentPage;
      _hasMorePages = response.data.paginationMeta.canLoadMore;
      final messagesJson = fetchedMessages.map((e) => e.toJson()).toList();
      await ChatLocalStore.instance.saveMessages(conversationId, messagesJson);
      _safeEmit(const MessagingState.getMessagesSuccess());
      _scrollToBottom(animate: false);
      _listenForMessages(currentConversation!.id.toString());
    } catch (e, stack) {
      log(stack.toString());
      _safeEmit(MessagingState.getMessagesFailure(e.toString()));
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
      _safeEmit(const MessagingState.getMessagesSuccess());
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
    _safeEmit(const MessagingState.deleteConversationLoading());
    try {
      await messagingRepository.deleteConversation(id);
      _safeEmit(const MessagingState.deleteConversationSuccess());
    } catch (e, stack) {
      _safeEmit(MessagingState.deleteConversationFailure(e.toString()));
    }
  }

  Future<void> fetchCurrentConversation(String receiverId,
      {bool refresh = true, TalkamConversation? knownConversation}) async {
    String? storedConversationId = await getStoredConversationId(receiverId);

    if (storedConversationId != null) {
      final cachedData =
          ChatLocalStore.instance.getCachedMessages(storedConversationId);
      if (cachedData != null && cachedData.isNotEmpty) {
        final rawCachedMessages = sortAndInsertDividers(cachedData
            .map((e) => AppMessageModel.fromJson(e))
            .where((msg) => msg.messageType.toLowerCase() != "divider")
            .toList());
        final cachedMessages = rawCachedMessages;
        messages = cachedMessages;
        _safeEmit(const MessagingState.getMessagesSuccess());
        _scrollToBottom(animate: false);
        if (!refresh) {
          return;
        }
      }
    }
    // Only show a blocking loading state when there's nothing cached to
    // display yet — a background refresh over already-visible cached
    // messages shouldn't hide them behind a spinner.
    if (messages.isEmpty) {
      _safeEmit(const MessagingState.fetchCurrentConversationLoading());
    }

    try {
      // If the caller already has the correct conversation (e.g. tapped
      // from the v2 conversations list), use it directly instead of
      // re-resolving through this v1-only endpoint — it doesn't reliably
      // recognize conversations that only ever went through v2, which was
      // silently producing an empty message list for those chats.
      final response = knownConversation ??
          await messagingRepository.fetchCurrentConversation(receiverId);
      currentConversation = response;
      // Store the conversation ID persistently.
      await storeConversationId(receiverId, response.id.toString());
      getMessages(response.id.toString());
    } catch (e, stack) {
      _safeEmit(MessagingState.fetchCurrentConversationFailure(e.toString()));
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
  //       _safeEmit(MessagingState.getMessagesSuccess(cachedMessages));

  //       // If you don't want to refresh when cache exists, return early.
  //       if (!refresh!) {
  //         return;
  //       }
  //     }
  //   }
  //   if (refresh!) {
  //     // _safeEmit(const MessagingState.fetchCurrentConversationLoading());
  //   }

  //   try {

  //     final response = await messagingRepository.fetchCurrentConversation(receiverId);

  //     currentConversation = response;

  //     getMessages(response.id.toString(), refresh: refresh);
  //     // _safeEmit(MessagingState.fetchCurrentConversationSuccess(response));
  //   } catch (e, stack) {
  //     _safeEmit(MessagingState.fetchCurrentConversationFailure(e.toString()));
  //   }
  // }

  Future<void> updateConversationStatus(
      {required String conversationId, required String status}) async {
    _safeEmit(const MessagingState.updateConversationStatusLoading());
    try {
      final response = await messagingRepository.updateConversationStatus(
          conversationId: conversationId, status: status);
      currentConversation = null;

      _safeEmit(MessagingState.updateConversationStatusSuccess(response));
    } catch (e, stack) {
      _safeEmit(MessagingState.updateConversationStatusFailure(e.toString()));
    }
  }

  // void init({TalkamConversation? conversation, required String receiverId}) {
  //   if (conversation == null) {
  //     fetchCurrentConversation(receiverId, conversation!.id.toString());
  //   } else {
  //     currentConversation = conversation;
  //     _safeEmit(MessagingState.fetchCurrentConversationSuccess(currentConversation!));
  //   }
  // }
  void init({TalkamConversation? conversation, required String receiverId}) {
    if (conversation == null) {
      // No conversation known yet — resolve it via the v1 endpoint.
      fetchCurrentConversation(receiverId, refresh: true);
    } else {
      // Already have the correct (v2) conversation — use it directly rather
      // than re-resolving it through the v1 endpoint.
      currentConversation = conversation;
      fetchCurrentConversation(receiverId, knownConversation: conversation);
    }
  }

  Future<String?> getStoredConversationId(String receiverId) async {
    return ChatLocalStore.instance.getStoredConversationId(receiverId);
  }

  Future<void> storeConversationId(
      String receiverId, String conversationId) async {
    await ChatLocalStore.instance.storeConversationId(
        receiverId, conversationId);
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
          pusher.onAuthorizer = PusherChannelService.authorize;

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
          pusher.onAuthorizer = PusherChannelService.authorize;

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

  onSubscriptionError(message, d) {
    logger.e(message);
  }

  onEventReceived(event) {
    // Defensive — [close] unsubscribes the channel, but guard anyway
    // against any event that lands in the gap before that completes.
    if (isClosed) return;
    try {
      var receivedEvent = (event as PusherEvent);
      logger.i('received chat message${receivedEvent.data}');

      if (receivedEvent.eventName ==
          'receive-message.${injector.get<ProfileBloc>().appUser?.id}') {
        logger.i('received chat message${receivedEvent.data}');

        final talkamMessage =
            TalkamMessage.fromJson(jsonDecode(receivedEvent.data)["data"]);
        final newMessage = AppMessageModel.fromResponse(talkamMessage);

        if (!newMessage.iAmSender) {
          logger.i('adding chat message');

          messages = sortAndInsertDividers(messages
            ..add(newMessage)
            ..removeWhere(
              (element) => element.messageType == "divider",
            ));
          _safeEmit(MessagingState.messageUpdated(newMessage));

          // Write-through so this message survives a cold restart even if
          // the next full fetch doesn't happen first, and patch the
          // conversations list locally instead of triggering a network
          // refetch — the one case where this cubit already has live
          // message content (Pusher subscription is scoped to whichever
          // conversation is currently open).
          ChatLocalStore.instance
              .appendMessage(newMessage.conversationId, newMessage.toJson());
          injector.get<ConversationsCubit>().patchConversationPreview(
                conversationId: newMessage.conversationId,
                lastMessageId: talkamMessage.id,
                senderId: talkamMessage.senderId,
                message: talkamMessage.message ?? '',
                createdAt: talkamMessage.createdAt,
                assetUrl: talkamMessage.assetUrl?.toString() ?? '',
              );
        }

        logger.i(receivedEvent.data.runtimeType);
      }
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
    }
  }
}
