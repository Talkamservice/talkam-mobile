// To parse this JSON data, do
//
//     final reactionModel = reactionModelFromJson(jsonString);

import 'dart:convert';

ReactionResponse reactionModelFromJson(String str) =>
    ReactionResponse.fromJson(json.decode(str));

String reactionModelToJson(ReactionResponse data) => json.encode(data.toJson());

class ReactionResponse {
  String message;
  TalkamReaction data;
  bool success;
  int code;

  ReactionResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  ReactionResponse copyWith({
    String? message,
    TalkamReaction? data,
    bool? success,
    int? code,
  }) =>
      ReactionResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory ReactionResponse.fromJson(Map<String, dynamic> json) =>
      ReactionResponse(
        message: json["message"],
        data: TalkamReaction.fromJson(json["data"]),
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

class TalkamReaction {
  String action;
  bool status;

  TalkamReaction({
    required this.action,
    required this.status,
  });

  TalkamReaction copyWith({
    String? action,
    bool? status,
  }) =>
      TalkamReaction(
        action: action ?? this.action,
        status: status ?? this.status,
      );

  factory TalkamReaction.fromJson(Map<String, dynamic> json) => TalkamReaction(
        action: json["action"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "status": status,
      };
}
