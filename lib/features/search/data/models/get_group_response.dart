import 'dart:convert';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/ads/data/models/promotion_data.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class GetGroupsResponse {
  final GroupPaginationMeta? paginationMeta;
  final List<TalkamGroup>? groups;
  final bool? success;
  final int? code;

  GetGroupsResponse({
    this.paginationMeta,
    this.groups,
    this.success,
    this.code,
  });

  factory GetGroupsResponse.fromJson(Map<String, dynamic> json) {
    var groupList = json['data']["data"] as List?;
    List<TalkamGroup>? groups =
    groupList?.map((i) => TalkamGroup.fromJson(i)).toList();

    return GetGroupsResponse(
      paginationMeta: json['data']['pagination_meta'] != null
          ? GroupPaginationMeta.fromJson(json['data']['pagination_meta'])
          : null,
      groups: groups,
      success: json['success'],
      code: json['code'],
    );
  }
}

class GroupPaginationMeta {
  final int? currentPage;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;
  final bool? canLoadMore;

  GroupPaginationMeta({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
    this.canLoadMore,
  });

  factory GroupPaginationMeta.fromJson(Map<String, dynamic> json) {
    return GroupPaginationMeta(
      currentPage: json['current_page'],
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
      canLoadMore: json['can_load_more'],
    );
  }
}

