import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';

enum SendingState { loading, failed, success }

class AppMessageModel {
  final String id;
  final String receiverId;
  final String messageType;
  final String conversationId;
  final String? content;
  final bool iAmSender;
  final bool isTyping;
  SendingState? sendingState;
  DateTime? time;
  String? assetUrl;

  /// Read/delivered status — only meaningful for messages this user sent
  /// (`iAmSender == true`); see CHAT_AND_SESSION_API_REFERENCE.md.
  bool read;
  DateTime? readAt;
  DateTime? deliveredAt;

  bool isPinned;
  DateTime? editedAt;
  bool isDeleted;
  List<MessageReaction> reactions;

  AppMessageModel({
    this.id = '0',
    this.content,
    this.isTyping = false,
    required this.iAmSender,
    this.sendingState,
    this.assetUrl,
    this.time,
    this.read = false,
    this.readAt,
    this.deliveredAt,
    this.isPinned = false,
    this.editedAt,
    this.isDeleted = false,
    this.reactions = const [],
    required this.receiverId,
    required this.messageType,
    required this.conversationId,
  });

  bool get isEdited => editedAt != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppMessageModel &&
        other.content == content &&
        other.iAmSender == iAmSender &&
        other.sendingState == sendingState &&
        other.time == time;
  }

  @override
  int get hashCode => [content, iAmSender, sendingState, time, id].hashCode;

  factory AppMessageModel.fromResponse(TalkamMessage message) =>
      AppMessageModel(
          id: message.id.toString(),
          content: message.message,
          iAmSender: SessionManager().isMe(message.senderId.toString()),
          sendingState: SendingState.success,
          // `/messages/list` returns a resolved `file_url`; the
          // create-conversation endpoint's `last_message` only has
          // `asset_url` — prefer the resolved one where present.
          assetUrl: message.fileUrl ?? message.assetUrl,
          time: message.createdAt.toLocal(),
          read: message.read,
          readAt: message.readAt?.toLocal(),
          deliveredAt: message.deliveredAt?.toLocal(),
          isPinned: message.isPinned,
          editedAt: message.editedAt?.toLocal(),
          isDeleted: message.isDeleted,
          reactions: message.reactions,
          receiverId: message.receiverId.toString(),
          messageType: message.messageType,
          conversationId: message.conversationId.toString());

  factory AppMessageModel.typing() => AppMessageModel(
      content: '',
      iAmSender: true,
      isTyping: true,
      sendingState: SendingState.success,
      time: DateTime.now(),
      receiverId: '',
      messageType: '',
      conversationId: '');

  factory AppMessageModel.failed() => AppMessageModel(
      content: 'Failed message test',
      iAmSender: false,
      isTyping: false,
      sendingState: SendingState.failed,
      time: DateTime.now(),
      receiverId: '',
      messageType: '',
      conversationId: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'receiver_id': receiverId,
      'message_type': messageType,
      'message': content,
      'isMentraMessage': iAmSender,
      'isTyping': isTyping,
      'sendingState': sendingState?.toString(),
      // Convert SendingState to string
      'time': time?.toIso8601String(),
      // Convert DateTime to ISO 8601 string
      'asset_url': assetUrl,
      'read': read,
      'read_at': readAt?.toIso8601String(),
      'delivered_at': deliveredAt?.toIso8601String(),
      'is_pinned': isPinned,
      'edited_at': editedAt?.toIso8601String(),
      'is_deleted': isDeleted,
      'reactions': reactions.map((r) => r.toJson()).toList(),
    };
  }

  factory AppMessageModel.fromJson(Map<String, dynamic> json) {
    return AppMessageModel(
      id: json['id']?.toString() ?? '0',
      content: json['message'],
      iAmSender: json['isMentraMessage'],
      isTyping: json['isTyping'] ?? false,
      sendingState: _parseSendingState(json['sendingState']),
      time: json['time'] != null ? DateTime.tryParse(json['time']) : null,
      assetUrl: json['asset_url'],
      read: json['read'] ?? false,
      readAt: json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
      deliveredAt: json['delivered_at'] != null
          ? DateTime.tryParse(json['delivered_at'])
          : null,
      isPinned: json['is_pinned'] ?? false,
      editedAt:
          json['edited_at'] != null ? DateTime.tryParse(json['edited_at']) : null,
      isDeleted: json['is_deleted'] ?? false,
      reactions: (json['reactions'] as List<dynamic>?)
              ?.map((e) => MessageReaction.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          const [],
      receiverId: json['receiver_id']?.toString() ?? '',
      messageType: json['message_type']?.toString() ?? '',
      conversationId: json['conversation_id']?.toString() ?? '',
    );
  }

  AppMessageModel copyWith({
    String? id,
    String? content,
    String? messageType,
    String? receiverId,
    String? conversationId,
    bool? isTyping,
    bool? iAmSender,
    SendingState? sendingState,
    DateTime? time,
    String? assetUrl,
    bool? read,
    DateTime? readAt,
    DateTime? deliveredAt,
    bool? isPinned,
    DateTime? editedAt,
    bool? isDeleted,
    List<MessageReaction>? reactions,
  }) {
    return AppMessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isTyping: isTyping ?? this.isTyping,
      iAmSender: iAmSender ?? this.iAmSender,
      sendingState: sendingState ?? this.sendingState,
      time: time ?? this.time,
      assetUrl: assetUrl ?? this.assetUrl,
      read: read ?? this.read,
      readAt: readAt ?? this.readAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      isPinned: isPinned ?? this.isPinned,
      editedAt: editedAt ?? this.editedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      reactions: reactions ?? this.reactions,
      receiverId: receiverId ?? this.receiverId,
      messageType: messageType ?? this.messageType,
      conversationId: conversationId ?? this.conversationId,
    );
  }

  static SendingState? _parseSendingState(String? value) {
    switch (value) {
      case 'SendingState.loading':
        return SendingState.loading;
      case 'SendingState.failed':
        return SendingState.failed;
      case 'SendingState.success':
        return SendingState.success;
      default:
        return null;
    }
  }
}
