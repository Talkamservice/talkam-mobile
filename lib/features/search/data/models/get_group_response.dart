class GetGroupsResponse {
  final PaginationMeta? paginationMeta;
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
          ? PaginationMeta.fromJson(json['data']['pagination_meta'])
          : null,
      groups: groups,
      success: json['success'],
      code: json['code'],
    );
  }
}

class PaginationMeta {
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

  PaginationMeta({
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

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
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

class GroupCategory {
  final int? id;
  final String? name;
  final String? description;
  final String? backgroundImage;
  final String? iconImage;
  final bool? isFollowing;
  final int? followersCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupCategory({
    this.id,
    this.name,
    this.description,
    this.backgroundImage,
    this.iconImage,
    this.isFollowing,
    this.followersCount,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupCategory.fromJson(Map<String, dynamic> json) {
    return GroupCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      backgroundImage: json['background_image'],
      iconImage: json['icon_image'],
      isFollowing: json['is_following'],
      followersCount: json['followers_count'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
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
}

class TalkamGroup {
  final int? id;
  final String? name;
  final String? uuid;
  final String? status;
  final String? groupAccess;
  final String? image;
  final bool? isFollowing;
  final int? totalMembers;
  final GroupCategory? category;
  final List<GroupGuideline>? guidelines;
  final String? description;
  final GroupOwner? owner;
  final String? about;

  TalkamGroup({
    this.id,
    this.name,
    this.uuid,
    this.status,
    this.groupAccess,
    this.image,
    this.isFollowing,
    this.totalMembers,
    this.category,
    this.guidelines,
    this.description,
    this.owner,
    this.about,
  });

  factory TalkamGroup.fromJson(Map<String, dynamic> json) {
    var guidelinesList = json['guidelines'] as List?;
    List<GroupGuideline>? guidelines =
        guidelinesList?.map((i) => GroupGuideline.fromJson(i)).toList();

    return TalkamGroup(
      id: json['id'],
      name: json['name'],
      uuid: json['uuid'],
      status: json['status'],
      groupAccess: json['group_access'],
      image: json['image'],
      isFollowing: json['is_following'],
      totalMembers: json['total_members'],
      category: json['category'] != null
          ? GroupCategory.fromJson(json['category'])
          : null,
      guidelines: guidelines,
      description: json['description'],
      owner: json['owner'] != null ? GroupOwner.fromJson(json['owner']) : null,
      about: json['about'],
    );
  }
}
