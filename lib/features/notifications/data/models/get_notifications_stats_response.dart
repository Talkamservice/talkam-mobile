// To parse this JSON data, do
//
//     final getNotificationsStatsResponse = getNotificationsStatsResponseFromJson(jsonString);

import 'dart:convert';

GetNotificationsStatsResponse getNotificationsStatsResponseFromJson(String str) => GetNotificationsStatsResponse.fromJson(json.decode(str));

String getNotificationsStatsResponseToJson(GetNotificationsStatsResponse data) => json.encode(data.toJson());

class GetNotificationsStatsResponse {
  String message;
  NotificationsStats data;
  bool success;
  int code;

  GetNotificationsStatsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetNotificationsStatsResponse copyWith({
    String? message,
    NotificationsStats? data,
    bool? success,
    int? code,
  }) =>
      GetNotificationsStatsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetNotificationsStatsResponse.fromJson(Map<String, dynamic> json) => GetNotificationsStatsResponse(
        message: json["message"],
        data: NotificationsStats.fromJson(json["data"]),
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

class NotificationsStats {
  int notifications;
  int unreadNotifications;
  int unreadMessages;
  int totalRequests;
  int postActivity;
  int conversation;
  int systemAdmin;

  NotificationsStats({
    required this.notifications,
    required this.unreadNotifications,
    required this.unreadMessages,
    required this.totalRequests,
    required this.postActivity,
    required this.conversation,
    required this.systemAdmin,
  });

  NotificationsStats copyWith({
    int? notifications,
    int? unreadNotifications,
    int? unreadMessages,
    int? totalRequests,
    int? postActivity,
    int? conversation,
    int? systemAdmin,
  }) =>
      NotificationsStats(
        notifications: notifications ?? this.notifications,
        unreadNotifications: unreadNotifications ?? this.unreadNotifications,
        unreadMessages: unreadMessages ?? this.unreadMessages,
        totalRequests: totalRequests ?? this.totalRequests,
        postActivity: postActivity ?? this.postActivity,
        conversation: conversation ?? this.conversation,
        systemAdmin: systemAdmin ?? this.systemAdmin,
      );

  factory NotificationsStats.fromJson(Map<String, dynamic> json) => NotificationsStats(
        notifications: json["notifications"],
        unreadNotifications: json["unread_notifications"],
        unreadMessages: json["unread_messages"],
        totalRequests: json["total_requests"],
        postActivity: json["post_activity"],
        conversation: json["conversation"],
        systemAdmin: json["system_admin"],
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications,
        "unread_notifications": unreadNotifications,
        "unread_messages": unreadMessages,
        "total_requests": totalRequests,
        "post_activity": postActivity,
        "conversation": conversation,
        "system_admin": systemAdmin,
      };

  factory NotificationsStats.initial() => NotificationsStats(
        notifications: 0,
        unreadNotifications: 0,
        unreadMessages: 0,
        totalRequests: 0,
        postActivity: 0,
        conversation: 0,
        systemAdmin: 0,
      );
}
