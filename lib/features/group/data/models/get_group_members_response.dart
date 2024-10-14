// To parse this JSON data, do
//
//     final getGroupMembersResponse = getGroupMembersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/search/data/models/get_group_response.dart';

GetGroupMembersResponse getGroupMembersResponseFromJson(String str) =>
    GetGroupMembersResponse.fromJson(json.decode(str));

String getGroupMembersResponseToJson(GetGroupMembersResponse data) =>
    json.encode(data.toJson());

class GetGroupMembersResponse {
  String message;
  Data data;
  bool success;
  int code;

  GetGroupMembersResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetGroupMembersResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      GetGroupMembersResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetGroupMembersResponse.fromJson(Map<String, dynamic> json) =>
      GetGroupMembersResponse(
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
  List<GroupMemberDetails> owner;
  List<GroupMemberDetails> admin;
  List<GroupMemberDetails> member;

  Data({
    required this.owner,
    required this.admin,
    required this.member,
  });

  Data copyWith({
    List<GroupMemberDetails>? owner,
    List<GroupMemberDetails>? admin,
    List<GroupMemberDetails>? member,
  }) =>
      Data(
        owner: owner ?? this.owner,
        admin: admin ?? this.admin,
        member: member ?? this.member,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        owner: List<GroupMemberDetails>.from(
            json["Owner"].map((x) => GroupMemberDetails.fromJson(x))),
        admin: List<GroupMemberDetails>.from(
            json["Admin"].map((x) => GroupMemberDetails.fromJson(x))),
        member: List<GroupMemberDetails>.from(
            json["Member"].map((x) => GroupMemberDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Owner": List<dynamic>.from(owner.map((x) => x)),
        "Admin": List<dynamic>.from(admin.map((x) => x)),
        "Member": List<dynamic>.from(member.map((x) => x.toJson())),
      };
}

class GroupMemberDetails {
  int id;
  String role;
  bool isSuspended;
  bool isBanned;
  String status;
  TalkamGroupPreview? group;
  GroupUser user;
  DateTime createdAt;
  DateTime updatedAt;

  GroupMemberDetails({
    required this.id,
    required this.role,
    required this.status,
    required this.isSuspended,
    required this.isBanned,
     this.group,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  GroupMemberDetails copyWith({
    int? id,
    String? role,
    String? status,
    bool? isSuspended,
    bool? isBanned,
    TalkamGroupPreview? group,
    GroupUser? user,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      GroupMemberDetails(
        id: id ?? this.id,
        role: role ?? this.role,
        status: status ?? this.status,
        isSuspended: isSuspended ?? this.isSuspended,
        isBanned: isBanned ?? this.isBanned,
        group: group ?? this.group,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory GroupMemberDetails.fromJson(Map<String, dynamic> json) =>
      GroupMemberDetails(
        id: json["id"],
        role: json["role"],
        status: json["status"],
        isBanned: json["is_banned"],
        isSuspended: json["is_suspended"],
        group: TalkamGroupPreview.fromJson(json["group"]),
        user: GroupUser.fromJson(json["user"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "status": status,
        "is_suspended": isSuspended,
        "is_suspended": isSuspended,
        "is_banned": isBanned,
        "group": group?.toJson(),
        "user": user.toString(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  // TalkamGroupMemberInfo toTalkamGroupMemberInfo() {
  //   return TalkamGroupMemberInfo(
  //       email: user.email,
  //       avatar: user.avatar,
  //       createdAt: createdAt,
  //       updatedAt: updatedAt,
  //       id: user.id,
  //       role: role,
  //       username: user.username,
  //       name: user.name);
  // }
}

class TalkamGroupPreview {
  int id;
  String name;
  String uuid;
  String status;
  String image;

  TalkamGroupPreview({
    required this.id,
    required this.name,
    required this.uuid,
    required this.status,
    required this.image,
  });

  TalkamGroupPreview copyWith({
    int? id,
    String? name,
    String? uuid,
    String? status,
    String? image,
  }) =>
      TalkamGroupPreview(
        id: id ?? this.id,
        name: name ?? this.name,
        uuid: uuid ?? this.uuid,
        status: status ?? this.status,
        image: image ?? this.image,
      );

  factory TalkamGroupPreview.fromJson(Map<String, dynamic> json) =>
      TalkamGroupPreview(
        id: json["id"],
        name: json["name"],
        uuid: json["uuid"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "uuid": uuid,
        "status": status,
        "image": image,
      };
}

class GroupUser {
  final int? id;
  final String? avatar;
  final String? name;
  final String? username;
  final String? email;

  GroupUser({
    this.id,
    this.avatar,
    this.name,
    this.username,
    this.email,
  });

  factory GroupUser.fromJson(Map<String, dynamic> json) {
    return GroupUser(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}
