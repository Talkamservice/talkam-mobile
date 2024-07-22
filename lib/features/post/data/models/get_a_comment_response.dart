// To parse this JSON data, do
//
//     final getACommentsResponse = getACommentsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/post/data/models/get_comments_response.dart';

GetACommentsResponse getACommentsResponseFromJson(String str) =>
    GetACommentsResponse.fromJson(json.decode(str));

String getACommentsResponseToJson(GetACommentsResponse data) =>
    json.encode(data.toJson());

class GetACommentsResponse {
  String message;
  PostComment data;
  bool success;
  int code;

  GetACommentsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetACommentsResponse copyWith({
    String? message,
    PostComment? data,
    bool? success,
    int? code,
  }) =>
      GetACommentsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetACommentsResponse.fromJson(Map<String, dynamic> json) =>
      GetACommentsResponse(
        message: json["message"],
        data: PostComment.fromJson(json["data"]),
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
