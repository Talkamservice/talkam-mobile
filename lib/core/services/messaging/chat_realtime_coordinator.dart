import 'dart:convert';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/chat_local_store.dart';
import 'package:talkam/core/services/pusher/pusher_channel_service.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/blocs/messaging/messaging_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

/// Owns real-time delivery for ALL of the user's conversations, not just
/// whichever one [ChatScreen] currently has open.
///
/// Per CHAT_AND_SESSION_API_REFERENCE.md, `conversation.{id}` already
/// carries full message content in real time (`ReceiveMessage`,
/// `MessageDelivered`, `MessageRead`) — there's just no single per-user
/// firehose channel, so getting this for every conversation means
/// subscribing to each one individually. Previously only [MessagingCubit]
/// did this, and only for the conversation open in [ChatScreen] at the
/// time — every other conversation relied on the app-wide
/// `refresh-notification.{userId}` channel, which carries no payload, so
/// catching up meant a REST refetch (either the whole conversations list,
/// or — briefly — a background per-conversation `getMessages()` poll this
/// replaces entirely).
///
/// A channel can only have one `onEvent` handler at a time (the Pusher
/// client keeps one callback per channel name, last write wins) — so this
/// is the *single* owner of every `private-conversation.{id}` subscription
/// app-wide. [MessagingCubit] no longer subscribes to Pusher itself; it
/// registers as the "active" cubit for whichever conversation [ChatScreen]
/// has open via [setActiveCubit], and this class forwards matching events
/// straight into its live `messages` list via [MessagingCubit.applyIncomingMessage]/
/// [MessagingCubit.applyDeliveryStatus] in addition to always writing
/// through to [ChatLocalStore] and patching [ConversationsCubit]'s preview.
class ChatRealtimeCoordinator {
  ChatRealtimeCoordinator._();

  static final ChatRealtimeCoordinator instance = ChatRealtimeCoordinator._();

  final Set<String> _subscribedConversationIds = {};

  String? _activeConversationId;
  MessagingCubit? _activeCubit;

  /// [ChatScreen] currently has [conversationId] open — matching events get
  /// forwarded directly into [cubit]'s live state, on top of the always-on
  /// cache/preview write-through below.
  void setActiveCubit(String conversationId, MessagingCubit cubit) {
    _activeConversationId = conversationId;
    _activeCubit = cubit;
  }

  /// Called from [MessagingCubit.close] — stops forwarding into a cubit
  /// that's about to be disposed. Does NOT unsubscribe the Pusher channel;
  /// that subscription is shared/global and stays alive so the
  /// conversation keeps receiving background updates after the screen
  /// closes.
  void clearActiveCubit(MessagingCubit cubit) {
    if (identical(_activeCubit, cubit)) {
      _activeCubit = null;
      _activeConversationId = null;
    }
  }

  /// Subscribes to `private-conversation.{id}` for every id given —
  /// idempotent per id. Call whenever a set of conversation ids becomes
  /// known: [ConversationsCubit] on every list load/page/refresh, and
  /// [MessagingCubit] for whichever single conversation [ChatScreen] has
  /// open (covering a brand-new conversation the list fetch hasn't caught
  /// up to yet).
  Future<void> subscribeToAll(Iterable<String> conversationIds) async {
    for (final id in conversationIds) {
      await _subscribe(id);
    }
  }

  Future<void> _subscribe(String conversationId) async {
    if (_subscribedConversationIds.contains(conversationId)) return;
    try {
      final pusherService = await PusherChannelService.getInstance;
      final pusher = await pusherService.getClient;
      if (pusher == null) return;

      pusher.onAuthorizer = PusherChannelService.authorize;
      final channelName = "private-conversation.$conversationId";

      if (!pusher.channels.containsKey(channelName)) {
        await pusher.subscribe(
          channelName: channelName,
          onEvent: (event) => _onEventReceived(conversationId, event),
        );
      } else {
        // Already subscribed (e.g. MessagingCubit's own now-removed
        // subscription path used to own this channel, or a duplicate call
        // raced this one) — just make sure this coordinator owns the
        // handler slot.
        pusher.getChannel(channelName)?.onEvent =
            (event) => _onEventReceived(conversationId, event);
      }
      await pusher.connect();
      _subscribedConversationIds.add(conversationId);
    } catch (e, stack) {
      logger.e('Failed to subscribe to conversation $conversationId',
          error: e, stackTrace: stack);
    }
  }

