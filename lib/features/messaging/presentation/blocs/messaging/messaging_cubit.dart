import 'dart:async';
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
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/messaging/chat_realtime_coordinator.dart';
import 'package:talkam/core/services/network/network_service.dart' show RequestMethod;
import 'package:talkam/core/services/pusher/pusher_channel_service.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart'
    show MessageReaction;
import 'package:talkam/features/messaging/dormain/mixins/messaging_formater_mixin.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/dormain/repository/messaging_repository.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';

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
  int _messagesRevision = 0;

  /// Ephemeral UI-only state (typing/presence) deliberately bypasses the
  /// freezed [MessagingState] union — adding new cases there means hand-
  /// editing the generated `.freezed.dart` file (build_runner is currently
  /// broken in this repo), and neither of these needs to survive a
  /// rebuild the way a real message does. Both are UNCONFIRMED — see
  /// [notifyTyping]/[_subscribeToPresence].
  final ValueNotifier<bool> isOtherUserTypingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isOtherUserOnlineNotifier = ValueNotifier(false);
  Timer? _typingClearTimer;
  String? _presenceChannelName;

  MessagingCubit(
    this.messagingRepository,
  ) : super(const MessagingState.initial());

  /// The `private-conversation.{id}` Pusher subscription itself is owned
  /// globally by [ChatRealtimeCoordinator] now, not per-screen — it stays
  /// alive after this cubit closes so the conversation keeps receiving
  /// background updates. Only this cubit's registration as the "active"
  /// (forward live updates here) cubit needs clearing. The presence
  /// subscription (unlike the conversation-message one) genuinely is
  /// per-screen — no reason to keep watching a user's online status once
  /// their chat is closed — so it's unsubscribed here.
  @override
  Future<void> close() async {
    ChatRealtimeCoordinator.instance.clearActiveCubit(this);
    _typingClearTimer?.cancel();
    isOtherUserTypingNotifier.dispose();
    isOtherUserOnlineNotifier.dispose();
    if (_presenceChannelName != null) {
      try {
        final pusherService = await PusherChannelService.getInstance;
        await pusherService.unsubscribe(_presenceChannelName!);
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
    _messagesRevision = 0;
    ChatRealtimeCoordinator.instance.clearActiveCubit(this);
    // ChatLocalStore.clearAll() is called centrally from
    // SessionManager.logOut() rather than here.
    _safeEmit(const MessagingState.initial());
  }

  // The message list is built with `reverse: true`, so the newest message
  // sits at scroll offset 0 (== minScrollExtent) rather than
  // maxScrollExtent. Only called when the user needs to be snapped back to
  // it explicitly — e.g. after sending while scrolled up into history —
  // not for the initial load, which `reverse: true` already anchors there
  // by construction with no jump needed.
  void _scrollToBottom({bool animate = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listController.hasClients) {
        if (animate) {
          listController.animateTo(
            listController.position.minScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        } else {
          listController.jumpTo(listController.position.minScrollExtent);
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

      _registerRealtime();

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

      _registerRealtime();
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

  // --- Message actions (edit/delete/forward/react/pin) ---
  //
  // All backed by MessagingRepository.updateMessageState(), whose endpoint
  // is an UNVERIFIED guess (see its doc comment) — these apply the change
  // optimistically to `messages`/emit immediately, then revert if the
  // network call fails. Callers (the message action sheet) should wrap
  // these in try/catch and show the error, since a wrong-guessed endpoint
  // will surface as a real failure here until confirmed/fixed.

  Future<void> editMessage(String messageId, String newContent) async {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final original = messages[index];
    final optimistic =
        original.copyWith(content: newContent, editedAt: DateTime.now());
    messages[index] = optimistic;
    _safeEmit(MessagingState.messageUpdated(optimistic));
    try {
      await messagingRepository.updateMessageState(
        action: 'edit',
        messageId: messageId,
        extra: {'message': newContent},
      );
      ChatLocalStore.instance
          .upsertMessage(optimistic.conversationId, optimistic.toJson());
    } catch (e, stack) {
      logger.e('Failed to edit message $messageId', error: e, stackTrace: stack);
      messages[index] = original;
      _safeEmit(MessagingState.messageUpdated(original));
      rethrow;
    }
  }

  /// Soft-delete — flips [AppMessageModel.isDeleted] rather than clearing
  /// `content` (which `copyWith`'s `?? this.x` pattern can't null out
  /// anyway); the UI checks `isDeleted` before reading `content`.
  Future<void> deleteMessage(String messageId) async {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final original = messages[index];
    final optimistic = original.copyWith(isDeleted: true);
    messages[index] = optimistic;
    _safeEmit(MessagingState.messageUpdated(optimistic));
    try {
      // Confirmed (2026-09-29): DELETE-only, same as react's removal —
      // POST 405s with "Supported methods: DELETE".
      await messagingRepository.updateMessageState(
        action: 'delete',
        messageId: messageId,
        method: RequestMethod.delete,
      );
      ChatLocalStore.instance
          .upsertMessage(optimistic.conversationId, optimistic.toJson());
    } catch (e, stack) {
      logger.e('Failed to delete message $messageId', error: e, stackTrace: stack);
      messages[index] = original;
      _safeEmit(MessagingState.messageUpdated(original));
      rethrow;
    }
  }

  /// No optimistic local update — forwarding creates new messages in the
  /// target conversations, it doesn't change this one.
  Future<void> forwardMessage(
      String messageId, List<String> targetConversationIds) async {
    await messagingRepository.updateMessageState(
      action: 'forward',
      messageId: messageId,
      extra: {'conversation_ids': targetConversationIds},
    );
  }

  /// STILL BROKEN (2026-09-29): `POST /messages/react` 405s — the server
  /// only accepts DELETE there (that's [removeReaction]'s route). The
  /// correct verb/route for *adding* a reaction is unconfirmed; this will
  /// keep failing (and correctly revert the optimistic update below) until
  /// that's known. Don't remove the optimistic-then-revert structure to
  /// "fix" the visible flash — the flash is honest, the call really fails.
  Future<void> addReaction(String messageId, String reaction) async {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final original = messages[index];
    final myUserId =
        int.tryParse(SessionManager().usersData["id"].toString()) ?? -1;
    final optimistic = original.copyWith(reactions: [
      ...original.reactions.where((r) => r.userId != myUserId),
      MessageReaction(userId: myUserId, reaction: reaction),
    ]);
    messages[index] = optimistic;
    _safeEmit(MessagingState.messageUpdated(optimistic));
    try {
      await messagingRepository.updateMessageState(
        action: 'react',
        messageId: messageId,
        extra: {'reaction': reaction},
      );
      ChatLocalStore.instance
          .upsertMessage(optimistic.conversationId, optimistic.toJson());
    } catch (e, stack) {
      logger.e('Failed to react to message $messageId', error: e, stackTrace: stack);
      messages[index] = original;
      _safeEmit(MessagingState.messageUpdated(original));
      rethrow;
    }
  }

  Future<void> removeReaction(String messageId) async {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final original = messages[index];
    final myUserId =
        int.tryParse(SessionManager().usersData["id"].toString()) ?? -1;
    final optimistic = original.copyWith(
      reactions: original.reactions.where((r) => r.userId != myUserId).toList(),
    );
    messages[index] = optimistic;
    _safeEmit(MessagingState.messageUpdated(optimistic));
    try {
      // Confirmed (2026-09-29): the backend only accepts DELETE on this
      // path — POST 405s with "Supported methods: DELETE".
      await messagingRepository.updateMessageState(
        action: 'react',
        messageId: messageId,
        method: RequestMethod.delete,
      );
      ChatLocalStore.instance
          .upsertMessage(optimistic.conversationId, optimistic.toJson());
    } catch (e, stack) {
      logger.e('Failed to remove reaction from message $messageId',
          error: e, stackTrace: stack);
      messages[index] = original;
      _safeEmit(MessagingState.messageUpdated(original));
      rethrow;
    }
  }

  Future<void> togglePin(String messageId) async {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final original = messages[index];
    final optimistic = original.copyWith(isPinned: !original.isPinned);
    messages[index] = optimistic;
    _safeEmit(MessagingState.messageUpdated(optimistic));
    try {
      await messagingRepository.updateMessageState(
        action: optimistic.isPinned ? 'pin' : 'unpin',
        messageId: messageId,
      );
      ChatLocalStore.instance
          .upsertMessage(optimistic.conversationId, optimistic.toJson());
    } catch (e, stack) {
      logger.e('Failed to toggle pin on message $messageId', error: e, stackTrace: stack);
      messages[index] = original;
      _safeEmit(MessagingState.messageUpdated(original));
      rethrow;
    }
  }

  /// No local optimistic update — this tells the server (and, indirectly,
  /// the other party via a `MessageRead` broadcast to them) that every
  /// unread message *I received* in this conversation is now read; it
  /// doesn't change anything about messages *I sent*, which is the only
  /// thing rendered in my own checkmarks. UNVERIFIED endpoint — see
  /// [MessagingRepository.bulkMarkRead]'s doc comment.
  Future<void> bulkMarkRead() async {
    if (currentConversation == null) return;
    final conversationId = currentConversation!.id.toString();
    try {
      final response = await messagingRepository.bulkMarkRead(conversationId);
      logger.i(
          'BULK MARK READ OK -> conversation=$conversationId, response=$response');
    } catch (e, stack) {
      logger.e('BULK MARK READ FAILED -> conversation=$conversationId',
          error: e, stackTrace: stack);
      rethrow;
    }
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
      // No _scrollToBottom() here — `reverse: true` on the ListView already
      // anchors the newest message at scroll offset 0 by construction, and
      // forcing a jump on every background refresh would yank the user
      // away from wherever they'd scrolled to read history.
      _safeEmit(MessagingState.getMessagesSuccess(++_messagesRevision));
      _registerRealtime();
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
      _safeEmit(MessagingState.getMessagesSuccess(++_messagesRevision));
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
    // Normally already primed synchronously by init() before this ever
    // runs — this is a no-op then (guarded by the messages.isEmpty check
    // inside). Still needed as a real fallback for callers that invoke
    // this directly without going through init() first.
    _primeMessagesFromCache(receiverId);

    if (messages.isNotEmpty) {
      // No _scrollToBottom() — `reverse: true` on the ListView anchors
      // the newest message at scroll offset 0 on first paint already.
      _safeEmit(MessagingState.getMessagesSuccess(++_messagesRevision));
      if (!refresh) {
        return;
      }
    } else {
      // Only show a blocking loading state when there's nothing cached to
      // display yet — a background refresh over already-visible cached
      // messages shouldn't hide them behind a spinner.
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
      _registerRealtime();
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
    // Must run synchronously, before ChatScreen's first build() — even a
    // single `await` on a function that's merely *declared* async (as
    // getStoredConversationId used to be, despite its body being a plain
    // Hive read) is enough for Dart to defer the continuation by a
    // microtask, which is enough for Flutter to paint one shimmer frame
    // first. Priming `messages` here instead means a previously-cached
    // conversation never flashes it at all.
    _primeMessagesFromCache(receiverId);
    _subscribeToPresence(receiverId);

    if (conversation == null) {
      // No conversation known yet — resolve it via the v1 endpoint.
      fetchCurrentConversation(receiverId, refresh: true);
    } else {
      // Already have the correct (v2) conversation — use it directly rather
      // than re-resolving it through the v1 endpoint.
      currentConversation = conversation;
      _registerRealtime();
      fetchCurrentConversation(receiverId, knownConversation: conversation);
    }
  }

  /// Synchronous by design (see [init]) — do not make this `async`, even
  /// though nothing inside currently awaits anything. Runs directly inside
  /// initState(), so any exception here is a synchronous build-time crash
  /// rather than an async error Dart would otherwise report without
  /// bringing the widget down — guard it accordingly.
  void _primeMessagesFromCache(String receiverId) {
    if (messages.isNotEmpty) return;
    try {
      final storedConversationId = getStoredConversationId(receiverId);
      if (storedConversationId == null) return;
      final cachedData =
          ChatLocalStore.instance.getCachedMessages(storedConversationId);
      if (cachedData == null || cachedData.isEmpty) return;
      messages = sortAndInsertDividers(cachedData
          .map((e) => AppMessageModel.fromJson(e))
          .where((msg) => msg.messageType.toLowerCase() != "divider")
          .toList());
    } catch (e, stack) {
      logger.e('Failed to prime messages from cache', error: e, stackTrace: stack);
    }
  }

  String? getStoredConversationId(String receiverId) {
    return ChatLocalStore.instance.getStoredConversationId(receiverId);
  }

  Future<void> storeConversationId(
      String receiverId, String conversationId) async {
    await ChatLocalStore.instance.storeConversationId(
        receiverId, conversationId);
  }

  /// Ensures [ChatRealtimeCoordinator] is subscribed to this conversation's
  /// channel (idempotent — a no-op if the conversations-list load already
  /// covered it) and registers this cubit as the one to forward live
  /// updates into while [ChatScreen] has it open. Call whenever
  /// [currentConversation] becomes known/changes.
  void _registerRealtime() {
    final conversationId = currentConversation?.id.toString();
    if (conversationId == null) return;
    ChatRealtimeCoordinator.instance
      ..subscribeToAll([conversationId])
      ..setActiveCubit(conversationId, this);
  }

  /// Called by [ChatRealtimeCoordinator] when a message from the other
  /// party arrives for the conversation this cubit currently has open.
  void applyIncomingMessage(AppMessageModel newMessage) {
    if (isClosed) return;
    messages = sortAndInsertDividers(messages
      ..add(newMessage)
      ..removeWhere((element) => element.messageType == "divider"));
    _safeEmit(MessagingState.messageUpdated(newMessage));
  }

  /// Called by [ChatRealtimeCoordinator] for a `message-delivered`/
  /// `message-read` event on the conversation this cubit currently has
  /// open.
  void applyDeliveryStatus(String messageId, {required bool delivered}) {
    if (isClosed) return;
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;

    final updated = delivered
        ? messages[index].copyWith(deliveredAt: DateTime.now())
        : messages[index].copyWith(read: true, readAt: DateTime.now());
    messages[index] = updated;

    ChatLocalStore.instance
        .upsertMessage(updated.conversationId, updated.toJson());
    _safeEmit(MessagingState.messageUpdated(updated));
  }

  /// Called by [ChatRealtimeCoordinator] for a (guessed name/shape,
  /// unverified) `message-edited` event.
  void applyEdited(String messageId, String newContent, DateTime? editedAt) {
    if (isClosed) return;
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final updated = messages[index]
        .copyWith(content: newContent, editedAt: editedAt ?? DateTime.now());
    messages[index] = updated;
    ChatLocalStore.instance
        .upsertMessage(updated.conversationId, updated.toJson());
    _safeEmit(MessagingState.messageUpdated(updated));
  }

  /// Called by [ChatRealtimeCoordinator] for a (guessed, unverified)
  /// `message-deleted` event.
  void applyDeleted(String messageId) {
    if (isClosed) return;
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final updated = messages[index].copyWith(isDeleted: true);
    messages[index] = updated;
    ChatLocalStore.instance
        .upsertMessage(updated.conversationId, updated.toJson());
    _safeEmit(MessagingState.messageUpdated(updated));
  }

  /// Called by [ChatRealtimeCoordinator] for (guessed, unverified)
  /// `message-pinned`/`message-unpinned` events.
  void applyPinned(String messageId, bool pinned) {
    if (isClosed) return;
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final updated = messages[index].copyWith(isPinned: pinned);
    messages[index] = updated;
    ChatLocalStore.instance
        .upsertMessage(updated.conversationId, updated.toJson());
    _safeEmit(MessagingState.messageUpdated(updated));
  }

  /// Called by [ChatRealtimeCoordinator] for (guessed, unverified)
  /// `message-reaction-added`/`message-reaction-removed` events —
  /// `reaction` is null for a removal.
  void applyReaction(String messageId, int userId, String? reaction) {
    if (isClosed) return;
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final remaining =
        messages[index].reactions.where((r) => r.userId != userId).toList();
    final updated = messages[index].copyWith(reactions: [
      ...remaining,
      if (reaction != null) MessageReaction(userId: userId, reaction: reaction),
    ]);
    messages[index] = updated;
    ChatLocalStore.instance
        .upsertMessage(updated.conversationId, updated.toJson());
    _safeEmit(MessagingState.messageUpdated(updated));
  }

  // --- Typing indicator ---
  //
  // Receiving: `UserTyping` broadcasts on the same `conversation.{id}`
  // channel [ChatRealtimeCoordinator] already owns, wired there (guessed
  // event name `'typing'`) — [applyTyping] below is what it calls. Still
  // unconfirmed, but harmless if wrong (never matches, just never lights
  // up) — left in place.
  //
  // Sending: DISABLED. Confirmed wrong (2026-09-29) —
  // `POST /messaging/conversations/typing` 405s; the server says that
  // route only accepts GET/HEAD, meaning it's for *reading* typing status,
  // not signaling it. Typing indicators are commonly sent as a Pusher
  // *client event* (triggered directly on the socket, no REST call at
  // all) rather than through a REST endpoint — that's the more likely
  // mechanism here, but needs confirming with the backend team before
  // implementing; guessing a client-event name blind isn't worth the risk
  // of it silently doing nothing. [notifyTyping] is a no-op until then, so
  // it doesn't spam a REST endpoint that's confirmed not to work.
  Future<void> notifyTyping() async {}

  /// Called by [ChatRealtimeCoordinator] for a `typing` event on the
  /// conversation this cubit currently has open. Auto-clears after 5s in
  /// case the other side's "stopped typing" signal (shape unknown) never
  /// arrives or isn't recognized.
  void applyTyping(bool typing) {
    if (isClosed) return;
    isOtherUserTypingNotifier.value = typing;
    _typingClearTimer?.cancel();
    if (typing) {
      _typingClearTimer = Timer(const Duration(seconds: 5), () {
        if (!isClosed) isOtherUserTypingNotifier.value = false;
      });
    }
  }

  // --- Presence indicator ---
  //
  // `UserPresenceChanged` broadcasts on `presence-user.{userId}` — a
  // channel this cubit subscribes to itself (unlike conversation-message
  // channels, presence is only relevant while this specific chat is open,
  // so there's no reason to route it through the always-on
  // [ChatRealtimeCoordinator]). Event name/payload shape are guessed —
  // unconfirmed.

  Future<void> _subscribeToPresence(String otherUserId) async {
    try {
      final pusherService = await PusherChannelService.getInstance;
      final pusher = await pusherService.getClient;
      if (pusher == null) return;

      pusher.onAuthorizer = PusherChannelService.authorize;
      final channelName = 'presence-user.$otherUserId';
      _presenceChannelName = channelName;

      if (!pusher.channels.containsKey(channelName)) {
        await pusher.subscribe(
          channelName: channelName,
          onEvent: (event) => _onPresenceEvent(event),
        );
      } else {
        pusher.getChannel(channelName)?.onEvent =
            (event) => _onPresenceEvent(event);
      }
      await pusher.connect();
    } catch (e, stack) {
      logger.e('Failed to subscribe to presence channel for $otherUserId',
          error: e, stackTrace: stack);
    }
  }

  void _onPresenceEvent(dynamic event) {
    if (isClosed) return;
    try {
      final receivedEvent = event as PusherEvent;
      logger.i(
          'PRESENCE EVENT (unconfirmed) -> eventName=${receivedEvent.eventName}, data=${receivedEvent.data}');
      final data = Map<String, dynamic>.from(jsonDecode(receivedEvent.data));
      final status = data['status']?.toString();
      isOtherUserOnlineNotifier.value = status == 'online';
    } catch (e) {
      logger.e('Failed to parse presence event: $e');
    }
  }
}
