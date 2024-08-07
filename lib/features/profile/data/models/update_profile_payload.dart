// To parse this JSON data, do
//
//     final updateProfilePayload = updateProfilePayloadFromJson(jsonString);

import 'dart:convert';

UpdateProfilePayload updateProfilePayloadFromJson(String str) =>
    UpdateProfilePayload.fromJson(json.decode(str));

String updateProfilePayloadToJson(UpdateProfilePayload data) =>
    json.encode(data.toJson());

class UpdateProfilePayload {
  String? name;
  String? avatar;
  List<int>? interests;
  int? age;
  String? username;
  String? password;
  String? paswordConfirmation;

  UpdateProfilePayload({
    this.name,
    this.avatar,
    this.interests,
    this.age,
    this.username,
    this.password,
    this.paswordConfirmation,
  });

  UpdateProfilePayload copyWith(
          {String? name,
          String? avatar,
          List<int>? interests,
          int? age,
          String? username,
          String? password,
          String? paswordConfirmation}) =>
      UpdateProfilePayload(
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        interests: interests ?? this.interests,
        age: age ?? this.age,
        username: username ?? this.username,
        password: password ?? this.password,
        paswordConfirmation: paswordConfirmation ?? this.paswordConfirmation,
      );

  factory UpdateProfilePayload.fromJson(Map<String, dynamic> json) =>
      UpdateProfilePayload(
        name: json["name"],
        avatar: json["avatar"],
        interests: List<int>.from(json["interests"].map((x) => x)),
        age: json["age"],
        username: json["username"],
        password: json["password"],
        paswordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        if (name != null) "name": name,
        if (avatar != null) "avatar": avatar,
        if (interests != null)
          "interests": interests == null
              ? []
              : List<dynamic>.from(interests!.map((x) => x)),
        if (age != null) "age": age,
        if (username != null) "username": username,
        if (password != null) "password": password,
        if (paswordConfirmation != null)
          "password_confirmation": paswordConfirmation,
      };
}