  void _onEventReceived(String conversationId, dynamic event) {
    try {
      final receivedEvent = event as PusherEvent;
      logger.i(
          'REALTIME EVENT -> conversation=$conversationId, eventName=${receivedEvent.eventName}, data=${receivedEvent.data}');

      if (receivedEvent.eventName == 'message-delivered') {
        _handleDeliveryOrRead(conversationId, receivedEvent.data,
            delivered: true);
        return;
      }

      if (receivedEvent.eventName == 'message-read') {
        _handleDeliveryOrRead(conversationId, receivedEvent.data,
            delivered: false);
        return;
      }

      // Event names/payload shapes below are UNCONFIRMED guesses (see
      // MessagingRepository.updateMessageState's doc comment) — harmless
      // no-ops if wrong (they just never match), kept consistent with the
      // established `message-delivered`/`message-read` naming style.
      if (receivedEvent.eventName == 'message-edited') {
        _handleEdited(conversationId, receivedEvent.data);
        return;
      }
      if (receivedEvent.eventName == 'message-deleted') {
        _handleDeleted(conversationId, receivedEvent.data);
        return;
      }
      if (receivedEvent.eventName == 'message-pinned') {
        _handlePinned(conversationId, receivedEvent.data, pinned: true);
        return;
      }
      if (receivedEvent.eventName == 'message-unpinned') {
        _handlePinned(conversationId, receivedEvent.data, pinned: false);
        return;
      }
      if (receivedEvent.eventName == 'message-reaction-added') {
        _handleReaction(conversationId, receivedEvent.data, added: true);
        return;
      }
      if (receivedEvent.eventName == 'message-reaction-removed') {
        _handleReaction(conversationId, receivedEvent.data, added: false);
        return;
      }

      // Ephemeral — only matters while the conversation is actually open,
      // so no cache write-through branch like the others above.
      if (receivedEvent.eventName == 'typing') {
        if (_activeConversationId != conversationId) return;
        final data = Map<String, dynamic>.from(receivedEvent.data is String
            ? jsonDecode(receivedEvent.data)
            : receivedEvent.data);
        final eventUserId = data['user_id']?.toString();
        final myUserId = injector.get<ProfileBloc>().appUser?.id.toString();
        if (eventUserId != null && eventUserId == myUserId) return;
        _activeCubit?.applyTyping(data['is_typing'] != false);
        return;
      }

      if (receivedEvent.eventName ==
          'receive-message.${injector.get<ProfileBloc>().appUser?.id}') {
        _handleIncomingMessage(conversationId, receivedEvent.data);
        return;
      }

      // Nothing above matched — either a genuinely new/unhandled event, or
      // one of the guessed names above is wrong. Distinct from the
      // unconditional log at the top so this is greppable on its own.
      logger.w(
          'REALTIME EVENT UNHANDLED -> eventName=${receivedEvent.eventName} didn\'t match any known handler');
    } catch (e, stack) {
      logger.e('Failed to handle realtime chat event',
          error: e, stackTrace: stack);
    }
  }

  void _handleIncomingMessage(String conversationId, dynamic rawData) {
    final talkamMessage =
        TalkamMessage.fromJson(jsonDecode(rawData)["data"]);
    final newMessage = AppMessageModel.fromResponse(talkamMessage);
    // Own outgoing messages are reconciled through sendMessage()'s own
    // response handling, not this incoming-message path.
    if (newMessage.iAmSender) return;

    // Always write through — this is the one place a background (chat not
    // open) conversation gets real content instead of just an opaque
    // "something changed" signal, closing the gap the old
    // refresh-notification-triggered refetch used to paper over.
    ChatLocalStore.instance
        .appendMessage(conversationId, newMessage.toJson());
    injector.get<ConversationsCubit>().patchConversationPreview(
          conversationId: conversationId,
          lastMessageId: talkamMessage.id,
          senderId: talkamMessage.senderId,
          message: talkamMessage.message ?? '',
          createdAt: talkamMessage.createdAt,
          assetUrl: talkamMessage.assetUrl?.toString() ?? '',
        );

    if (_activeConversationId == conversationId) {
      _activeCubit?.applyIncomingMessage(newMessage);
    }
  }

  void _handleDeliveryOrRead(String conversationId, dynamic rawData,
      {required bool delivered}) {
    final data = Map<String, dynamic>.from(
        rawData is String ? jsonDecode(rawData) : rawData);
    final messageId = data['message_id']?.toString();
    if (messageId == null) return;

    if (_activeConversationId == conversationId) {
      _activeCubit?.applyDeliveryStatus(messageId, delivered: delivered);
      return;
    }

    // Chat isn't open — patch the cached copy directly (no live cubit
    // `messages` list to update) so it's already correct whenever it is
    // opened next.
    final cached = ChatLocalStore.instance.getCachedMessages(conversationId);
    if (cached == null) return;
    final index = cached.indexWhere((m) => m['id']?.toString() == messageId);
    if (index == -1) return;

    final updated = Map<String, dynamic>.from(cached[index]);
    if (delivered) {
      updated['delivered_at'] = DateTime.now().toIso8601String();
    } else {
      updated['read'] = true;
      updated['read_at'] = DateTime.now().toIso8601String();
    }
    ChatLocalStore.instance.upsertMessage(conversationId, updated);
  }

