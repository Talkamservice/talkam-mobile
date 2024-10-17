// To parse this JSON data, do
//
//     final getStatesResponse = getStatesResponseFromJson(jsonString);

import 'dart:convert';

GetStatesResponse getStatesResponseFromJson(String str) => GetStatesResponse.fromJson(json.decode(str));

String getStatesResponseToJson(GetStatesResponse data) => json.encode(data.toJson());

class GetStatesResponse {
  String message;
  List<TalkamState> data;
  bool success;
  int code;

  GetStatesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetStatesResponse copyWith({
    String? message,
    List<TalkamState>? data,
    bool? success,
    int? code,
  }) =>
      GetStatesResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetStatesResponse.fromJson(Map<String, dynamic> json) => GetStatesResponse(
    message: json["message"],
    data: List<TalkamState>.from(json["data"].map((x) => TalkamState.fromJson(x))),
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

class TalkamState {
  int id;
  String name;
  dynamic countryId;

  TalkamState({
    required this.id,
    required this.name,
    required this.countryId,
  });

  TalkamState copyWith({
    int? id,
    String? name,
    int? countryId,
  }) =>
      TalkamState(
        id: id ?? this.id,
        name: name ?? this.name,
        countryId: countryId ?? this.countryId,
      );

  factory TalkamState.fromJson(Map<String, dynamic> json) => TalkamState(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
  };
}
