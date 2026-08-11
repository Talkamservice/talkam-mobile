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
  dynamic id;
  dynamic name;
  dynamic uuid;
  dynamic followersCount;
  dynamic description;
  dynamic backgroundImage;
  dynamic? iconImage;
  dynamic isFollowing;
  bool? isSuspended;
  final String? groupAccess;
  dynamic type;
  DateTime? createdAt;
  DateTime? updatedAt;
  ParentCategory? parentCategory;
  List<TrendingTag> trendingTags;

  String get postCategoryImage => iconImage ?? backgroundImage;

  PostCategory({
    required this.id,
    required this.name,
    required this.uuid,
    required this.description,
    required this.backgroundImage,
    required this.followersCount,
    required this.iconImage,
    required this.createdAt,
    required this.updatedAt,
    required this.parentCategory,
    required this.type,
    required this.isFollowing,
    required this.isSuspended,
    required this.groupAccess,
    this.trendingTags = const [],
  });

  PostCategory copyWith({
    int? id,
    int? followersCount,
    String? name,
    String? uuid,
    String? description,
    String? backgroundImage,
    String? type,
    String? iconImage,
    DateTime? createdAt,
    bool? isFollowing,
    String? groupAccess,
    bool? isSuspended,
    DateTime? updatedAt,
    ParentCategory? parentCategory,
    List<TrendingTag>? trendingTags,
  }) =>
      PostCategory(
        id: id ?? this.id,
        followersCount: followersCount ?? this.followersCount,
        name: name ?? this.name,
        uuid: uuid ?? this.uuid,
        isFollowing: isFollowing ?? this.isFollowing,
        groupAccess: groupAccess ?? this.groupAccess,
        isSuspended: isSuspended ?? this.isSuspended,
        description: description ?? this.description,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        iconImage: iconImage ?? this.iconImage,
        createdAt: createdAt ?? this.createdAt,
        type: type ?? this.type,
        parentCategory: parentCategory ?? this.parentCategory,
        updatedAt: updatedAt ?? this.updatedAt,
        trendingTags: trendingTags ?? this.trendingTags,
      );

  factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        id: json["id"],
        name: json["name"],
        uuid: json["uuid"],
        groupAccess: json['group_access'],
        description: json["description"],
        isSuspended: json['is_suspended'],
        followersCount: json["followers_count"],
        backgroundImage: json["background_image"],
        type: json["type"],
        iconImage: json["icon_image"],
        isFollowing: json["is_following"],
        parentCategory: json["parent_category"] == null
            ? null
            : ParentCategory.fromJson(json["parent_category"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        trendingTags: json["trending_tags"] == null
            ? []
            : List<TrendingTag>.from(
                json["trending_tags"].map((x) => TrendingTag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "uuid": uuid,
        "description": description,
        "background_image": backgroundImage,
        "icon_image": iconImage,
        "is_following": isFollowing,
        "is_suspended": isSuspended,
        "group_access": groupAccess,
        "type": type,
        "followers_count": followersCount,
        "parent_category": parentCategory?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "trending_tags":
            List<dynamic>.from(trendingTags.map((x) => x.toJson())),
      };

  bool get isPublic => groupAccess == null || groupAccess == "Opened";

  @override
  String toString() {
    return name;
  }
}

class TrendingTag {
  int id;
  String tag;
  int count;
  DateTime? createdAt;

  TrendingTag({
    required this.id,
    required this.tag,
    required this.count,
    required this.createdAt,
  });

  TrendingTag copyWith({
    int? id,
    String? tag,
    int? count,
    DateTime? createdAt,
  }) =>
      TrendingTag(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        count: count ?? this.count,
        createdAt: createdAt ?? this.createdAt,
      );

  factory TrendingTag.fromJson(Map<String, dynamic> json) => TrendingTag(
        id: json["id"],
        tag: json["tag"],
        count: json["count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
        "count": count,
        "created_at": createdAt?.toIso8601String(),
      };
}

class ParentCategory {
  String name;
  dynamic description;

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
