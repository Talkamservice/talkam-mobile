// To parse this JSON data, do
//
//     final authSuccessResponse = authSuccessResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/post/data/models/get_categories_response.dart';

AuthSuccessResponse authSuccessResponseFromJson(String str) =>
    AuthSuccessResponse.fromJson(json.decode(str));

String authSuccessResponseToJson(AuthSuccessResponse data) =>
    json.encode(data.toJson());

class AuthSuccessResponse {
  String message;
  Data data;
  bool success;
  int code;

  AuthSuccessResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  AuthSuccessResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      AuthSuccessResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) =>
      AuthSuccessResponse(
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
  String token;
  TalkamUser user;

  Data({
    required this.token,
    required this.user,
  });

  Data copyWith({
    String? token,
    TalkamUser? user,
  }) =>
      Data(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: TalkamUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class TalkamUser {
  int id;
  dynamic avatar;
  String name;
  String email;
  String role;
  dynamic age;
  String username;
  String status;
  List<PostCategory> interests;
  DateTime createdAt;
  DateTime? emailVerifiedAt;
  DateTime updatedAt;

  TalkamUser({
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.role,
    required this.age,
    required this.username,
    required this.status,
    required this.interests,
    required this.createdAt,
    required this.emailVerifiedAt,
    required this.updatedAt,
  });

  TalkamUser copyWith({
    int? id,
    dynamic avatar,
    String? name,
    String? email,
    String? role,
    dynamic age,
    String? username,
    String? status,
    List<PostCategory>? interests,
    DateTime? createdAt,
    DateTime? emailVerifiedAt,
    DateTime? updatedAt,
  }) =>
      TalkamUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        age: age ?? this.age,
        username: username ?? this.username,
        status: status ?? this.status,
        interests: interests ?? this.interests,
        createdAt: createdAt ?? this.createdAt,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TalkamUser.fromJson(Map<String, dynamic> json) => TalkamUser(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        age: json["age"],
        username: json["username"],
        status: json["status"],
        interests: List<PostCategory>.from(
            json["interests"].map((x) => PostCategory.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "email": email,
        "role": role,
        "age": age,
        "username": username,
        "status": status,
        "interests": List<PostCategory>.from(interests.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),

      };

  factory TalkamUser.forTest() {
    return TalkamUser(
      id: -1,
      avatar:
          "https://talkam.prodevs.io/file/YXBwL21lZGlhL3VzZXIvYXZhdGFycy82NjlmYjVjNGM4ZTBlLnBuZw==",
      email: "bardakhaev@shopshiba.site",
      role: "User",
      age: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      username: "bardo_khan",
      name: "bardo_khan",
      status: "Active",
      interests: [],
      emailVerifiedAt: DateTime.now(),
    );
  }
}
