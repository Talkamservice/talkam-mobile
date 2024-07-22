// To parse this JSON data, do
//
//     final createPostResponse = createPostResponseFromJson(jsonString);

import 'dart:convert';

CreatePostResponse createPostResponseFromJson(String str) =>
    CreatePostResponse.fromJson(json.decode(str));

String createPostResponseToJson(CreatePostResponse data) =>
    json.encode(data.toJson());

class CreatePostResponse {
  String message;
  Data data;
  bool success;
  int code;

  CreatePostResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  CreatePostResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      CreatePostResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) =>
      CreatePostResponse(
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
  int id;
  dynamic title;
  dynamic body;
  String type;
  String uuid;
  PostCreator user;
  int canComment;
  int isAnonymous;
  dynamic viewsCount;
  String status;
  dynamic publishAt;
  List<dynamic> attachments;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.uuid,
    required this.user,
    required this.canComment,
    required this.isAnonymous,
    required this.viewsCount,
    required this.status,
    required this.publishAt,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    String? title,
    String? body,
    String? type,
    String? uuid,
    PostCreator? user,
    int? canComment,
    int? isAnonymous,
    dynamic viewsCount,
    String? status,
    dynamic publishAt,
    List<dynamic>? attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        uuid: uuid ?? this.uuid,
        user: user ?? this.user,
        canComment: canComment ?? this.canComment,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        viewsCount: viewsCount ?? this.viewsCount,
        status: status ?? this.status,
        publishAt: publishAt ?? this.publishAt,
        attachments: attachments ?? this.attachments,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        type: json["type"],
        uuid: json["uuid"],
        user: PostCreator.fromJson(json["user"]),
        canComment: json["can_comment"],
        isAnonymous: json["is_anonymous"],
        viewsCount: json["views_count"],
        status: json["status"],
        publishAt: json["publish_at"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "type": type,
        "uuid": uuid,
        "user": user.toJson(),
        "can_comment": canComment,
        "is_anonymous": isAnonymous,
        "views_count": viewsCount,
        "status": status,
        "publish_at": publishAt,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PostCreator {
  int id;
  dynamic avatar;
  String name;
  String email;
  dynamic role;
  dynamic username;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  PostCreator({
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.role,
    required this.username,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  PostCreator copyWith({
    int? id,
    String? avatar,
    String? name,
    String? email,
    String? role,
    String? username,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PostCreator(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        username: username ?? this.username,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PostCreator.fromJson(Map<String, dynamic> json) => PostCreator(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        username: json["username"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "email": email,
        "role": role,
        "username": username,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
