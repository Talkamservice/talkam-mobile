import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupOverViewData {
  final String? id;
  final String name;
  final String? status;
  final PostCategory category;
  final GroupOwner owner;
  final String about;
  final int totalMembers;

  GroupOverViewData(
      {this.id,
      required this.name,
      this.status,
      required this.category,
      required this.owner,
      required this.about,
      required this.totalMembers});
}

class GroupGuidlineTabData {
  final String? groupDescription;
  final List<GroupGuideline> guidlines;

  GroupGuidlineTabData({this.groupDescription, required this.guidlines});
}

class GroupMembersTabData {
  final List<dynamic> admin;
  final List<dynamic> members;
  final String groupId;
  final bool iPreview;

  GroupMembersTabData({
    required this.admin,
    required this.members,
    required this.owner,
    required this.groupId,
    required this.iPreview,
  });

  final List<TalkamGroupMemberInfo> owner;
}

class GroupAboutData {
  String about;
  GroupOwner creator;
  bool isPublic;
  String accesibility;
  DateTime createdAt;
  DateTime? updatedAt;

  GroupAboutData(
      {
      required this.about,
      required this.creator,
      required this.isPublic,
      required this.accesibility,
      required this.createdAt,
       this.updatedAt,
      });


}

class GroupAppBarData {
  final String id;
  final bool isPreview;
  final String banner;
  final String name;

  GroupAppBarData({
    required this.id,
    required this.isPreview,
    required this.banner,
    required this.name,
  });
}
