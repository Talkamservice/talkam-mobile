// To parse this JSON data, do
//
//     final searchUserResponse = searchUserResponseFromJson(jsonString);

import 'dart:convert';

SearchUserResponse searchUserResponseFromJson(String str) => SearchUserResponse.fromJson(json.decode(str));

String searchUserResponseToJson(SearchUserResponse data) => json.encode(data.toJson());

class SearchUserResponse {
  String msg;
  List<SearchedUser> data;
  bool success;
  int code;

  SearchUserResponse({
    required this.msg,
    required this.data,
    required this.success,
    required this.code,
  });

  SearchUserResponse copyWith({
    String? msg,
    List<SearchedUser>? data,
    bool? success,
    int? code,
  }) =>
      SearchUserResponse(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory SearchUserResponse.fromJson(Map<String, dynamic> json) => SearchUserResponse(
    msg: json["msg"],
    data: List<SearchedUser>.from(json["data"].map((x) => SearchedUser.fromJson(x))),
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "code": code,
  };
}

class SearchedUser {
  int id;
  dynamic email;
  dynamic name;
  dynamic avatar;
  dynamic lastName;
  dynamic username;


  SearchedUser({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.lastName,
    required this.username,
  });

  SearchedUser copyWith({
    int? id,
    String? email,
    String? name,
    String? avatar,
    String? lastName,
    String? username,
  }) =>
      SearchedUser(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        avatar: avatar ?? this.name,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
      );

  factory SearchedUser.fromJson(Map<String, dynamic> json) => SearchedUser(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    avatar: json["avatar"],
    lastName: json["last_name"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "avatar": avatar,
    "last_name": lastName,
    "username": username,
  };
}
