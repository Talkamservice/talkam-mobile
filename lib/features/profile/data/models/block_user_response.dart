// To parse this JSON data, do
//
//     final blockUserResponse = blockUserResponseFromJson(jsonString);

import 'dart:convert';

BlockUserResponse blockUserResponseFromJson(String str) => BlockUserResponse.fromJson(json.decode(str));

String blockUserResponseToJson(BlockUserResponse data) => json.encode(data.toJson());

class BlockUserResponse {
  String message;
  Data data;
  bool success;
  int code;

  BlockUserResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  BlockUserResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      BlockUserResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory BlockUserResponse.fromJson(Map<String, dynamic> json) => BlockUserResponse(
    message: json["message"],
    data: Data.fromJson(json["data"]),
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

class Data {
  bool isBlocked;

  Data({
    required this.isBlocked,
  });

  Data copyWith({
    bool? isBlocked,
  }) =>
      Data(
        isBlocked: isBlocked ?? this.isBlocked,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isBlocked: json["is_blocked"],
  );

  Map<String, dynamic> toJson() => {
    "is_blocked": isBlocked,
  };
}