class GroupGuideline {
  final int? id;
  final String? title;
  final String? description;
  final String? status;
  final TalkamGroup? group;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupGuideline({
    this.id,
    this.title,
    this.description,
    this.status,
    this.group,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupGuideline.fromJson(Map<String, dynamic> json) {
    return GroupGuideline(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      group: json['group'] != null ? TalkamGroup.fromJson(json['group']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class TalkamGroup extends Codec<TalkamGroup, String> {
  final int? id;
  final String? name;
  final String? uuid;
  final String? userRole;
  final String? status;
  final String? groupAccess;
  final String? image;
  bool? isFollowing;
  bool? hasRequested;
  bool? isReported;
  bool? isSuspended;
  int? pendingCount;
  final int? totalMembers;
  final PostCategory? category;
  final bool? promotion;
  List<GroupGuideline>? guidelines;
  final String? description;
  final GroupOwner? owner;
  final String? about;
  final DateTime? createdAt; // New field
  final DateTime? updatedAt;

  TalkamGroup({
    this.id,
    this.name,
    this.uuid,
    this.status,
    this.groupAccess,
    this.image,
    this.isFollowing,
    this.hasRequested,
    this.isReported,
    this.isSuspended,
    this.totalMembers,
    this.category,
    this.promotion,
    this.guidelines,
    this.description,
    this.owner,
    this.about,
    this.userRole,
    this.pendingCount,
    this.createdAt,
    this.updatedAt,
  });

  factory TalkamGroup.fromJson(Map<String, dynamic> json) {
    var guidelinesList = json['guidelines'] as List?;
    List<GroupGuideline>? guidelines =
    guidelinesList?.map((i) => GroupGuideline.fromJson(i)).toList();

    return TalkamGroup(
      id: json['id'],
      name: json['name'],
      uuid: json['uuid'],
      userRole: json['user_role'],
      status: json['status'],
      groupAccess: json['group_access'],
      pendingCount: json['pending_count'],
      image: json['image'],
      isFollowing: json['is_following'],
      isSuspended: json['is_suspended'],
      isReported: json['is_reported'],
      hasRequested: json['has_requested'],
      totalMembers: json['total_members'],
      category: json['category'] != null
          ? PostCategory.fromJson(json['category'])
          : null,
      promotion: json['promotion'],
      guidelines: guidelines,
      description: json['description'],
      owner: json['owner'] != null ? GroupOwner.fromJson(json['owner']) : null,
      about: json['about'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  bool get isPromoted => promotion??false;


  // TalkamGroupMemberInfo toTalkamGroupMemberInfo() {
  //   return TalkamGroupMemberInfo(
  //       email: owner!.email,
  //       avatar: owner!.avatar,
  //       createdAt: createdAt,
  //       updatedAt: createdAt,
  //       id: owner!.id,
  //       role: "Owner",
  //       username: owner!.username,
  //       name: owner!.name);
  // }

  // GroupDetailsScreenParam toGroupDetailsScreenParam({bool isPreview = false}) {
  //   return GroupDetailsScreenParam(
  //     isPreview: isPreview,
  //     rulesData: toGroupGuidlineTabData(),
  //     membersData: toGroupMembersTabData(),
  //     // Assuming you have methods to fetch admins and members
  //     overview: toGroupOverViewData(),
  //     about: toGroupAboutData(),
  //   );
  // }

  GroupAppBarData toGroupAppBarData() {
    return GroupAppBarData(
      id: uuid ?? "",
      // Use uuid if available, otherwise an empty string
      isPreview: false,
      // You might need to set this based on your logic
      banner: image ?? Assets.images.jpegs.football.path,
      // Indicate presence of banner image
      name: name ?? "", // Use name if available, otherwise an empty string
    );
  }

  // GroupAboutData toGroupAboutData() {
  //   return GroupAboutData(
  //     about: about ?? "",
  //     // Use about if available, otherwise an empty string
  //     creator: owner ?? GroupOwner(username: "Unknown"),
  //     // Use owner if available, otherwise create a dummy member
  //     isPublic: groupAccess == "Opened",
  //     // Check if group access is public
  //     accesibility:
  //         groupAccess == "Opened" ? "Anyone can join" : "Approval required",
  //     createdAt: createdAt!,
  //     updatedAt: updatedAt, // Set accessibility based on groupAccess
  //   );
  // }
  //
  // GroupMembersTabData toGroupMembersTabData() {
  //   // Assuming there's a way to access group admins and members in your app
  //   List<TalkamGroupMemberInfo> admins =
  //       []; // Replace with actual admin retrieval logic
  //   List<TalkamGroupMemberInfo> members =
  //       []; // Replace with actual member retrieval logic
  //
  //   return GroupMembersTabData(
  //     admin: admins,
  //     members: members,
  //     owner: [],
  //     groupId: id.toString(),
  //     iPreview: false,
  //     // Use owner if available, otherwise create a dummy member
  //   );
  // }

  GroupGuidlineTabData toGroupGuidlineTabData() {
    String groupDescription = description ?? ""; // Use description if available
    List<String> guidelineTitles = [];
    List<String> guidelineDescriptions = [];

    if (guidelines != null) {
      for (GroupGuideline guideline in guidelines!) {
        guidelineTitles.add(guideline.title ?? ""); // Use title if available
        guidelineDescriptions
            .add(guideline.description ?? ""); // Use description if available
      }
    }

    return GroupGuidlineTabData(
      groupDescription: description,
      guidlines: guidelines ?? [],
    );
  }

  GroupOverViewData toGroupOverViewData() {
    return GroupOverViewData(
      id: uuid ?? "",
      // Use uuid if available, otherwise an empty string
      name: name ?? "",
      // Use name if available, otherwise an empty string
      status: status ?? "",
      // Use status if available, otherwise an empty string
      category: category!,
      // Use category if available, otherwise create a dummy category
      owner: owner ?? GroupOwner(username: "Unknown"),
      // Use owner if available, otherwise create a dummy member
      about: about ?? "",
      // Use about if available, otherwise an empty string
      totalMembers:
      totalMembers ?? 0, // Use totalMembers if available, otherwise 0
    );
  }

  bool get isPublic => groupAccess == null || groupAccess == "Opened";

  bool get isAdmin => (userRole == "Owner" || userRole == "Admin");
  bool get isOwner => (owner?.email == injector.get<ProfileBloc>().appUser?.email);

  @override
  // TODO: implement decoder
  Converter<String, TalkamGroup> get decoder => throw UnimplementedError();

  @override
  // TODO: implement encoder
  Converter<TalkamGroup, String> get encoder => throw UnimplementedError();
}

class GroupOwner {
  final int? id;
  final String? avatar;
  final String? name;
  final String? username;
  final String? email;

  GroupOwner({
    this.id,
    this.avatar,
    this.name,
    this.username,
    this.email,
  });

  factory GroupOwner.fromJson(Map<String, dynamic> json) {
    return GroupOwner(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  GroupMemberDetails toGroupMemberDetail() {
    return GroupMemberDetails(id: id!,
        role: "Owner",
        status: "Active",
        isSuspended: false,
        isBanned: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(), user: GroupUser(id: id,username: username,email: email,avatar: avatar,name: name));
  }
}

class TalkamGroupMemberInfo {
  final int? id;
  final String? avatar;
  final String? name;
  final String? username;
  final String? email;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TalkamGroupMemberInfo({
    this.id,
    this.avatar,
    this.name,
    this.username,
    this.role,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory TalkamGroupMemberInfo.fromJson(Map<String, dynamic> json) {
    return TalkamGroupMemberInfo(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      role: json['role'],
      username: json['username'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
