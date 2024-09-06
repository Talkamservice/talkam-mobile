// To parse this JSON data, do
//
//     final getConversationsResponse = getConversationsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/core/services/data/session_manager.dart';

GetConversationsResponse getConversationsResponseFromJson(String str) =>
    GetConversationsResponse.fromJson(json.decode(str));

String getConversationsResponseToJson(GetConversationsResponse data) =>
    json.encode(data.toJson());

class GetConversationsResponse {
  String message;
  List<TalkamConversation> data;
  bool success;
  int code;

  GetConversationsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetConversationsResponse copyWith({
    String? message,
    List<TalkamConversation>? data,
    bool? success,
    int? code,
  }) =>
      GetConversationsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetConversationsResponse.fromJson(Map<String, dynamic> json) =>
      GetConversationsResponse(
        message: json["message"],
        data: List<TalkamConversation>.from(
            json["data"].map((x) => TalkamConversation.fromJson(x))),
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "code": code,
      };
}

class TalkamConversation {
  int id;
  List<ConversationUser> members;
  LastMessage? lastMessage;
  int numberOfUnread;
  bool notificationStatus;
  bool isAnonymous;
  ConversationUser requestedBy;
  bool userBlocked;
  String status;

  TalkamConversation({
    required this.id,
    required this.members,
    required this.lastMessage,
    required this.numberOfUnread,
    required this.notificationStatus,
    required this.isAnonymous,
    required this.requestedBy,
    required this.userBlocked,
    required this.status,
  });

  TalkamConversation copyWith({
    int? id,
    List<ConversationUser>? members,
    LastMessage? lastMessage,
    int? numberOfUnread,
    bool? notificationStatus,
    bool? isAnonymous,
    ConversationUser? requestedBy,
    bool? userBlocked,
    String? status,
  }) =>
      TalkamConversation(
        id: id ?? this.id,
        members: members ?? this.members,
        lastMessage: lastMessage ?? this.lastMessage,
        numberOfUnread: numberOfUnread ?? this.numberOfUnread,
        notificationStatus: notificationStatus ?? this.notificationStatus,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        requestedBy: requestedBy ?? this.requestedBy,
        userBlocked: userBlocked ?? this.userBlocked,
        status: status ?? this.status,
      );

  factory TalkamConversation.fromJson(Map<String, dynamic> json) =>
      TalkamConversation(
        id: json["id"],
        members: List<ConversationUser>.from(
            json["members"].map((x) => ConversationUser.fromJson(x))),
        lastMessage: json["last_message"] == null
            ? null
            : LastMessage.fromJson(json["last_message"]),
        numberOfUnread: json["number_of_unread"],
        notificationStatus: json["notification_status"],
        isAnonymous: json["is_anonymous"],

        requestedBy: ConversationUser.fromJson(json["requested_by"]),
        userBlocked: json["user_blocked"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "last_message": lastMessage?.toJson(),
        "number_of_unread": numberOfUnread,
        "notification_status": notificationStatus,
        "is_anonymous": isAnonymous,
        "requested_by": requestedBy.toJson(),
        "user_blocked": userBlocked,
        "status": status,
      };

  ConversationUser get otherUser =>
      SessionManager().isMe(members.first.id.toString())
          ? members.last
          : members.first;
}

class LastMessage {
  int id;
  int senderId;
  int receiverId;
  int conversationId;
  String message;
  String messageType;
  String assetUrl;
  bool read;
  DateTime createdAt;
  DateTime updatedAt;

  LastMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.message,
    required this.messageType,
    required this.assetUrl,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
  });

  LastMessage copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    int? conversationId,
    String? message,
    String? messageType,
    String? assetUrl,
    bool? read,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      LastMessage(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        conversationId: conversationId ?? this.conversationId,
        message: message ?? this.message,
        messageType: messageType ?? this.messageType,
        assetUrl: assetUrl ?? this.assetUrl,
        read: read ?? this.read,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        conversationId: json["conversation_id"],
        message: json["message"]??"",
        messageType: json["message_type"],
        assetUrl: json["asset_url"]??"",
        read: json["read"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "conversation_id": conversationId,
        "message": message,
        "message_type": messageType,
        "asset_url": assetUrl,
        "read": read,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ConversationUser {
  int id;
  String name;
  String username;
  String email;
  String? avatar;
  String? status;

  ConversationUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.avatar,
    this.status,
  });

  ConversationUser copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? avatar,
    String? status,
  }) =>
      ConversationUser(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        status: status ?? this.status,
      );

  factory ConversationUser.fromJson(Map<String, dynamic> json) =>
      ConversationUser(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        avatar: json["avatar"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "avatar": avatar,
        "status": status,
      };
}
