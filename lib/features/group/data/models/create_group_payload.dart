// To parse this JSON data, do
//
//     final createGroupPayload = createGroupPayloadFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

CreateGroupPayload createGroupPayloadFromJson(String str) => CreateGroupPayload.fromJson(json.decode(str));

String createGroupPayloadToJson(CreateGroupPayload data) => json.encode(data.toJson());

class CreateGroupPayload {
  int categoryId;
  String categoryName;
  String categoryImage;
  String name;
  String description;
  String about;
  String status;
  int canPost;
  String image;
  String rulesSummary;
  List<String> tags;
  String groupAccess;
  List<GuidelinePayload> guidelines;

  CreateGroupPayload({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.about,
    required this.status,
    required this.canPost,
    required this.image,
    required this.rulesSummary,
    required this.tags,
    required this.groupAccess,
    required this.categoryImage,
    required this.categoryName,
    required this.guidelines,
  });

  CreateGroupPayload copyWith({
    int? categoryId,
    String? name,
    String? description,
    String? about,
    String? status,
    int? canPost,
    String? image,
    String? rulesSummary,
    String? categoryName,
    String? categoryImage,
    List<String>? tags,
    String? groupAccess,
    List<GuidelinePayload>? guidelines,
  }) =>
      CreateGroupPayload(
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        description: description ?? this.description,
        about: about ?? this.about,
        status: status ?? this.status,
        canPost: canPost ?? this.canPost,
        image: image ?? this.image,
        rulesSummary: rulesSummary ?? this.rulesSummary,
        tags: tags ?? this.tags,
        groupAccess: groupAccess ?? this.groupAccess,
        categoryName: categoryName ?? this.categoryName,
        categoryImage: categoryImage ?? this.categoryImage,
        guidelines: guidelines ?? this.guidelines,
      );

  factory CreateGroupPayload.fromJson(Map<String, dynamic> json) => CreateGroupPayload(
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        about: json["about"],
        status: json["status"],
        canPost: json["can_post"],
        image: json["image"],
        rulesSummary: json["rules_summary"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        groupAccess: json["group_access"],
        guidelines: List<GuidelinePayload>.from(json["guidelines"].map((x) => GuidelinePayload.fromJson(x))),
        categoryImage: '',
        categoryName: '',
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "name": name,
        "description": description,
        "about": about,
        "status": status,
        "can_post": canPost,
        "image": image,
        "rules_summary": rulesSummary,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "group_access": groupAccess,
        if (guidelines.isNotEmpty) "guidelines": List<dynamic>.from(guidelines.map((x) => x.toJson())),
      };

  factory CreateGroupPayload.empty() => CreateGroupPayload(
      categoryId: 2,
      name: "",
      description: "",
      about: "",
      status: "",
      canPost: 0,
      image: "",
      rulesSummary: "",
      tags: [],
      groupAccess: "Open",
      guidelines: [],
      categoryImage: '',
      categoryName: '');

  GroupMembersTabData toGroupMembersData() {
    var me = injector.get<ProfileBloc>().appUser!;
    TalkamGroupMemberInfo owner = TalkamGroupMemberInfo(id: me.id, username: me.username, email: me.email, avatar: me.avatar, name: me.name, role: "Owner");

    return GroupMembersTabData(
      admin: [],
      members: [],
      owner: [owner],
      groupId: '0001',
      iPreview: false, // Assuming owner is also an admin here
    );
  }

  GroupOverViewData toGroupOverView() {
    var me = injector.get<ProfileBloc>().appUser!;
    GroupOwner creator = GroupOwner(id: me.id, username: me.username, name: me.name, avatar: me.avatar, email: me.email);
    return GroupOverViewData(
      id: "dummy_id",
      name: name,
      status: "active",
      category: PostCategory(
          id: 1,
          name: categoryName,
          description: 'FD',
          backgroundImage: null,
          followersCount: null,
          iconImage: categoryImage,
          createdAt: null,
          updatedAt: null,
          isFollowing: false,
          parentCategory: null,
          type: "Catgory", isSuspended: null, groupAccess: ''),
      owner: creator,
      about: about,
      totalMembers: 1,
    );
  }

  GroupAboutData toGroupAboutData() {
    var me = injector.get<ProfileBloc>().appUser!;
    GroupOwner creator = GroupOwner(id: me.id, username: me.username, name: me.name, avatar: me.avatar, email: me.email);

    return GroupAboutData(
      about: about,
      creator: creator,
      isPublic: groupAccess.toLowerCase() == "opened",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      accesibility: "Anyone can join",
    );
  }
}

class GuidelinePayload {
  String title;
  String description;

  GuidelinePayload({
    required this.title,
    required this.description,
  });

  GuidelinePayload copyWith({
    String? title,
    String? description,
  }) =>
      GuidelinePayload(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory GuidelinePayload.fromJson(Map<String, dynamic> json) => GuidelinePayload(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
