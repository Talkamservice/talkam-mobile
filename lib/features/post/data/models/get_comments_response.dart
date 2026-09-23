// To parse this JSON data, do
//
//     final getCommentsResponse = getCommentsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/post/data/models/post_details_response.dart';

import 'get_posts_response.dart';

GetCommentsResponse getCommentsResponseFromJson(String str) =>
    GetCommentsResponse.fromJson(json.decode(str));

String getCommentsResponseToJson(GetCommentsResponse data) =>
    json.encode(data.toJson());

class GetCommentsResponse {
  String message;
  List<PostComment> data;
  bool success;
  int code;

  GetCommentsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  GetCommentsResponse copyWith({
    String? message,
    List<PostComment>? data,
    bool? success,
    int? code,
  }) =>
      GetCommentsResponse(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetCommentsResponse.fromJson(Map<String, dynamic> json) =>
      GetCommentsResponse(
        message: json["message"],
        data: List<PostComment>.from(
            json["data"].map((x) => PostComment.fromJson(x))),
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

class PostComment {
  int id;
  PostCreator user;
  dynamic comment;
  int isAnonymous;
  int likes;
  int unlikes;
  dynamic replyTo;
  dynamic attachment;
  PostReaction? reaction;
  List<PostComment> children;
  DateTime createdAt;
  DateTime updatedAt;

  PostComment({
    required this.id,
    required this.user,
    required this.comment,
    required this.isAnonymous,
    required this.likes,
    required this.unlikes,
    required this.replyTo,
    required this.attachment,
    required this.reaction,
    required this.children,
    required this.createdAt,
    required this.updatedAt,
  });

  PostComment copyWith({
    int? id,
    PostCreator? user,
    String? comment,
    int? isAnonymous,
    int? likes,
    int? unlikes,
    dynamic replyTo,
    String? attachment,
    PostReaction? reaction,
    List<PostComment>? children,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PostComment(
        id: id ?? this.id,
        user: user ?? this.user,
        comment: comment ?? this.comment,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        likes: likes ?? this.likes,
        unlikes: unlikes ?? this.unlikes,
        replyTo: replyTo ?? this.replyTo,
        attachment: attachment ?? this.attachment,
        reaction: reaction ?? this.reaction,
        children: children ?? this.children,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
        id: json["id"] is int
            ? json["id"]
            : int.tryParse(json["id"]?.toString() ?? '0') ?? 0,
        user: json["user"] == null
            ? PostCreator.anonymous()
            : PostCreator.fromJson(json["user"]),
        comment: json["comment"] ?? '',
        isAnonymous: json["is_anonymous"] is int
            ? json["is_anonymous"]
            : (json["is_anonymous"] == true || json["is_anonymous"] == "1"
                ? 1
                : 0),
        likes: json["likes"] is int
            ? json["likes"]
            : int.tryParse(json["likes"]?.toString() ?? '0') ?? 0,
        unlikes: json["unlikes"] is int
            ? json["unlikes"]
            : int.tryParse(json["unlikes"]?.toString() ?? '0') ?? 0,
        replyTo: json["reply_to"] == null
            ? null
            : (json["reply_to"] is Map<String, dynamic>
                ? PostCreator.fromJson(json["reply_to"])
                : json["reply_to"]),
        attachment: json["attachment"],
        reaction: json["reaction"] == null
            ? null
            : PostReaction.fromJson(json["reaction"]),
        children: json["children"] == null
            ? []
            : List<PostComment>.from((json["children"] as List)
                .map((x) => PostComment.fromJson(x))),
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "comment": comment,
        "is_anonymous": isAnonymous,
        "likes": likes,
        "unlikes": unlikes,
        "reply_to": replyTo is PostCreator
            ? (replyTo as PostCreator).toJson()
            : replyTo,
        "attachment": attachment,
        "reaction": reaction?.toJson(),
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  /// Anonymous-aware display name — the one source of truth for "what do
  /// we call this commenter", used both when rendering a comment and when
  /// resolving who a flattened reply is shown as targeting.
  String get displayName => isAnonymous.toBool ? "Anonymous" : user.usersName;

  bool get isReplyingToComment => replyTo != null;

  String get commentReplyTo {
    if (replyTo is PostCreator) {
      final creator = replyTo as PostCreator;
      return creator.username?.isNotEmpty == true
          ? creator.username!
          : creator.name;
    }
    if (replyTo is Map) {
      return replyTo["username"]?.toString() ??
          replyTo["name"]?.toString() ??
          '';
    }
    return replyTo?.toString() ?? '';
  }
}
