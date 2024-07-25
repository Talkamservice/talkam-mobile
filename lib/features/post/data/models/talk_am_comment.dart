class TalkAmReplyToBody {
  final int id;
  final String avatar;
  final String? name;
  final String username;
  final String? email;

  TalkAmReplyToBody({
    required this.id,
    required this.avatar,
    this.name,
    required this.username,
    this.email,
  });

  factory TalkAmReplyToBody.fromJson(Map<String, dynamic> json) {
    return TalkAmReplyToBody(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  @override
  String toString() {
    return 'TalkAmReplyToBody{id: $id, avatar: $avatar, name: $name, username: $username, email: $email}';
  }
}

class TalkAmComment {
  final int id;
  final String comment;
  final DateTime createdAt;
  final dynamic attachment;
  final TalkAmReplyToBody? replyTo;
  final String postTitle;

  TalkAmComment({
    required this.id,
    required this.comment,
    required this.createdAt,
    this.attachment,
    this.replyTo,
    required this.postTitle,
  });

  bool get isReplyingToComment => replyTo != null;

  String get commentReplyTo => isReplyingToComment ? replyTo!.username : postTitle;

  factory TalkAmComment.fromJson(Map<String, dynamic> json) {
    return TalkAmComment(
      id: json['id'],
      postTitle: json['post']['title'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      replyTo: json['reply_to'] != null ? TalkAmReplyToBody.fromJson(json['reply_to']) : null,
      attachment: json['attachment'],
    );
  }

  @override
  String toString() {
    return 'TalkAmComment{id: $id, comment: $comment, createdAt: $createdAt, attachment: $attachment, replyTo: $replyTo}';
  }
}
