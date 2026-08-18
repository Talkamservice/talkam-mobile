// To parse this JSON data, do
//
//     final getConversationsResponse = getConversationsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart'
    show PaginationMeta;

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

/// Response for `GET /user/messaging/conversations?archived=&starred=` (v2) —
/// paginated, distinct from [GetConversationsResponse]'s flat `data` list
/// (still used by the v1 pending-requests path, which this endpoint doesn't
/// cover).
class GetConversationsListResponse {
  String message;
  ConversationsListData data;
  bool success;
  int code;

  GetConversationsListResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetConversationsListResponse.fromJson(Map<String, dynamic> json) =>
      GetConversationsListResponse(
        message: json["message"],
        data: ConversationsListData.fromJson(json["data"]),
        success: json["success"],
        code: json["code"],
      );
}

class ConversationsListData {
  PaginationMeta paginationMeta;
  List<TalkamConversation> data;

  ConversationsListData({
    required this.paginationMeta,
    required this.data,
  });

  factory ConversationsListData.fromJson(Map<String, dynamic> json) =>
      ConversationsListData(
        paginationMeta: PaginationMeta.fromJson(json["pagination_meta"]),
        data: List<TalkamConversation>.from(
            json["data"].map((x) => TalkamConversation.fromJson(x))),
      );
}

class TalkamConversation {
  int id;
  // v1-only ("members" list + derived request/block bookkeeping) — the v2
  // conversations-list endpoint doesn't return any of these, so they're
  // nullable/defaulted rather than required.
  List<ConversationUser>? members;
  LastMessage? lastMessage;
  int numberOfUnread;
  bool notificationStatus;
  bool isAnonymous;
  ConversationUser? requestedBy;
  bool userBlocked;
  bool userBanned;
  String status;

  // v2-only fields.
  final ConversationUser? otherMember;
  final bool isMuted;
  final String? mutedUntil;
  final String? archivedAt;
  final String? starredAt;

  TalkamConversation({
    required this.id,
    this.members,
    required this.lastMessage,
    required this.numberOfUnread,
    this.notificationStatus = false,
    required this.isAnonymous,
    this.requestedBy,
    this.userBlocked = false,
    this.userBanned = false,
    required this.status,
    this.otherMember,
    this.isMuted = false,
    this.mutedUntil,
    this.archivedAt,
    this.starredAt,
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
    bool? userBanned,
    String? status,
    ConversationUser? otherMember,
    bool? isMuted,
    String? mutedUntil,
    String? archivedAt,
    bool clearArchivedAt = false,
    String? starredAt,
    bool clearStarredAt = false,
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
        userBanned: userBanned ?? this.userBanned,
        status: status ?? this.status,
        otherMember: otherMember ?? this.otherMember,
        isMuted: isMuted ?? this.isMuted,
        mutedUntil: mutedUntil ?? this.mutedUntil,
        archivedAt: clearArchivedAt ? null : (archivedAt ?? this.archivedAt),
        starredAt: clearStarredAt ? null : (starredAt ?? this.starredAt),
      );

  factory TalkamConversation.fromJson(Map<String, dynamic> json) =>
      TalkamConversation(
        id: json["id"],
        members: json["members"] == null
            ? null
            : List<ConversationUser>.from(
                json["members"].map((x) => ConversationUser.fromJson(x))),
        lastMessage: json["last_message"] == null
            ? null
            : LastMessage.fromJson(json["last_message"]),
        numberOfUnread: json["unread_count"] ?? json["number_of_unread"] ?? 0,
        notificationStatus: json["notification_status"] ?? false,
        isAnonymous: json["is_anonymous"] ?? false,
        requestedBy: json["requested_by"] == null
            ? null
            : ConversationUser.fromJson(json["requested_by"]),
        userBlocked: json["user_blocked"] ?? false,
        userBanned: json["user_is_banned"] ?? false,
        status: json["status"],
        otherMember: json["other_member"] == null
            ? null
            : ConversationUser.fromJson(json["other_member"]),
        isMuted: json["is_muted"] ?? false,
        mutedUntil: json["muted_until"],
        archivedAt: json["archived_at"],
        starredAt: json["starred_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "members": members == null
            ? null
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        "last_message": lastMessage?.toJson(),
        "number_of_unread": numberOfUnread,
        "notification_status": notificationStatus,
        "is_anonymous": isAnonymous,
        "requested_by": requestedBy?.toJson(),
        "user_blocked": userBlocked,
        "user_is_banned": userBanned,
        "status": status,
        "other_member": otherMember?.toJson(),
        "is_muted": isMuted,
        "muted_until": mutedUntil,
        "archived_at": archivedAt,
        "starred_at": starredAt,
      };

  /// The v2 conversations-list endpoint returns [otherMember] directly; the
  /// v1 shape (pending-requests only, see [MessagingRepository]) instead
  /// carries a `members` list this falls back to deriving it from.
  ConversationUser get otherUser =>
      otherMember ??
      (SessionManager().isMe(members?.firstOrNull?.id.toString() ?? '0')
          ? members!.last
          : members!.first);
}

class LastMessage {
  int id;
  int senderId;
  // v1-only — the v2 conversations-list endpoint's `last_message` is a lean
  // {id, message, sender_id, created_at} object, so everything below is
  // nullable/defaulted rather than required.
  int? receiverId;
  int? conversationId;
  String message;
  String? messageType;
  String assetUrl;
  bool read;
  DateTime createdAt;
  DateTime? updatedAt;

  LastMessage({
    required this.id,
    required this.senderId,
    this.receiverId,
    this.conversationId,
    required this.message,
    this.messageType,
    required this.assetUrl,
    this.read = false,
    required this.createdAt,
    this.updatedAt,
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
        message: json["message"] ?? "",
        messageType: json["message_type"],
        assetUrl: json["asset_url"] ?? "",
        read: json["read"] ?? false,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "updated_at": updatedAt?.toIso8601String(),
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
        // v2's `other_member` doesn't carry an email.
        email: json["email"] ?? "",
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
