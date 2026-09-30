import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce/hive.dart';

/// Encrypted, on-device store for messaging data — the local source of
/// truth both [MessagesScreen]'s conversations list and [ChatScreen] read
/// from first, before hitting the network. Replaces the old plaintext
/// `chatCache`/`conversationCache` Hive boxes.
///
/// A thin KV wrapper only — parsing raw JSON into models stays with the
/// cubits, exactly as it did when they opened these boxes directly.
///
/// Deliberately uses no Hive codegen (`@HiveType`/`@HiveField`): everything
/// is raw `Map<String, dynamic>` JSON, same as the cache it replaces.
class ChatLocalStore {
  ChatLocalStore._();

  static final ChatLocalStore instance = ChatLocalStore._();

  static const _keyStorageKey = 'chat_store_encryption_key';
  static const _messagesBoxName = 'encrypted_chat_messages';
  static const _conversationLookupBoxName = 'encrypted_conversation_lookup';
  static const _conversationsListBoxName = 'encrypted_conversations_list';
  static const _conversationsListKey = 'all';

  final _secureStorage = const FlutterSecureStorage();

  Box? _messagesBox;
  Box? _conversationLookupBox;
  Box? _conversationsListBox;

  Future<void> init() async {
    final cipher = await _loadOrCreateCipher();
    _messagesBox =
        await Hive.openBox(_messagesBoxName, encryptionCipher: cipher);
    _conversationLookupBox = await Hive.openBox(_conversationLookupBoxName,
        encryptionCipher: cipher);
    _conversationsListBox = await Hive.openBox(_conversationsListBoxName,
        encryptionCipher: cipher);

    // One-time cleanup of the plaintext caches these boxes replace — this is
    // a disposable snapshot cache, not durable data, so no migration is
    // attempted; the app just repopulates from the network as it would on a
    // fresh install.
    for (final legacyBoxName in ['chatCache', 'conversationCache']) {
      if (await Hive.boxExists(legacyBoxName)) {
        await Hive.deleteBoxFromDisk(legacyBoxName);
      }
    }
  }

  Future<HiveAesCipher> _loadOrCreateCipher() async {
    final existing = await _secureStorage.read(key: _keyStorageKey);
    if (existing != null) {
      return HiveAesCipher(base64Decode(existing));
    }
    final key = Hive.generateSecureKey();
    await _secureStorage.write(key: _keyStorageKey, value: base64Encode(key));
    return HiveAesCipher(key);
  }

  // Messages, keyed by conversationId.

  List<Map<String, dynamic>>? getCachedMessages(String conversationId) {
    final raw = _messagesBox?.get(conversationId) as List<dynamic>?;
    if (raw == null) return null;
    return raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<void> saveMessages(
      String conversationId, List<Map<String, dynamic>> messages) async {
    await _messagesBox?.put(conversationId, messages);
  }

  /// Appends one live (Pusher-received) message, deduped by `id` — a no-op
  /// if that id is already cached. For updating an *existing* message's
  /// fields (e.g. delivery/read status), use [upsertMessage] instead.
  Future<void> appendMessage(
      String conversationId, Map<String, dynamic> message) async {
    final existing = getCachedMessages(conversationId) ?? [];
    if (existing.any((m) => m['id'] == message['id'])) return;
    await saveMessages(conversationId, [...existing, message]);
  }

  /// Replaces the cached message matching `message['id']` in place, or
  /// appends it if not already cached. Unlike [appendMessage], this is
  /// safe to call for a message id that already exists — used to patch an
  /// already-cached message's fields (delivery/read status) rather than
  /// silently dropping the update.
  Future<void> upsertMessage(
      String conversationId, Map<String, dynamic> message) async {
    final existing = getCachedMessages(conversationId) ?? [];
    final index = existing.indexWhere((m) => m['id'] == message['id']);
    if (index == -1) {
      await saveMessages(conversationId, [...existing, message]);
      return;
    }
    final updated = [...existing];
    updated[index] = message;
    await saveMessages(conversationId, updated);
  }

  // receiverId -> conversationId lookup.

  String? getStoredConversationId(String receiverId) =>
      _conversationLookupBox?.get(receiverId) as String?;

  Future<void> storeConversationId(
      String receiverId, String conversationId) async {
    await _conversationLookupBox?.put(receiverId, conversationId);
  }

  // Conversations list snapshot — default/"All" tab only.

  Map<String, dynamic>? getCachedConversationsList() {
    final raw = _conversationsListBox?.get(_conversationsListKey);
    if (raw == null) return null;
    return Map<String, dynamic>.from(raw as Map);
  }

  Future<void> saveConversationsList(List<Map<String, dynamic>> conversations,
      Map<String, dynamic> paginationMeta) async {
    await _conversationsListBox?.put(_conversationsListKey, {
      'conversations': conversations,
      'pagination_meta': paginationMeta,
    });
  }

  Future<void> clearAll() async {
    await _messagesBox?.clear();
    await _conversationLookupBox?.clear();
    await _conversationsListBox?.clear();
  }
}
