// To parse this JSON data, do
//
//     final getAnnounscementsResponse = getAnnounscementsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/authentication/data/models/auth_response.dart';

GetAnnounscementsResponse getAnnounscementsResponseFromJson(String str) => GetAnnounscementsResponse.fromJson(json.decode(str));

String getAnnounscementsResponseToJson(GetAnnounscementsResponse data) => json.encode(data.toJson());

class GetAnnounscementsResponse {
  String message;
  List<TalkamAnnouncement> data;
  bool success;
  int code;

  GetAnnounscementsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetAnnounscementsResponse copyWith({
    String? message,
    List<TalkamAnnouncement>? data,
    bool? success,
    int? code,
  }) =>
      GetAnnounscementsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetAnnounscementsResponse.fromJson(Map<String, dynamic> json) => GetAnnounscementsResponse(
        message: json["message"],
        data: List<TalkamAnnouncement>.from(json["data"].map((x) => TalkamAnnouncement.fromJson(x))),
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

class TalkamAnnouncement {
  int id;
  User user;
  dynamic bannerImage;
  dynamic title;
  dynamic description;
  Audience audience;
  String status;
  DateTime publishedAt;
  DateTime createdAt;
  dynamic expiresAt;
  DateTime updatedAt;

  TalkamAnnouncement({
    required this.id,
    required this.user,
    required this.bannerImage,
    required this.title,
    required this.description,
    required this.audience,
    required this.status,
    required this.publishedAt,
    required this.createdAt,
    required this.expiresAt,
    required this.updatedAt,
  });

  TalkamAnnouncement copyWith({
    int? id,
    User? user,
    String? bannerImage,
    String? title,
    String? description,
    Audience? audience,
    String? status,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? updatedAt,
  }) =>
      TalkamAnnouncement(
        id: id ?? this.id,
        user: user ?? this.user,
        bannerImage: bannerImage ?? this.bannerImage,
        title: title ?? this.title,
        description: description ?? this.description,
        audience: audience ?? this.audience,
        status: status ?? this.status,
        publishedAt: publishedAt ?? this.publishedAt,
        createdAt: createdAt ?? this.createdAt,
        expiresAt: expiresAt ?? this.expiresAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TalkamAnnouncement.fromJson(Map<String, dynamic> json) => TalkamAnnouncement(
        id: json["id"],
        user: User.fromJson(json["user"]),
        bannerImage: json["banner_image"],
        title: json["title"],
        description: json["description"],
        audience: Audience.fromJson(json["audience"]),
        status: json["status"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        expiresAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "banner_image": bannerImage,
        "title": title,
        "description": description,
        "audience": audience.toJson(),
        "status": status,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Audience {
  String type;
  List<User> data;

  Audience({
    required this.type,
    required this.data,
  });

  Audience copyWith({
    String? type,
    List<User>? data,
  }) =>
      Audience(
        type: type ?? this.type,
        data: data ?? this.data,
      );

  factory Audience.fromJson(Map<String, dynamic> json) => Audience(
        type: json["type"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class User {
  dynamic id;
  dynamic avatar;
  dynamic name;
  dynamic username;
  dynamic email;

  User({
    required this.id,
    required this.avatar,
    required this.name,
    required this.username,
    required this.email,
  });

  User copyWith({
    int? id,
    dynamic avatar,
    String? name,
    dynamic username,
    String? email,
  }) =>
      User(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
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
