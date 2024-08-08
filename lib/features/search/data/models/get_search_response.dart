// To parse this JSON data, do
//
//     final getSearchResponse = getSearchResponseFromJson(jsonString);

import 'dart:convert';

GetSearchResponse getSearchResponseFromJson(String str) =>
    GetSearchResponse.fromJson(json.decode(str));

String getSearchResponseToJson(GetSearchResponse data) =>
    json.encode(data.toJson());

class GetSearchResponse {
  String message;
  List<SearchResponse> data;
  bool success;
  int code;

  GetSearchResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetSearchResponse copyWith({
    String? message,
    List<SearchResponse>? data,
    bool? success,
    int? code,
  }) =>
      GetSearchResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetSearchResponse.fromJson(Map<String, dynamic> json) =>
      GetSearchResponse(
        message: json["message"],
        data: List<SearchResponse>.from(
            json["data"].map((x) => SearchResponse.fromJson(x))),
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

class SearchResponse {
  dynamic id;
  String word;
  DateTime createdAt;
  DateTime updatedAt;

  SearchResponse({
    required this.id,
    required this.word,
    required this.createdAt,
    required this.updatedAt,
  });

  SearchResponse copyWith({
    int? id,
    String? word,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SearchResponse(
        id: id ?? this.id,
        word: word ?? this.word,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        id: json["id"],
        word: json["word"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "word": word,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
