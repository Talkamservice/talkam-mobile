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

  AppMessageModel({
    this.id = '0',
    this.content,
    this.isTyping = false,
    required this.iAmSender,
    this.sendingState,
    this.assetUrl,
    this.time,
    required this.receiverId,
    required this.messageType,
    required this.conversationId,
  });

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
          content: message.message,
          iAmSender: SessionManager().isMe(message.senderId.toString()),
          sendingState: SendingState.success,
          assetUrl: message.assetUrl,
          time: message.createdAt.toLocal(),
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
      'id': content,
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
    };
  }

  Map<String, dynamic> toRequestJson() {
    return {"user": iAmSender ? "assistant" : "user", "prompt": content};
  }

  factory AppMessageModel.fromJson(Map<String, dynamic> json) {
    return AppMessageModel(
      content: json['message'],
      iAmSender: json['isMentraMessage'],
      isTyping: json['isTyping'] ?? false,
      sendingState: _parseSendingState(json['sendingState']),
      time: json['time'] != null ? DateTime.tryParse(json['time']) : null,
      assetUrl: json['asset_url'],
      receiverId: '',
      messageType: '',
      conversationId: '',
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
  }) {
    return AppMessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isTyping: isTyping ?? this.isTyping,
      iAmSender: iAmSender ?? this.iAmSender,
      sendingState: sendingState ?? this.sendingState,
      time: time ?? this.time,
      assetUrl: assetUrl ?? this.assetUrl,
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
