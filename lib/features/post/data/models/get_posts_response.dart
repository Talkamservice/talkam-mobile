// To parse this JSON data, do
//
//     final getPostsResponse = getPostsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';

GetPostsResponse getPostsResponseFromJson(String str) =>
    GetPostsResponse.fromJson(json.decode(str));

String getPostsResponseToJson(GetPostsResponse data) =>
    json.encode(data.toJson());

class GetPostsResponse {
  String message;
  Data data;
  bool success;
  int code;

  GetPostsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetPostsResponse copyWith({
    String? message,
    Data? data,
    bool? success,
    int? code,
  }) =>
      GetPostsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetPostsResponse.fromJson(Map<String, dynamic> json) =>
      GetPostsResponse(
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
  PaginationMeta paginationMeta;
  List<TalkamPost> data;

  Data({
    required this.paginationMeta,
    required this.data,
  });

  Data copyWith({
    PaginationMeta? paginationMeta,
    List<TalkamPost>? data,
  }) =>
      Data(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paginationMeta: PaginationMeta.fromJson(json["pagination_meta"]),
        data: List<TalkamPost>.from(
            json["data"].map((x) => TalkamPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination_meta": paginationMeta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TalkamPost {
  int id;
  dynamic title;
  String? body;
  dynamic type;
  bool? isReported;
  dynamic uuid;
  PostCategory category;
  PostCreator user;
  int canComment;
  int isAnonymous;
  List<String> tags;
  int viewsCount;
  int commentsCount;
  int likesCount;
  String status;
  dynamic publishAt;
  List<Attachment?> attachments;
  List<TalkamPoll> polls;
  PostReaction? reaction;
  DateTime createdAt;
  DateTime updatedAt;

  bool get isSchedulePost => publishAt != null;

  TalkamPost({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.isReported,
    required this.uuid,
    required this.category,
    required this.user,
    required this.canComment,
    required this.isAnonymous,
    required this.tags,
    required this.viewsCount,
    required this.commentsCount,
    required this.likesCount,
    required this.status,
    required this.publishAt,
    required this.attachments,
    required this.polls,
    required this.reaction,
    required this.createdAt,
    required this.updatedAt,
  });

  TalkamPost copyWith({
    int? id,
    String? title,
    String? body,
    String? type,
    bool? isReported,
    String? uuid,
    PostCategory? category,
    PostCreator? user,
    int? canComment,
    int? isAnonymous,
    List<String>? tags,
    int? viewsCount,
    int? commentsCount,
    int? likesCount,
    String? status,
    dynamic publishAt,
    List<Attachment?>? attachments,
    List<TalkamPoll>? polls,
    PostReaction? reaction,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TalkamPost(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        isReported: isReported ?? this.isReported,
        type: type ?? this.type,
        uuid: uuid ?? this.uuid,
        category: category ?? this.category,
        user: user ?? this.user,
        canComment: canComment ?? this.canComment,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        tags: tags ?? this.tags,
        viewsCount: viewsCount ?? this.viewsCount,
        commentsCount: commentsCount ?? this.commentsCount,
        likesCount: likesCount ?? this.likesCount,
        status: status ?? this.status,
        publishAt: publishAt ?? this.publishAt,
        attachments: attachments ?? this.attachments,
        polls: polls ?? this.polls,
        reaction: reaction ?? this.reaction,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TalkamPost.fromJson(Map<String, dynamic> json) => TalkamPost(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        type: json["type"],
        uuid: json["uuid"],
        isReported: json["is_reported"],
        category: PostCategory.fromJson(json["category"]),
        user: PostCreator.fromJson(json["user"]),
        canComment: json["can_comment"],
        isAnonymous: json["is_anonymous"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        viewsCount: json["views_count"],
        commentsCount: json["comments_count"],
        likesCount: json["likes_count"],
        status: json["status"],
        publishAt: json["publish_at"] != null
            ? DateTime.parse(json["publish_at"])
            : null,
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        polls: List<TalkamPoll>.from(
            json["polls"].map((x) => TalkamPoll.fromJson(x))),
        reaction: json["reaction"] == null
            ? null
            : PostReaction.fromJson(json["reaction"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "type": type,
        "uuid": uuid,
        "is_reported": isReported,
        "category": category.toJson(),
        "user": user.toJson(),
        "can_comment": canComment,
        "is_anonymous": isAnonymous,
        "tags": tags.isEmpty ? [] : List<String>.from(tags.map((x) => x)),
        "views_count": viewsCount,
        "comments_count": commentsCount,
        "likes_count": likesCount,
        "status": status,
        "publish_at": publishAt,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "polls": List<dynamic>.from(polls.map((x) => x.toJson())),
        "reaction": reaction?.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class TalkamPoll {
  int id;
  String option;
  String type;
  int? duration;
  bool selected;
  int count;
  int percentage;
  dynamic anonymous;
  DateTime expiresAt;
  DateTime createdAt;

  TalkamPoll({
    required this.id,
    required this.option,
    required this.type,
    required this.duration,
    required this.selected,
    required this.count,
    required this.percentage,
    required this.anonymous,
    required this.expiresAt,
    required this.createdAt,
  });

  TalkamPoll copyWith({
    int? id,
    String? option,
    String? type,
    int? duration,
    bool? selected,
    int? count,
    int? percentage,
    dynamic anonymous,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) =>
      TalkamPoll(
        id: id ?? this.id,
        option: option ?? this.option,
        type: type ?? this.type,
        duration: duration ?? this.duration,
        selected: selected ?? this.selected,
        count: count ?? this.count,
        percentage: percentage ?? this.percentage,
        anonymous: anonymous ?? this.anonymous,
        expiresAt: expiresAt ?? this.expiresAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory TalkamPoll.fromJson(Map<String, dynamic> json) => TalkamPoll(
        id: json["id"],
        option: json["option"],
        type: json["type"],
        duration: json["duration"],
        selected: json["selected"],
        count: json["count"],
        percentage: json["percentage"],
        anonymous: json["anonymous"],
        expiresAt: DateTime.parse(json["expires_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "option": option,
        "type": type,
        "duration": duration,
        "selected": selected,
        "count": count,
        "percentage": percentage,
        "anonymous": anonymous,
        "expires_at": expiresAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };

  bool get isActive => DateTime.now().difference(expiresAt).inMinutes > 1;
}

class PostReaction {
  int id;
  String action;
  bool status;
  DateTime createdAt;

  PostReaction({
    required this.id,
    required this.action,
    required this.status,
    required this.createdAt,
  });

  PostReaction copyWith({
    int? id,
    String? action,
    bool? status,
    DateTime? createdAt,
  }) =>
      PostReaction(
        id: id ?? this.id,
        action: action ?? this.action,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  factory PostReaction.fromJson(Map<String, dynamic> json) => PostReaction(
        id: json["id"],
        action: json["action"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  bool get isLike => action == 'Like' && status;

  bool get isDisLike => action == 'Dislike' && status;

  factory PostReaction.like() => PostReaction(
      id: 0, action: "Like", createdAt: DateTime.now(), status: true);

  factory PostReaction.removed() => PostReaction(
      id: 0, action: "Like", createdAt: DateTime.now(), status: false);

  factory PostReaction.dislike() => PostReaction(
      id: 0, action: "Dislike", createdAt: DateTime.now(), status: true);

  Map<String, dynamic> toJson() => {
        "id": id,
        "action": action,
        "created_at": createdAt.toIso8601String(),
      };
}

class PostCreator {
  int id;
  String? avatar;
  String name;
  String? username;
  String email;

  PostCreator({
    required this.id,
    required this.avatar,
    required this.name,
    required this.username,
    required this.email,
  });

  PostCreator copyWith({
    int? id,
    String? avatar,
    String? name,
    String? username,
    String? email,
  }) =>
      PostCreator(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory PostCreator.fromJson(Map<String, dynamic> json) => PostCreator(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "username": username,
        "email": email,
      };

  String get usersName => name.isNotEmpty ? name : (username ?? email);
}

class PaginationMeta {
  dynamic currentPage;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  dynamic nextPageUrl;
  String path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;
  dynamic canLoadMore;

  PaginationMeta({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.canLoadMore,
  });

  PaginationMeta copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
    bool? canLoadMore,
  }) =>
      PaginationMeta(
        currentPage: currentPage ?? this.currentPage,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
        currentPage: json["current_page"],
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
        canLoadMore: json["can_load_more"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
        "can_load_more": canLoadMore,
      };
}
