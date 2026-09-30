// To parse this JSON data, do
//
//     final getMessagesResponse = getMessagesResponseFromJson(jsonString);

import 'dart:convert';

GetMessagesResponse getMessagesResponseFromJson(String str) =>
    GetMessagesResponse.fromJson(json.decode(str));

String getMessagesResponseToJson(GetMessagesResponse data) =>
    json.encode(data.toJson());

class GetMessagesResponse {
  String message;
  Data data;
  bool success;
  int code;

  GetMessagesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetMessagesResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      GetMessagesResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetMessagesResponse.fromJson(Map<String, dynamic> json) =>
      GetMessagesResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "success": success,
        "code": code,
      };
}

class Data {
  PaginationMeta paginationMeta;
  List<TalkamMessage> data;

  Data({
    required this.paginationMeta,
    required this.data,
  });

  Data copyWith({
    PaginationMeta? paginationMeta,
    List<TalkamMessage>? data,
  }) =>
      Data(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paginationMeta: PaginationMeta.fromJson(json["pagination_meta"]),
        data: List<TalkamMessage>.from(
            json["data"].map((x) => TalkamMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination_meta": paginationMeta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TalkamMessage {
  int id;
  int senderId;
  int receiverId;
  int conversationId;
  String? message;
  String messageType;

  /// Only populated when this model backs a `last_message` from
  /// `/messaging/conversations` (create/start conversation) — that response
  /// resolves the attachment to a downloadable URL. `/messaging/messages/list`
  /// doesn't return `asset_url`; it returns [fileId] instead.
  dynamic assetUrl;

  /// Populated by `/messaging/messages/list` for messages with an attached
  /// file — a raw file reference, superseded by [fileUrl]/[fileName] below.
  int? fileId;

  /// The resolved, downloadable URL for [fileId] — `/messaging/messages/list`
  /// returns this already resolved, no second call needed.
  String? fileUrl;

  String? fileName;

  bool read;

  /// Timestamp the recipient marked this message read — populated by
  /// `/messaging/messages/list` per CHAT_AND_SESSION_API_REFERENCE.md.
  DateTime? readAt;

  /// Timestamp the message was delivered to the recipient's device —
  /// same source as [readAt].
  DateTime? deliveredAt;

  DateTime createdAt;

  /// Not present on messages returned by `/messaging/messages/list` (only
  /// `created_at` is) — only populated when this model backs a
  /// `last_message` from `/messaging/conversations`.
  DateTime? updatedAt;

  bool isPinned;
  DateTime? editedAt;
  bool isDeleted;
  List<MessageReaction> reactions;

  TalkamMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.message,
    required this.messageType,
    required this.assetUrl,
    this.fileId,
    this.fileUrl,
    this.fileName,
    required this.read,
    this.readAt,
    this.deliveredAt,
    required this.createdAt,
    this.updatedAt,
    this.isPinned = false,
    this.editedAt,
    this.isDeleted = false,
    this.reactions = const [],
  });

  TalkamMessage copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    int? conversationId,
    String? message,
    String? messageType,
    dynamic assetUrl,
    int? fileId,
    String? fileUrl,
    String? fileName,
    bool? read,
    DateTime? readAt,
    DateTime? deliveredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    DateTime? editedAt,
    bool? isDeleted,
    List<MessageReaction>? reactions,
  }) =>
      TalkamMessage(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        conversationId: conversationId ?? this.conversationId,
        message: message ?? this.message,
        messageType: messageType ?? this.messageType,
        assetUrl: assetUrl ?? this.assetUrl,
        fileId: fileId ?? this.fileId,
        fileUrl: fileUrl ?? this.fileUrl,
        fileName: fileName ?? this.fileName,
        read: read ?? this.read,
        readAt: readAt ?? this.readAt,
        deliveredAt: deliveredAt ?? this.deliveredAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isPinned: isPinned ?? this.isPinned,
        editedAt: editedAt ?? this.editedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        reactions: reactions ?? this.reactions,
      );

  factory TalkamMessage.fromJson(Map<String, dynamic> json) => TalkamMessage(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        conversationId: json["conversation_id"],
        message: json["message"],
        messageType: json["message_type"],
        assetUrl: json["asset_url"],
        fileId: json["file_id"],
        fileUrl: json["file_url"],
        fileName: json["file_name"],
        read: json["read"] ?? false,
        readAt:
            json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
        deliveredAt: json["delivered_at"] == null
            ? null
            : DateTime.parse(json["delivered_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isPinned: json["is_pinned"] ?? false,
        editedAt:
            json["edited_at"] == null ? null : DateTime.parse(json["edited_at"]),
        isDeleted: json["is_deleted"] ?? false,
        reactions: (json["reactions"] as List<dynamic>?)
                ?.map((e) => MessageReaction.fromJson(Map<String, dynamic>.from(e)))
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "conversation_id": conversationId,
        "message": message,
        "message_type": messageType,
        "asset_url": assetUrl,
        "file_id": fileId,
        "file_url": fileUrl,
        "file_name": fileName,
        "read": read,
        "read_at": readAt?.toIso8601String(),
        "delivered_at": deliveredAt?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_pinned": isPinned,
        "edited_at": editedAt?.toIso8601String(),
        "is_deleted": isDeleted,
        "reactions": reactions.map((r) => r.toJson()).toList(),
      };
}

/// One reaction on a message — `{"user_id": 45, "reaction": "👍"}` per
/// CHAT_AND_SESSION_API_REFERENCE.md's `/messaging/messages/list` sample.
class MessageReaction {
  final int userId;
  final String reaction;

  MessageReaction({required this.userId, required this.reaction});

  factory MessageReaction.fromJson(Map<String, dynamic> json) =>
      MessageReaction(
        userId: json["user_id"],
        reaction: json["reaction"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "reaction": reaction,
      };
}

class PaginationMeta {
  int currentPage;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;
  bool canLoadMore;

  PaginationMeta({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.canLoadMore,
  });

  PaginationMeta copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
    bool? canLoadMore,
  }) =>
      PaginationMeta(
        currentPage: currentPage ?? this.currentPage,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
        currentPage: json["current_page"],
        firstPageUrl: json["first_page_url"],
        // Laravel-style pagination returns "from"/"to" as null when the
        // page has zero results (e.g. an empty conversations/messages list).
        from: json["from"] ?? 0,
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] ?? 0,
        total: json["total"],
        canLoadMore: json["can_load_more"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
        "can_load_more": canLoadMore,
      };
}
