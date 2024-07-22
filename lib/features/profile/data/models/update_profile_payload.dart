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

  UpdateProfilePayload({
    this.name,
    this.avatar,
    this.interests,
    this.age,
    this.username,
  });

  UpdateProfilePayload copyWith({
    String? name,
    String? avatar,
    List<int>? interests,
    int? age,
    String? username,
  }) =>
      UpdateProfilePayload(
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        interests: interests ?? this.interests,
        age: age ?? this.age,
        username: username ?? this.username,
      );

  factory UpdateProfilePayload.fromJson(Map<String, dynamic> json) =>
      UpdateProfilePayload(
        name: json["name"],
        avatar: json["avatar"],
        interests: List<int>.from(json["interests"].map((x) => x)),
        age: json["age"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "avatar": avatar,
        "interests": interests == null
            ? []
            : List<dynamic>.from(interests!.map((x) => x)),
        "age": age,
        "username": username,
      };
}
