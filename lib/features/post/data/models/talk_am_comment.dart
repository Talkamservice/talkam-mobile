// To parse this JSON data, do
//
//     final talkAmComment = talkAmCommentFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';

TalkAmComment talkAmCommentFromJson(String str) =>
    TalkAmComment.fromJson(json.decode(str));

String talkAmCommentToJson(TalkAmComment data) => json.encode(data.toJson());

class TalkAmComment {
  dynamic id;
  Post? post;
  User user;
  dynamic comment;
  dynamic isAnonymous;
  dynamic likes;
  dynamic unlikes;
  dynamic isReported;
  User? replyTo;
  dynamic attachment;
  bool enabledNotification;
  dynamic reaction;
  List<dynamic> children;
  DateTime createdAt;
  DateTime updatedAt;

  TalkAmComment({
    required this.id,
    required this.post,
    required this.user,
    required this.comment,
    required this.isAnonymous,
    required this.likes,
    required this.unlikes,
    required this.isReported,
    required this.replyTo,
    required this.attachment,
    required this.enabledNotification,
    required this.reaction,
    required this.children,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isReplyingToComment => replyTo != null;

  String get commentReplyTo =>
      isReplyingToComment ? replyTo!.username : post?.title;

  TalkAmComment copyWith({
    int? id,
    Post? post,
    User? user,
    String? comment,
    int? isAnonymous,
    int? likes,
    int? unlikes,
    bool? isReported,
    dynamic replyTo,
    dynamic attachment,
    bool? enabledNotification,
    dynamic reaction,
    List<dynamic>? children,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TalkAmComment(
        id: id ?? this.id,
        post: post ?? this.post,
        user: user ?? this.user,
        comment: comment ?? this.comment,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        likes: likes ?? this.likes,
        unlikes: unlikes ?? this.unlikes,
        isReported: isReported ?? this.isReported,
        replyTo: replyTo ?? this.replyTo,
        attachment: attachment ?? this.attachment,
        enabledNotification: enabledNotification ?? this.enabledNotification,
        reaction: reaction ?? this.reaction,
        children: children ?? this.children,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TalkAmComment.fromJson(Map<String, dynamic> json) => TalkAmComment(
        id: json["id"],
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
        user: json["user"] == null
            ? User.anonymous()
            : User.fromJson(json["user"]),
        comment: json["comment"] ?? '',
        isAnonymous: json["is_anonymous"],
        likes: json["likes"],
        unlikes: json["unlikes"],
        isReported: json["is_reported"],
        replyTo:
            json["reply_to"] == null ? null : User.fromJson(json["reply_to"]),
        attachment: json["attachment"],
        enabledNotification: json["enabled_notification"],
        reaction: json["reaction"],
        children: json["children"] == null
            ? []
            : List<dynamic>.from(json["children"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post": post?.toJson(),
        "user": user.toJson(),
        "comment": comment,
        "is_anonymous": isAnonymous,
        "likes": likes,
        "unlikes": unlikes,
        "is_reported": isReported,
        "reply_to": replyTo?.toJson(),
        "attachment": attachment,
        "enabled_notification": enabledNotification,
        "reaction": reaction,
        "children": List<dynamic>.from(children.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Post {
  int id;
  dynamic title;
  String type;
  String uuid;
  int canComment;
  int isAnonymous;
  List<String> tags;
  int viewsCount;
  String status;
  dynamic publishAt;
  DateTime createdAt;
  User? user;

  Post({
    required this.id,
    required this.title,
    required this.type,
    required this.uuid,
    required this.canComment,
    required this.isAnonymous,
    required this.tags,
    required this.viewsCount,
    required this.status,
    required this.publishAt,
    required this.createdAt,
    this.user,
  });

  Post copyWith({
    int? id,
    String? title,
    String? type,
    String? uuid,
    int? canComment,
    int? isAnonymous,
    List<String>? tags,
    int? viewsCount,
    String? status,
    dynamic publishAt,
    DateTime? createdAt,
    User? user,
  }) =>
      Post(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        uuid: uuid ?? this.uuid,
        canComment: canComment ?? this.canComment,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        tags: tags ?? this.tags,
        viewsCount: viewsCount ?? this.viewsCount,
        status: status ?? this.status,
        publishAt: publishAt ?? this.publishAt,
        createdAt: createdAt ?? this.createdAt,
        user: user ?? this.user,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        uuid: json["uuid"],
        canComment: json["can_comment"],
        isAnonymous: json["is_anonymous"],
        tags: json["tags"] == null
            ? []
            : (json["tags"] is List
                ? List<String>.from(json["tags"])
                : (json["tags"] as String)
                    .split(',')
                    .map((e) => e.trim())
                    .toList()),
        viewsCount: json["views_count"],
        status: json["status"],
        publishAt: json["publish_at"],
        createdAt: DateTime.parse(json["created_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "uuid": uuid,
        "can_comment": canComment,
        "is_anonymous": isAnonymous,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "views_count": viewsCount,
        "status": status,
        "publish_at": publishAt,
        "created_at": createdAt.toIso8601String(),
        "user": user?.toJson(),
      };
}

class User {
  int id;
  dynamic avatar;
  dynamic name;
  dynamic username;
  dynamic email;

  User({
    required this.id,
    required this.avatar,
    required this.name,
    required this.username,
    required this.email,
  });

  User copyWith({
    int? id,
    String? avatar,
    String? name,
    String? username,
    String? email,
  }) =>
      User(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
      );

  /// Fallback for a comment whose `user` came back null from the API (e.g.
  /// the author's account no longer exists).
  factory User.anonymous() => User(
        id: 0,
        avatar: "anonymous",
        name: "anonymous",
        username: "anonymous",
        email: "anonymous",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "username": username,
        "email": email,
      };
}

/// Bridges the profile-comments endpoint's own [TalkAmComment] shape to
/// [PostComment], the model the post-detail comment widgets ([CommentItem]
/// etc.) already render — so a user's own comment list can reuse that same
/// widget (like/reply/menu actions included) instead of a second, thinner
/// comment UI.
extension TalkAmCommentMapping on TalkAmComment {
  PostComment toPostComment() => PostComment(
        id: id is int ? id : int.tryParse(id.toString()) ?? 0,
        user: PostCreator(
          id: user.id,
          avatar: user.avatar?.toString(),
          name: user.name?.toString() ?? '',
          username: user.username?.toString(),
          email: user.email?.toString() ?? '',
        ),
        comment: comment,
        isAnonymous:
            isAnonymous is int ? isAnonymous : (isAnonymous == true ? 1 : 0),
        likes: likes is int ? likes : int.tryParse(likes.toString()) ?? 0,
        unlikes:
            unlikes is int ? unlikes : int.tryParse(unlikes.toString()) ?? 0,
        replyTo: replyTo,
        attachment: attachment,
        reaction: reaction == null
            ? null
            : PostReaction.fromJson(reaction as Map<String, dynamic>),
        // The profile-comments endpoint doesn't return typed nested replies
        // (`children` comes back as raw, unparsed JSON) — this view shows a
        // flat list of the user's own comments, so replies aren't needed.
        children: const [],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Who this (top-level) comment is replying to, for [CommentItem]'s
  /// "Replying to @…" line — the post's author, matching how post-detail
  /// screens derive the same label.
  String get replyingToName {
    if (post == null) return '';
    if (post!.isAnonymous == 1) return 'Anonymous';
    final name = post!.user?.name?.toString() ?? '';
    if (name.isNotEmpty) return name;
    return post!.user?.username?.toString() ?? '';
  }
}