  void _handleEdited(String conversationId, dynamic rawData) {
    final data = Map<String, dynamic>.from(
        rawData is String ? jsonDecode(rawData) : rawData);
    final messageId = (data['message_id'] ?? data['id'])?.toString();
    final newContent = data['message']?.toString();
    if (messageId == null || newContent == null) return;
    final editedAt =
        data['edited_at'] != null ? DateTime.tryParse(data['edited_at']) : null;

    if (_activeConversationId == conversationId) {
      _activeCubit?.applyEdited(messageId, newContent, editedAt);
      return;
    }
    _mutateCachedMessage(conversationId, messageId, (m) {
      m['message'] = newContent;
      m['edited_at'] = (editedAt ?? DateTime.now()).toIso8601String();
      return m;
    });
  }

  void _handleDeleted(String conversationId, dynamic rawData) {
    final data = Map<String, dynamic>.from(
        rawData is String ? jsonDecode(rawData) : rawData);
    final messageId = (data['message_id'] ?? data['id'])?.toString();
    if (messageId == null) return;

    if (_activeConversationId == conversationId) {
      _activeCubit?.applyDeleted(messageId);
      return;
    }
    _mutateCachedMessage(conversationId, messageId, (m) {
      m['is_deleted'] = true;
      return m;
    });
  }

  void _handlePinned(String conversationId, dynamic rawData,
      {required bool pinned}) {
    final data = Map<String, dynamic>.from(
        rawData is String ? jsonDecode(rawData) : rawData);
    final messageId = (data['message_id'] ?? data['id'])?.toString();
    if (messageId == null) return;

    if (_activeConversationId == conversationId) {
      _activeCubit?.applyPinned(messageId, pinned);
      return;
    }
    _mutateCachedMessage(conversationId, messageId, (m) {
      m['is_pinned'] = pinned;
      return m;
    });
  }

  void _handleReaction(String conversationId, dynamic rawData,
      {required bool added}) {
    final data = Map<String, dynamic>.from(
        rawData is String ? jsonDecode(rawData) : rawData);
    final messageId = data['message_id']?.toString();
    final userId = data['user_id'] is int
        ? data['user_id'] as int
        : int.tryParse(data['user_id']?.toString() ?? '');
    final reaction = added ? data['reaction']?.toString() : null;
    if (messageId == null || userId == null) return;

    if (_activeConversationId == conversationId) {
      _activeCubit?.applyReaction(messageId, userId, reaction);
      return;
    }
    _mutateCachedMessage(conversationId, messageId, (m) {
      final reactions = ((m['reactions'] as List<dynamic>?) ?? [])
          .map((e) => Map<String, dynamic>.from(e))
          .where((r) => r['user_id'] != userId)
          .toList();
      if (reaction != null) {
        reactions.add({'user_id': userId, 'reaction': reaction});
      }
      m['reactions'] = reactions;
      return m;
    });
  }

  /// Shared "find this message in the cache, mutate it, save it back" used
  /// by every realtime handler whose conversation isn't currently open (no
  /// live cubit `messages` list to update instead).
  void _mutateCachedMessage(String conversationId, String messageId,
      Map<String, dynamic> Function(Map<String, dynamic>) mutate) {
    final cached = ChatLocalStore.instance.getCachedMessages(conversationId);
    if (cached == null) return;
    final index = cached.indexWhere((m) => m['id']?.toString() == messageId);
    if (index == -1) return;
    ChatLocalStore.instance.upsertMessage(
        conversationId, mutate(Map<String, dynamic>.from(cached[index])));
  }

  /// The Pusher socket itself is already torn down centrally on logout
  /// (`SessionManager.logOut()` -> `PusherChannelService.disconnect()`),
  /// which drops every subscription — this just resets this class's own
  /// bookkeeping so the next login's first conversations-list load
  /// re-subscribes from scratch instead of assuming the old (now-dead)
  /// subscriptions are still live.
  void resetForLogout() {
    _subscribedConversationIds.clear();
    _activeCubit = null;
    _activeConversationId = null;
  }
}
