// To parse this JSON data, do
//
//     final commentNotificationExtra = commentNotificationExtraFromJson(jsonString);

import 'dart:convert';

CommentNotificationExtra commentNotificationExtraFromJson(String str) => CommentNotificationExtra.fromJson(json.decode(str));

String commentNotificationExtraToJson(CommentNotificationExtra data) => json.encode(data.toJson());

class CommentNotificationExtra {
  Comment comment;
  List<PostAttachement> postAttachements;

  CommentNotificationExtra({
    required this.comment,
    required this.postAttachements,
  });

  CommentNotificationExtra copyWith({
    Comment? comment,
    List<PostAttachement>? postAttachements,
  }) =>
      CommentNotificationExtra(
        comment: comment ?? this.comment,
        postAttachements: postAttachements ?? this.postAttachements,
      );

  factory CommentNotificationExtra.fromJson(Map<String, dynamic> json) => CommentNotificationExtra(
        comment: Comment.fromJson(json["comment"]),
        postAttachements:
            json["post_attachements"] == null ? [] : List<PostAttachement>.from(json["post_attachements"].map((x) => PostAttachement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment.toJson(),
        "post_attachements": List<dynamic>.from(postAttachements.map((x) => x.toJson())),
      };
}

class Comment {
  int id;
  Post post;
  User user;
  dynamic comment;
  int isAnonymous;
  dynamic replyTo;
  dynamic attachment;
  DateTime createdAt;
  DateTime updatedAt;

  Comment({
    required this.id,
    required this.post,
    required this.user,
    required this.comment,
    required this.isAnonymous,
    required this.replyTo,
    required this.attachment,
    required this.createdAt,
    required this.updatedAt,
  });

  Comment copyWith({
    int? id,
    Post? post,
    User? user,
    String? comment,
    int? isAnonymous,
    dynamic replyTo,
    dynamic attachment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Comment(
        id: id ?? this.id,
        post: post ?? this.post,
        user: user ?? this.user,
        comment: comment ?? this.comment,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        replyTo: replyTo ?? this.replyTo,
        attachment: attachment ?? this.attachment,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        post: Post.fromJson(json["post"]),
        user: User.fromJson(json["user"]),
        comment: json["comment"],
        isAnonymous: json["is_anonymous"],
        replyTo: json["reply_to"],
        attachment: json["attachment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post": post.toJson(),
        "user": user.toJson(),
        "comment": comment,
        "is_anonymous": isAnonymous,
        "reply_to": replyTo,
        "attachment": attachment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Post {
  int id;
  dynamic title;
  dynamic type;
  dynamic uuid;
  dynamic canComment;
  dynamic isAnonymous;
  List<dynamic> tags;
  dynamic viewsCount;
  dynamic status;
  dynamic publishAt;
  dynamic createdAt;
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
    required this.user,
  });

  Post copyWith({
    int? id,
    String? title,
    String? type,
    String? uuid,
    int? canComment,
    int? isAnonymous,
    List<dynamic>? tags,
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
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        viewsCount: json["views_count"],
        status: json["status"],
        publishAt: json["publish_at"],
        createdAt: DateTime.parse(json["created_at"]),
        user: json["user"]== null ?null: User.fromJson(json["user"]),
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "username": username,
        "email": email,
      };
}

class PostAttachement {
  int id;
  String url;
  String type;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  PostAttachement({
    required this.id,
    required this.url,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  PostAttachement copyWith({
    int? id,
    String? url,
    String? type,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PostAttachement(
        id: id ?? this.id,
        url: url ?? this.url,
        type: type ?? this.type,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PostAttachement.fromJson(Map<String, dynamic> json) => PostAttachement(
        id: json["id"],
        url: json["url"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
