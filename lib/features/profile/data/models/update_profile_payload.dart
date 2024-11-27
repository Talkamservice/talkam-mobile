// To parse this JSON data, do
//
//     final updateProfilePayload = updateProfilePayloadFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/core/utils/extensions/date_extensions.dart';

UpdateProfilePayload updateProfilePayloadFromJson(String str) => UpdateProfilePayload.fromJson(json.decode(str));

String updateProfilePayloadToJson(UpdateProfilePayload data) => json.encode(data.toJson());

class UpdateProfilePayload {
  String? name;
  String? avatar;
  List<int>? interests;
  int? age;
  String? username;
  String? password;
  String? paswordConfirmation;
  DateTime? dob;
  String? gender;
  String? countryId;
  String? stateId;
  int? shouldDisplayAd;

  UpdateProfilePayload({
    this.name,
    this.avatar,
    this.interests,
    this.age,
    this.username,
    this.password,
    this.paswordConfirmation,
    this.dob,
    this.gender,
    this.countryId,
    this.stateId,
    this.shouldDisplayAd,
  });

  UpdateProfilePayload copyWith(
          {String? name,
          String? avatar,
          List<int>? interests,
          int? age,
          String? username,
          String? password,
          String? gender,
          String? countryId,
          String? stateId,
          DateTime? dob,
          int? shouldDisplayAd,
          String? paswordConfirmation}) =>
      UpdateProfilePayload(
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        interests: interests ?? this.interests,
        age: age ?? this.age,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        username: username ?? this.username,
        password: password ?? this.password,
        countryId: countryId ?? this.countryId,
        stateId: stateId ?? this.stateId,
        shouldDisplayAd: shouldDisplayAd ?? this.shouldDisplayAd,
        paswordConfirmation: paswordConfirmation ?? this.paswordConfirmation,
      );

  factory UpdateProfilePayload.fromJson(Map<String, dynamic> json) => UpdateProfilePayload(
        name: json["name"],
        avatar: json["avatar"],
        interests: List<int>.from(json["interests"].map((x) => x)),
        age: json["age"],
        username: json["username"],
        password: json["password"],
        countryId: json["country_id"],
        stateId: json["tate_id"],
        dob: json["date_of_birth"],
        gender: json["gender"],
        shouldDisplayAd: json["should_display_ads"],
        paswordConfirmation: json["password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        if (name != null) "name": name,
        if (avatar != null) "avatar": avatar,
        if (interests != null) "interests": interests == null ? [] : List<dynamic>.from(interests!.map((x) => x)),
        if (age != null) "age": age,
        if (username != null) "username": username,
        if (password != null) "password": password,
        if (dob != null) "date_of_birth": dob?.toCustomString,
        if (gender != null) "gender": gender,
        if (countryId != null) "country_id": countryId,
        if (stateId != null) "state_id": stateId,
        if (shouldDisplayAd != null) "should_display_ads": shouldDisplayAd,
        if (paswordConfirmation != null) "password_confirmation": paswordConfirmation,
      };
}
