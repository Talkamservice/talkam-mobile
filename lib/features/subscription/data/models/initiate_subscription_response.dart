// To parse this JSON data, do
//
//     final initiateSubscriptionResponse = initiateSubscriptionResponseFromJson(jsonString);

import 'dart:convert';

InitiateSubscriptionResponse initiateSubscriptionResponseFromJson(String str) => InitiateSubscriptionResponse.fromJson(json.decode(str));

String initiateSubscriptionResponseToJson(InitiateSubscriptionResponse data) => json.encode(data.toJson());

class InitiateSubscriptionResponse {
  String message;
  Data data;
  bool success;
  int code;

  InitiateSubscriptionResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  InitiateSubscriptionResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      InitiateSubscriptionResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory InitiateSubscriptionResponse.fromJson(Map<String, dynamic> json) => InitiateSubscriptionResponse(
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
  User user;
  String currency;
  int amount;
  int fees;
  String reference;
  String activity;
  String description;
  Metadata metadata;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.user,
    required this.currency,
    required this.amount,
    required this.fees,
    required this.reference,
    required this.activity,
    required this.description,
    required this.metadata,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    User? user,
    String? currency,
    int? amount,
    int? fees,
    String? reference,
    String? activity,
    String? description,
    Metadata? metadata,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        user: user ?? this.user,
        currency: currency ?? this.currency,
        amount: amount ?? this.amount,
        fees: fees ?? this.fees,
        reference: reference ?? this.reference,
        activity: activity ?? this.activity,
        description: description ?? this.description,
        metadata: metadata ?? this.metadata,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    user: User.fromJson(json["user"]),
    currency: json["currency"],
    amount: json["amount"],
    fees: json["fees"],
    reference: json["reference"],
    activity: json["activity"],
    description: json["description"],
    metadata: Metadata.fromJson(json["metadata"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "currency": currency,
    "amount": amount,
    "fees": fees,
    "reference": reference,
    "activity": activity,
    "description": description,
    "metadata": metadata.toJson(),
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Metadata {
  int amount;
  int planDurationId;
  String flutterwavePlanId;
  String email;
  String activity;

  Metadata({
    required this.amount,
    required this.planDurationId,
    required this.flutterwavePlanId,
    required this.email,
    required this.activity,
  });

  Metadata copyWith({
    int? amount,
    int? planDurationId,
    String? flutterwavePlanId,
    String? email,
    String? activity,
  }) =>
      Metadata(
        amount: amount ?? this.amount,
        planDurationId: planDurationId ?? this.planDurationId,
        flutterwavePlanId: flutterwavePlanId ?? this.flutterwavePlanId,
        email: email ?? this.email,
        activity: activity ?? this.activity,
      );

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    amount: json["amount"],
    planDurationId: json["plan_duration_id"],
    flutterwavePlanId: json["flutterwave_plan_id"],
    email: json["email"],
    activity: json["activity"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "plan_duration_id": planDurationId,
    "flutterwave_plan_id": flutterwavePlanId,
    "email": email,
    "activity": activity,
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
    String? avatar,
    String? name,
    String? username,
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
