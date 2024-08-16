// To parse this JSON data, do
//
//     final updateGroupPayload = updateGroupPayloadFromJson(jsonString);

import 'dart:convert';

UpdateGroupPayload updateGroupPayloadFromJson(String str) => UpdateGroupPayload.fromJson(json.decode(str));

String updateGroupPayloadToJson(UpdateGroupPayload data) => json.encode(data.toJson());

class UpdateGroupPayload {
  int categoryId;
  String name;
  String description;
  String about;
  int canPost;
  String image;
  List<String> tags;
  String groupAccess;

  UpdateGroupPayload({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.about,
    required this.canPost,
    required this.image,
    required this.tags,
    required this.groupAccess,
  });

  UpdateGroupPayload copyWith({
    int? categoryId,
    String? name,
    String? description,
    String? about,
    int? canPost,
    String? image,
    List<String>? tags,
    String? groupAccess,
  }) =>
      UpdateGroupPayload(
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        description: description ?? this.description,
        about: about ?? this.about,
        canPost: canPost ?? this.canPost,
        image: image ?? this.image,
        tags: tags ?? this.tags,
        groupAccess: groupAccess ?? this.groupAccess,
      );

  factory UpdateGroupPayload.fromJson(Map<String, dynamic> json) => UpdateGroupPayload(
    categoryId: json["category_id"],
    name: json["name"],
    description: json["description"],
    about: json["about"],
    canPost: json["can_post"],
    image: json["image"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    groupAccess: json["group_access"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
    "description": description,
    "about": about,
    "can_post": canPost,
    "image": image,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "group_access": groupAccess,
  };
}
