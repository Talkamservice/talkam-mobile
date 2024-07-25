// To parse this JSON data, do
//
//     final getGuidlinesResponse = getGuidlinesResponseFromJson(jsonString);

import 'dart:convert';

GetGuidlinesResponse getGuidlinesResponseFromJson(String str) =>
    GetGuidlinesResponse.fromJson(json.decode(str));

String getGuidlinesResponseToJson(GetGuidlinesResponse data) =>
    json.encode(data.toJson());

class GetGuidlinesResponse {
  String message;
  List<TalkamGuidelineModel> data;
  bool success;
  int code;

  GetGuidlinesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetGuidlinesResponse copyWith({
    String? message,
    List<TalkamGuidelineModel>? data,
    bool? success,
    int? code,
  }) =>
      GetGuidlinesResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetGuidlinesResponse.fromJson(Map<String, dynamic> json) =>
      GetGuidlinesResponse(
        message: json["message"],
        data: List<TalkamGuidelineModel>.from(
            json["data"].map((x) => TalkamGuidelineModel.fromJson(x))),
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "code": code,
      };
}

class TalkamGuidelineModel {
  int id;
  String title;
  String description;
  String status;
  dynamic group;
  DateTime createdAt;
  DateTime updatedAt;

  TalkamGuidelineModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.group,
    required this.createdAt,
    required this.updatedAt,
  });

  TalkamGuidelineModel copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    dynamic group,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TalkamGuidelineModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        group: group ?? this.group,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TalkamGuidelineModel.fromJson(Map<String, dynamic> json) =>
      TalkamGuidelineModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        group: json["group"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "group": group,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
