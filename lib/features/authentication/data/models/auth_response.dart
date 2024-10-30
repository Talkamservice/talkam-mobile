// To parse this JSON data, do
//
//     final authSuccessResponse = authSuccessResponseFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:talkam/common/models/get_countries_response.dart';
import 'package:talkam/common/models/get_states_response.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/subscription/data/models/get_plans_response.dart';

AuthSuccessResponse authSuccessResponseFromJson(String str) => AuthSuccessResponse.fromJson(json.decode(str));

String authSuccessResponseToJson(AuthSuccessResponse data) => json.encode(data.toJson());

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

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) => AuthSuccessResponse(
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
  dynamic role;
  dynamic age;

  dynamic gender;
  dynamic dob;
  dynamic country;
  dynamic state;

  dynamic googleId;
  dynamic facebookId;
  dynamic tiktokId;
  dynamic appleId;
  dynamic isBlocked;
  dynamic iamBlocked;
  ActiveSubscription? activeSubscription;
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
    required this.dob,
    required this.gender,
    required this.state,
    required this.country,
    required this.username,
    required this.status,
    required this.interests,
    required this.createdAt,
    required this.emailVerifiedAt,
    required this.updatedAt,
    required this.googleId,
    required this.facebookId,
    required this.tiktokId,
    required this.appleId,
    required this.isBlocked,
    required this.iamBlocked,
    this.activeSubscription,
  });

  TalkamUser copyWith(
          {int? id,
          dynamic avatar,
          String? name,
          String? email,
          String? role,
          dynamic googleId,
          dynamic age,
          dynamic gender,
          dynamic dob,
          dynamic country,
          dynamic state,
          dynamic facebookId,
          dynamic tiktokId,
          dynamic appleId,
          dynamic isBlocked,
          dynamic iamBlocked,
          String? username,
          String? status,
          List<PostCategory>? interests,
          DateTime? createdAt,
          DateTime? emailVerifiedAt,
          DateTime? updatedAt,
          ActiveSubscription? activeSubscription}) =>
      TalkamUser(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        age: age ?? this.age,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        state: state ?? this.state,
        country: country ?? this.country,
        username: username ?? this.username,
        status: status ?? this.status,
        interests: interests ?? this.interests,
        createdAt: createdAt ?? this.createdAt,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        googleId: googleId ?? this.googleId,
        facebookId: facebookId ?? this.facebookId,
        tiktokId: tiktokId ?? this.tiktokId,
        appleId: appleId ?? this.appleId,
        isBlocked: isBlocked ?? this.isBlocked,
        iamBlocked: iamBlocked ?? this.iamBlocked,
        activeSubscription: activeSubscription ?? this.activeSubscription,
      );

  factory TalkamUser.fromJson(Map<String, dynamic> json) => TalkamUser(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        age: json["age"],
        gender: json["gender"],
        dob: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        state: json["state"] == null ? null : TalkamState.fromJson(json["state"]),
        country: json["country"] == null ? null : TalkamCountry.fromJson(json["country"]),
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        tiktokId: json["tiktok_id"],
        appleId: json["apple_id"],
        isBlocked: json["is_blocked"],
        iamBlocked: json["i_am_blocked"],
        username: json["username"],
        status: json["status"],
        interests: List<PostCategory>.from(json["interests"].map((x) => PostCategory.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        activeSubscription: json["active_subscription"] == null ? null : ActiveSubscription?.fromJson(json["active_subscription"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "email": email,
        "role": role,
        "age": age,
        "date_of_birth": dob.toString(),
        "gender": gender,
        "country": country != null ? (country as TalkamCountry).toJson() : null,
        "state": state != null ? (state as TalkamState).toJson() : null,
        "is_blocked": isBlocked,
        "i_am_blocked": iamBlocked,
        "apple_id": appleId,
        "google_id": googleId,
        "facebook_id": facebookId,
        "tiktok_id": tiktokId,
        "username": username,
        "status": status,
        "interests": List<PostCategory>.from(interests.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "active_subscription": activeSubscription?.toJson(),
      };

  factory TalkamUser.forTest() {
    return TalkamUser(
      id: -1,
      avatar: "https://talkam.prodevs.io/file/YXBwL21lZGlhL3VzZXIvYXZhdGFycy82NjlmYjVjNGM4ZTBlLnBuZw==",
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
      googleId: null,
      facebookId: null,
      tiktokId: null,
      appleId: null,
      isBlocked: null,
      iamBlocked: null,
      dob: DateTime.now(),
      gender: "Male",
      state: null,
      country: null,
    );
  }
}

ActiveSubscription activeSubscriptionFromJson(String str) => ActiveSubscription.fromJson(json.decode(str));

String activeSubscriptionToJson(ActiveSubscription data) => json.encode(data.toJson());

class ActiveSubscription {
  int id;
  TalkamPlan plan;
  dynamic flutterwaveSubscriptionId;
  String status;
  DateTime expiresAt;
  dynamic renewalCancelledAt;
  DateTime createdAt;
  DateTime updatedAt;

  ActiveSubscription({
    required this.id,
    required this.plan,
    required this.flutterwaveSubscriptionId,
    required this.status,
    required this.expiresAt,
    required this.renewalCancelledAt,
    required this.createdAt,
    required this.updatedAt,
  });

  ActiveSubscription copyWith({
    int? id,
    TalkamPlan? plan,
    dynamic flutterwaveSubscriptionId,
    String? status,
    DateTime? expiresAt,
    dynamic renewalCancelledAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ActiveSubscription(
        id: id ?? this.id,
        plan: plan ?? this.plan,
        flutterwaveSubscriptionId: flutterwaveSubscriptionId ?? this.flutterwaveSubscriptionId,
        status: status ?? this.status,
        expiresAt: expiresAt ?? this.expiresAt,
        renewalCancelledAt: renewalCancelledAt ?? this.renewalCancelledAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) => ActiveSubscription(
        id: json["id"],
        plan: TalkamPlan.fromJson(json["plan"]),
        flutterwaveSubscriptionId: json["flutterwave_subscription_id"],
        status: json["status"],
        expiresAt: DateTime.parse(json["expires_at"]),
        renewalCancelledAt: json["renewal_cancelled_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plan": plan.toJson(),
        "flutterwave_subscription_id": flutterwaveSubscriptionId,
        "status": status,
        "expires_at": expiresAt.toIso8601String(),
        "renewal_cancelled_at": renewalCancelledAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
