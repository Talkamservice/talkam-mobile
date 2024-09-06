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
  dynamic assetUrl;
  bool read;
  DateTime createdAt;
  DateTime updatedAt;

  TalkamMessage({
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

  TalkamMessage copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    int? conversationId,
    String? message,
    String? messageType,
    dynamic assetUrl,
    bool? read,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TalkamMessage(
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

  factory TalkamMessage.fromJson(Map<String, dynamic> json) => TalkamMessage(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        conversationId: json["conversation_id"],
        message: json["message"],
        messageType: json["message_type"],
        assetUrl: json["asset_url"],
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
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
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
