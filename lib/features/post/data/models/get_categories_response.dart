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
  dynamic name;
  dynamic followersCount;
  dynamic description;
  dynamic backgroundImage;
  dynamic? iconImage;
  dynamic isFollowing;
  DateTime? createdAt;
  DateTime? updatedAt;
  ParentCategory? parentCategory;

  String get postCategoryImage => iconImage ?? backgroundImage;

  PostCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.backgroundImage,
    required this.followersCount,
    required this.iconImage,
    required this.createdAt,
    required this.updatedAt,
    required this.parentCategory,
    required this.isFollowing,
  });

  PostCategory copyWith({
    int? id,
    int? followersCount,
    String? name,
    String? description,
    String? backgroundImage,
    String? iconImage,
    DateTime? createdAt,
    bool? isFollowing,
    DateTime? updatedAt,
    ParentCategory? parentCategory,
  }) =>
      PostCategory(
        id: id ?? this.id,
        followersCount: followersCount ?? this.followersCount,
        name: name ?? this.name,
        isFollowing: isFollowing ?? this.isFollowing,
        description: description ?? this.description,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        iconImage: iconImage ?? this.iconImage,
        createdAt: createdAt ?? this.createdAt,
        parentCategory: parentCategory ?? this.parentCategory,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        followersCount: json["followers_count"],
        backgroundImage: json["background_image"],
        iconImage: json["icon_image"],
        isFollowing: json["is_following"],
        parentCategory: json["parent_category"] == null ? null: ParentCategory.fromJson(json["parent_category"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "background_image": backgroundImage,
        "icon_image": iconImage,
        "is_following": isFollowing,
        "followers_count": followersCount,
        "parent_category": parentCategory?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return name;
  }
}

class ParentCategory {
  String name;
  String description;

  ParentCategory({
    required this.name,
    required this.description,
  });

  ParentCategory copyWith({
    String? name,
    String? description,
  }) =>
      ParentCategory(
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory ParentCategory.fromJson(Map<String, dynamic> json) => ParentCategory(
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };
}
