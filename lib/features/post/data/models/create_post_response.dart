// To parse this JSON data, do
//
//     final createPostResponse = createPostResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/post/data/models/get_posts_response.dart';

CreatePostResponse createPostResponseFromJson(String str) =>
    CreatePostResponse.fromJson(json.decode(str));

String createPostResponseToJson(CreatePostResponse data) =>
    json.encode(data.toJson());

/// Create Post and Save Draft both return a full post object — the v2 spec
/// documents this shape via the draft-creation response.
class CreatePostResponse {
  String message;
  TalkamPost data;
  bool success;
  int code;

  CreatePostResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  CreatePostResponse copyWith({
    String? message,
    TalkamPost? data,
    bool? success,
    int? code,
  }) =>
      CreatePostResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) =>
      CreatePostResponse(
        message: json["message"],
        data: TalkamPost.fromJson(json["data"]),
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
