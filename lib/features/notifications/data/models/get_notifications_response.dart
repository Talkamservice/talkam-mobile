// To parse this JSON data, do
//
//     final getNotificationsResponse = getNotificationsResponseFromJson(jsonString);

import 'dart:convert';

GetNotificationsResponse getNotificationsResponseFromJson(String str) => GetNotificationsResponse.fromJson(json.decode(str));

String getNotificationsResponseToJson(GetNotificationsResponse data) => json.encode(data.toJson());

class GetNotificationsResponse {
  String message;
  List<TalkamNotification> data;
  bool success;
  int code;

  GetNotificationsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetNotificationsResponse copyWith({
    String? message,
    List<TalkamNotification>? data,
    bool? success,
    int? code,
  }) =>
      GetNotificationsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) => GetNotificationsResponse(
        message: json["message"],
        data: List<TalkamNotification>.from(json["data"].map((x) => TalkamNotification.fromJson(x))),
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

class TalkamNotification {
  dynamic id;
  dynamic title;
  dynamic message;
  dynamic type;
  dynamic dataId;
  dynamic extra;
  dynamic readAt;
  DateTime createdAt;

  TalkamNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.dataId,
    required this.extra,
    required this.readAt,
    required this.createdAt,
  });

  TalkamNotification copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    int? dataId,
    dynamic extra,
    dynamic readAt,
    DateTime? createdAt,
  }) =>
      TalkamNotification(
        id: id ?? this.id,
        title: title ?? this.title,
        message: message ?? this.message,
        type: type ?? this.type,
        dataId: dataId ?? this.dataId,
        extra: extra ?? this.extra,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory TalkamNotification.fromJson(Map<String, dynamic> json) => TalkamNotification(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        type: json["type"],
        dataId: json["data_id"],
        extra: json["extra"] is List ? [] : json["extra"],
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "type": type,
        "data_id": dataId,
        "extra": extra,
        "read_at": readAt,
        "created_at": createdAt.toIso8601String(),
      };
}

class ExtraClass {
  NotificationUser? sender;
  NotificationUser? receiver;

  ExtraClass({
    this.sender,
    this.receiver,
  });

  ExtraClass copyWith({
    NotificationUser? sender,
    NotificationUser? receiver,
  }) =>
      ExtraClass(
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
      );

  factory ExtraClass.fromJson(Map<String, dynamic> json) => ExtraClass(
        sender: json["sender"] == null ? null : NotificationUser.fromJson(json["sender"]),
        receiver: json["receiver"] == null ? null : NotificationUser.fromJson(json["receiver"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
      };
}

class NotificationUser {
  dynamic id;
  String avatar;
  String name;
  String username;
  String email;

  NotificationUser({
    required this.id,
    required this.avatar,
    required this.name,
    required this.username,
    required this.email,
  });

  NotificationUser copyWith({
    int? id,
    String? avatar,
    String? name,
    String? username,
    String? email,
  }) =>
      NotificationUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory NotificationUser.fromJson(Map<String, dynamic> json) => NotificationUser(
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
