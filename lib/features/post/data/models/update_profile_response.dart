// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/authentication/data/models/auth_response.dart';

UpdateProfileResponse updateProfileResponseFromJson(String str) =>
    UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) =>
    json.encode(data.toJson());

class UpdateProfileResponse {
  String message;
  TalkamUser data;
  bool success;
  int code;

  UpdateProfileResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  UpdateProfileResponse copyWith({
    String? message,
    TalkamUser? data,
    bool? success,
    int? code,
  }) =>
      UpdateProfileResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(
        message: json["message"],
        data: TalkamUser.fromJson(json["data"]),
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
