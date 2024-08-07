// To parse this JSON data, do
//
//     final blockedUSersResponse = blockedUSersResponseFromJson(jsonString);

import 'dart:convert';

BlockedUsersResponse blockedUSersResponseFromJson(String str) =>
    BlockedUsersResponse.fromJson(json.decode(str));

String blockedUSersResponseToJson(BlockedUsersResponse data) =>
    json.encode(data.toJson());

class BlockedUsersResponse {
  String message;
  List<TalkamBlockedUser> data;
  bool success;
  int code;

  BlockedUsersResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  BlockedUsersResponse copyWith({
    String? message,
    List<TalkamBlockedUser>? data,
    bool? success,
    int? code,
  }) =>
      BlockedUsersResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory BlockedUsersResponse.fromJson(Map<String, dynamic> json) =>
      BlockedUsersResponse(
        message: json["message"],
        data: List<TalkamBlockedUser>.from(
            json["data"].map((x) => TalkamBlockedUser.fromJson(x))),
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

class TalkamBlockedUser {
  int id;
  Blocke blocker;
  Blocke blockedUser;
  DateTime createdAt;
  DateTime updatedAt;

  TalkamBlockedUser({
    required this.id,
    required this.blocker,
    required this.blockedUser,
    required this.createdAt,
    required this.updatedAt,
  });

  TalkamBlockedUser copyWith({
    int? id,
    Blocke? blocker,
    Blocke? blockedUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TalkamBlockedUser(
        id: id ?? this.id,
        blocker: blocker ?? this.blocker,
        blockedUser: blockedUser ?? this.blockedUser,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TalkamBlockedUser.fromJson(Map<String, dynamic> json) =>
      TalkamBlockedUser(
        id: json["id"],
        blocker: Blocke.fromJson(json["blocker"]),
        blockedUser: Blocke.fromJson(json["blocked_user"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "blocker": blocker.toJson(),
        "blocked_user": blockedUser.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Blocke {
  int id;
  dynamic avatar;
  dynamic name;
  dynamic username;
  dynamic email;

  Blocke({
    required this.id,
    required this.avatar,
    required this.name,
    required this.username,
    required this.email,
  });

  Blocke copyWith({
    int? id,
    String? avatar,
    String? name,
    String? username,
    String? email,
  }) =>
      Blocke(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory Blocke.fromJson(Map<String, dynamic> json) => Blocke(
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
