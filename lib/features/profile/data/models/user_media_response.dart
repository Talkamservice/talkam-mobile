// To parse this JSON data, do
//
//     final userMediaResponse = userMediaResponseFromJson(jsonString);

import 'dart:convert';

UserMediaResponse userMediaResponseFromJson(String str) => UserMediaResponse.fromJson(json.decode(str));

String userMediaResponseToJson(UserMediaResponse data) => json.encode(data.toJson());

class UserMediaResponse {
  String message;
  Data data;
  bool success;
  int code;

  UserMediaResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  UserMediaResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      UserMediaResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory UserMediaResponse.fromJson(Map<String, dynamic> json) => UserMediaResponse(
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
  List<UserMedia> data;

  Data({
    required this.paginationMeta,
    required this.data,
  });

  Data copyWith({
    PaginationMeta? paginationMeta,
    List<UserMedia>? data,
  }) =>
      Data(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paginationMeta: PaginationMeta.fromJson(json["pagination_meta"]),
        data: List<UserMedia>.from(json["data"].map((x) => UserMedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination_meta": paginationMeta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserMedia {
  int id;
  String url;
  String type;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  UserMedia({
    required this.id,
    required this.url,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  UserMedia copyWith({
    int? id,
    String? url,
    String? type,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserMedia(
        id: id ?? this.id,
        url: url ?? this.url,
        type: type ?? this.type,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserMedia.fromJson(Map<String, dynamic> json) => UserMedia(
        id: json["id"],
        url: json["url"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
        "status": status,
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
