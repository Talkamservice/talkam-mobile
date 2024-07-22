// To parse this JSON data, do
//
//     final postDetailsResponse = postDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/post/data/models/get_posts_response.dart';

PostDetailsResponse postDetailsResponseFromJson(String str) =>
    PostDetailsResponse.fromJson(json.decode(str));

String postDetailsResponseToJson(PostDetailsResponse data) =>
    json.encode(data.toJson());

class PostDetailsResponse {
  String message;
  TalkamPost data;
  bool success;
  int code;

  PostDetailsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  PostDetailsResponse copyWith({
    String? message,
    TalkamPost? data,
    bool? success,
    int? code,
  }) =>
      PostDetailsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory PostDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PostDetailsResponse(
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

class Poll {
  int id;
  String option;
  String type;
  bool selected;
  DateTime createdAt;

  Poll({
    required this.id,
    required this.option,
    required this.type,
    required this.selected,
    required this.createdAt,
  });

  Poll copyWith({
    int? id,
    String? option,
    String? type,
    bool? selected,
    DateTime? createdAt,
  }) =>
      Poll(
        id: id ?? this.id,
        option: option ?? this.option,
        type: type ?? this.type,
        selected: selected ?? this.selected,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
        id: json["id"],
        option: json["option"],
        type: json["type"],
        selected: json["selected"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "option": option,
        "type": type,
        "selected": selected,
        "created_at": createdAt.toIso8601String(),
      };
}

class Reaction {
  int id;
  String action;
  DateTime createdAt;

  Reaction({
    required this.id,
    required this.action,
    required this.createdAt,
  });

  Reaction copyWith({
    int? id,
    String? action,
    DateTime? createdAt,
  }) =>
      Reaction(
        id: id ?? this.id,
        action: action ?? this.action,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        id: json["id"],
        action: json["action"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "action": action,
        "created_at": createdAt.toIso8601String(),
      };
}


