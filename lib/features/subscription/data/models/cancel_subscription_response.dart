// To parse this JSON data, do
//
//     final cancelSubscriptionResponse = cancelSubscriptionResponseFromJson(jsonString);

import 'dart:convert';

CancelSubscriptionResponse cancelSubscriptionResponseFromJson(String str) => CancelSubscriptionResponse.fromJson(json.decode(str));

String cancelSubscriptionResponseToJson(CancelSubscriptionResponse data) => json.encode(data.toJson());

class CancelSubscriptionResponse {
  String message;
  Data data;
  bool success;
  int code;

  CancelSubscriptionResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  CancelSubscriptionResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      CancelSubscriptionResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory CancelSubscriptionResponse.fromJson(Map<String, dynamic> json) => CancelSubscriptionResponse(
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
  Plan plan;
  dynamic flutterwaveSubscriptionId;
  DateTime expiresAt;
  DateTime renewalCancelledAt;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.user,
    required this.plan,
    required this.flutterwaveSubscriptionId,
    required this.expiresAt,
    required this.renewalCancelledAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    User? user,
    Plan? plan,
    dynamic flutterwaveSubscriptionId,
    DateTime? expiresAt,
    DateTime? renewalCancelledAt,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        user: user ?? this.user,
        plan: plan ?? this.plan,
        flutterwaveSubscriptionId: flutterwaveSubscriptionId ?? this.flutterwaveSubscriptionId,
        expiresAt: expiresAt ?? this.expiresAt,
        renewalCancelledAt: renewalCancelledAt ?? this.renewalCancelledAt,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    user: User.fromJson(json["user"]),
    plan: Plan.fromJson(json["plan"]),
    flutterwaveSubscriptionId: json["flutterwave_subscription_id"],
    expiresAt: DateTime.parse(json["expires_at"]),
    renewalCancelledAt: DateTime.parse(json["renewal_cancelled_at"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "plan": plan.toJson(),
    "flutterwave_subscription_id": flutterwaveSubscriptionId,
    "expires_at": expiresAt.toIso8601String(),
    "renewal_cancelled_at": renewalCancelledAt.toIso8601String(),
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Plan {
  int id;
  String name;
  dynamic description;
  String frequency;
  int price;
  dynamic discount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.frequency,
    required this.price,
    required this.discount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Plan copyWith({
    int? id,
    String? name,
    dynamic description,
    String? frequency,
    int? price,
    dynamic discount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Plan(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        frequency: frequency ?? this.frequency,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    frequency: json["frequency"],
    price: json["price"],
    discount: json["discount"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "frequency": frequency,
    "price": price,
    "discount": discount,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class User {
  int id;
  String avatar;
  String name;
  String username;
  String email;

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
