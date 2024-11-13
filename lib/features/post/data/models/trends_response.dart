// To parse this JSON data, do
//
//     final trendsResponse = trendsResponseFromJson(jsonString);

import 'dart:convert';

TrendsResponse trendsResponseFromJson(String str) => TrendsResponse.fromJson(json.decode(str));

String trendsResponseToJson(TrendsResponse data) => json.encode(data.toJson());

class TrendsResponse {
  String message;
  List<Trend> data;
  bool success;
  int code;

  TrendsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  TrendsResponse copyWith({
    String? message,
    List<Trend>? data,
    bool? success,
    int? code,
  }) =>
      TrendsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory TrendsResponse.fromJson(Map<String, dynamic> json) => TrendsResponse(
        message: json["message"],
        data: List<Trend>.from(json["data"].map((x) => Trend.fromJson(x))),
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

class Trend {
  dynamic id;
  dynamic tag;
  dynamic count;
  DateTime createdAt;

  Trend({
    required this.id,
    required this.tag,
    required this.count,
    required this.createdAt,
  });

  Trend copyWith({
    dynamic id,
    String? tag,
    String? count,
    DateTime? createdAt,
  }) =>
      Trend(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        count: count ?? this.count,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
        id: json["id"],
        tag: json["tag"],
        count: json["count"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
        "count": count,
        "created_at": createdAt.toIso8601String(),
      };
}
