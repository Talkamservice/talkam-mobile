// To parse this JSON data, do
//
//     final getAvatarsResponse = getAvatarsResponseFromJson(jsonString);

import 'dart:convert';

GetAvatarsResponse getAvatarsResponseFromJson(String str) =>
    GetAvatarsResponse.fromJson(json.decode(str));

String getAvatarsResponseToJson(GetAvatarsResponse data) =>
    json.encode(data.toJson());

class GetAvatarsResponse {
  String message;
  List<TalkamAvatar> data;
  bool success;
  int code;

  GetAvatarsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetAvatarsResponse copyWith({
    String? message,
    List<TalkamAvatar>? data,
    bool? success,
    int? code,
  }) =>
      GetAvatarsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetAvatarsResponse.fromJson(Map<String, dynamic> json) =>
      GetAvatarsResponse(
        message: json["message"],
        data: List<TalkamAvatar>.from(
            json["data"].map((x) => TalkamAvatar.fromJson(x))),
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

class TalkamAvatar {
  int id;
  dynamic title;
  dynamic description;
  dynamic status;
  String image;
  DateTime createdAt;
  DateTime updatedAt;


  TalkamAvatar({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  TalkamAvatar copyWith({
    int? id,
    dynamic title,
    String? description,
    String? status,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TalkamAvatar(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TalkamAvatar.fromJson(Map<String, dynamic> json) => TalkamAvatar(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
