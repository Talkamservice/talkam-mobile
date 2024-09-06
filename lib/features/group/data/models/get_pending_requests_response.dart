// To parse this JSON data, do
//
//     final getPendingRequestsResponse = getPendingRequestsResponseFromJson(jsonString);

import 'dart:convert';

GetPendingRequestsResponse getPendingRequestsResponseFromJson(String str) => GetPendingRequestsResponse.fromJson(json.decode(str));

String getPendingRequestsResponseToJson(GetPendingRequestsResponse data) => json.encode(data.toJson());


class GetPendingRequestsResponse {
  String message;
  Data data;
  bool success;
  int code;

  GetPendingRequestsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetPendingRequestsResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      GetPendingRequestsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetPendingRequestsResponse.fromJson(Map<String, dynamic> json) => GetPendingRequestsResponse(
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
  PendingRequestPaginationMeta paginationMeta;
  List<PendingRequest> data;

  Data({
    required this.paginationMeta,
    required this.data,
  });

  Data copyWith({
    PendingRequestPaginationMeta? paginationMeta,
    List<PendingRequest>? data,
  }) =>
      Data(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paginationMeta: PendingRequestPaginationMeta.fromJson(json["pagination_meta"]),
    data: List<PendingRequest>.from(json["data"].map((x) => PendingRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination_meta": paginationMeta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PendingRequest {
  int id;
  String role;
  String status;
  dynamic suspensionEndsAt;
  RequestGroup group;
  RequestUser user;
  DateTime createdAt;
  DateTime updatedAt;

  PendingRequest({
    required this.id,
    required this.role,
    required this.status,
    required this.suspensionEndsAt,
    required this.group,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  PendingRequest copyWith({
    int? id,
    String? role,
    String? status,
    dynamic suspensionEndsAt,
    RequestGroup? group,
    RequestUser? user,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PendingRequest(
        id: id ?? this.id,
        role: role ?? this.role,
        status: status ?? this.status,
        suspensionEndsAt: suspensionEndsAt ?? this.suspensionEndsAt,
        group: group ?? this.group,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PendingRequest.fromJson(Map<String, dynamic> json) => PendingRequest(
    id: json["id"],
    role: json["role"],
    status: json["status"],
    suspensionEndsAt: json["suspension_ends_at"],
    group: RequestGroup.fromJson(json["group"]),
    user: RequestUser.fromJson(json["user"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "status": status,
    "suspension_ends_at": suspensionEndsAt,
    "group": group.toJson(),
    "user": user.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class RequestGroup {
  int id;
  String name;
  String uuid;
  String status;
  String image;

  RequestGroup({
    required this.id,
    required this.name,
    required this.uuid,
    required this.status,
    required this.image,
  });

  RequestGroup copyWith({
    int? id,
    String? name,
    String? uuid,
    String? status,
    String? image,
  }) =>
      RequestGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        uuid: uuid ?? this.uuid,
        status: status ?? this.status,
        image: image ?? this.image,
      );

  factory RequestGroup.fromJson(Map<String, dynamic> json) => RequestGroup(
    id: json["id"],
    name: json["name"],
    uuid: json["uuid"],
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "uuid": uuid,
    "status": status,
    "image": image,
  };
}

class RequestUser {
  int id;
  String avatar;
  String name;
  String username;
  String email;

  RequestUser({
    required this.id,
    required this.avatar,
    required this.name,
    required this.username,
    required this.email,
  });

  RequestUser copyWith({
    int? id,
    String? avatar,
    String? name,
    String? username,
    String? email,
  }) =>
      RequestUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory RequestUser.fromJson(Map<String, dynamic> json) => RequestUser(
    id: json["id"],
    avatar: json["avatar"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "name": name,
    "username": username,
    "email": email,
  };
}

class PendingRequestPaginationMeta {
  int currentPage;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;
  bool canLoadMore;

  PendingRequestPaginationMeta({
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

  PendingRequestPaginationMeta copyWith({
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
      PendingRequestPaginationMeta(
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

  factory PendingRequestPaginationMeta.fromJson(Map<String, dynamic> json) => PendingRequestPaginationMeta(
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
