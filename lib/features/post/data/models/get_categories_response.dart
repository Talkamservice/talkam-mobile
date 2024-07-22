// To parse this JSON data, do
//
//     final getCategoriesResponse = getCategoriesResponseFromJson(jsonString);

import 'dart:convert';

GetCategoriesResponse getCategoriesResponseFromJson(String str) =>
    GetCategoriesResponse.fromJson(json.decode(str));

String getCategoriesResponseToJson(GetCategoriesResponse data) =>
    json.encode(data.toJson());

class GetCategoriesResponse {
  String message;
  List<PostCategory> data;
  bool success;
  int code;

  GetCategoriesResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetCategoriesResponse copyWith({
    String? message,
    List<PostCategory>? data,
    bool? success,
    int? code,
  }) =>
      GetCategoriesResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      GetCategoriesResponse(
        message: json["message"],
        data: List<PostCategory>.from(
            json["data"].map((x) => PostCategory.fromJson(x))),
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

class PostCategory {
  int id;
  String name;
  String description;
  String backgroundImage;
  String? iconImage;
  DateTime createdAt;
  DateTime updatedAt;

  PostCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.backgroundImage,
    required this.iconImage,
    required this.createdAt,
    required this.updatedAt,
  });

  PostCategory copyWith({
    int? id,
    String? name,
    String? description,
    String? backgroundImage,
    String? iconImage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PostCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        iconImage: iconImage ?? this.iconImage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        backgroundImage: json["background_image"],
        iconImage: json["icon_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "background_image": backgroundImage,
        "icon_image": iconImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };


  @override
  String toString() {

    return name;
  }
}
