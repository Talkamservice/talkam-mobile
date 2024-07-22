// To parse this JSON data, do
//
//     final getPollsResponse = getPollsResponseFromJson(jsonString);

import 'dart:convert';

GetPollsResponse getPollsResponseFromJson(String str) => GetPollsResponse.fromJson(json.decode(str));

String getPollsResponseToJson(GetPollsResponse data) => json.encode(data.toJson());

class GetPollsResponse {
  String message;
  List<Datum> data;
  bool success;
  int code;

  GetPollsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetPollsResponse copyWith({
    String? message,
    List<Datum>? data,
    bool? success,
    int? code,
  }) =>
      GetPollsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetPollsResponse.fromJson(Map<String, dynamic> json) => GetPollsResponse(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  int id;
  String option;
  String type;
  bool selected;
  DateTime createdAt;

  Datum({
    required this.id,
    required this.option,
    required this.type,
    required this.selected,
    required this.createdAt,
  });

  Datum copyWith({
    int? id,
    String? option,
    String? type,
    bool? selected,
    DateTime? createdAt,
  }) =>
      Datum(
        id: id ?? this.id,
        option: option ?? this.option,
        type: type ?? this.type,
        selected: selected ?? this.selected,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
