// To parse this JSON data, do
//
//     final saveCommentPayload = saveCommentPayloadFromJson(jsonString);

import 'dart:convert';

SaveCommentPayload saveCommentPayloadFromJson(String str) =>
    SaveCommentPayload.fromJson(json.decode(str));

String saveCommentPayloadToJson(SaveCommentPayload data) =>
    json.encode(data.toJson());

class SaveCommentPayload {
  int postId;
  String comment;
  String? attachment;
  int? parentId;
  int? replyComment;
  int? isAnonymous;

  SaveCommentPayload({
    required this.postId,
    required this.comment,
    this.attachment,
    this.parentId,
    this.isAnonymous,
    this.replyComment,
  });

  SaveCommentPayload copyWith({
    int? postId,
    String? comment,
    String? attachment,
    int? parentId,
    int? isAnonymous,
    int? replyComment,
  }) =>
      SaveCommentPayload(
        postId: postId ?? this.postId,
        comment: comment ?? this.comment,
        attachment: attachment ?? this.attachment,
        parentId: parentId ?? this.parentId,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        replyComment: replyComment ?? this.replyComment,
      );

  factory SaveCommentPayload.fromJson(Map<String, dynamic> json) =>
      SaveCommentPayload(
        postId: json["post_id"],
        comment: json["comment"],
        attachment: json["attachment"],
        parentId: json["parent_id"],
        isAnonymous: json["is_anonymous"],
        replyComment: json["reply_comment_id"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "comment": comment,
        "attachment": attachment,
        "parent_id": parentId,
        "is_anonymous": isAnonymous,
        "reply_comment_id": replyComment,
      };
}
