// To parse this JSON data, do
//
//     final notificationsPreferenceResponse = notificationsPreferenceResponseFromJson(jsonString);

import 'dart:convert';

NotificationsPreferenceResponse notificationsPreferenceResponseFromJson(String str) => NotificationsPreferenceResponse.fromJson(json.decode(str));

String notificationsPreferenceResponseToJson(NotificationsPreferenceResponse data) => json.encode(data.toJson());

class NotificationsPreferenceResponse {
  String message;
  Data data;
  bool success;

  int code;

  NotificationsPreferenceResponse({
    required this.message,
    required this.data,
    required this.success,

    required this.code,
  });

  NotificationsPreferenceResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      NotificationsPreferenceResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory NotificationsPreferenceResponse.fromJson(Map<String, dynamic> json) => NotificationsPreferenceResponse(
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
  int talkamNews;
  int talkamResearch;
  int userActivities;
  dynamic comments;
  int moderationActivities;
  RelatedUser user;

  Data({
    required this.id,
    required this.talkamNews,
    required this.talkamResearch,
    required this.userActivities,
    required this.comments,
    required this.moderationActivities,
    required this.user,
  });

  Data copyWith({
    int? id,
    int? talkamNews,
    int? talkamResearch,
    int? userActivities,
    String? comments,
    int? moderationActivities,
    RelatedUser? user,
  }) =>
      Data(
        id: id ?? this.id,
        talkamNews: talkamNews ?? this.talkamNews,
        talkamResearch: talkamResearch ?? this.talkamResearch,
        userActivities: userActivities ?? this.userActivities,
        comments: comments ?? this.comments,
        moderationActivities: moderationActivities ?? this.moderationActivities,
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    talkamNews: json["talkam_news"],
    talkamResearch: json["talkam_research"],
    userActivities: json["user_activities"],
    comments: json["comments"],
    moderationActivities: json["moderation_activities"],
    user: RelatedUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "talkam_news": talkamNews,
    "talkam_research": talkamResearch,
    "user_activities": userActivities,
    "comments": comments,
    "moderation_activities": moderationActivities,
    "user": user.toJson(),
  };
}

class RelatedUser {
  int id;
  String avatar;
  String name;
  String username;
  String email;

  RelatedUser({
    required this.id,
    required this.avatar,
    required this.name,
    required this.username,
    required this.email,
  });

  RelatedUser copyWith({
    int? id,
    String? avatar,
    String? name,
    String? username,
    String? email,
  }) =>
      RelatedUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory RelatedUser.fromJson(Map<String, dynamic> json) => RelatedUser(
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
