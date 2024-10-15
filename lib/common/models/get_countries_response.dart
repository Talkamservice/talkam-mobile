// To parse this JSON data, do
//
//     final getCountriesResponse = getCountriesResponseFromJson(jsonString);

import 'dart:convert';

GetCountriesResponse getCountriesResponseFromJson(String str) => GetCountriesResponse.fromJson(json.decode(str));

String getCountriesResponseToJson(GetCountriesResponse data) => json.encode(data.toJson());

class GetCountriesResponse {
  String message;
  List<TalkamCountry> data;
  bool success;
  int code;

  GetCountriesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetCountriesResponse copyWith({
    String? message,
    List<TalkamCountry>? data,
    bool? success,
    int? code,
  }) =>
      GetCountriesResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetCountriesResponse.fromJson(Map<String, dynamic> json) => GetCountriesResponse(
    message: json["message"],
    data: List<TalkamCountry>.from(json["data"].map((x) => TalkamCountry.fromJson(x))),
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

class TalkamCountry {
  int id;
  String name;

  TalkamCountry({
    required this.id,
    required this.name,
  });

  TalkamCountry copyWith({
    int? id,
    String? name,
  }) =>
      TalkamCountry(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory TalkamCountry.fromJson(Map<String, dynamic> json) => TalkamCountry(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
