class TalkAmCommenter {
  final int id;
  final String avatar;
  final String? name;
  final String username;
  final String? email;

  TalkAmCommenter({
    required this.id,
    required this.avatar,
    this.name,
    required this.username,
    this.email,
  });

  factory TalkAmCommenter.fromJson(Map<String, dynamic> json) {
    return TalkAmCommenter(
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
  final int isAnonymous;
  final DateTime createdAt;
  final dynamic attachment;
  final TalkAmCommenter? replyTo;
  final TalkAmCommenter? user;
  final String postTitle;

  TalkAmComment({
    required this.id,
    required this.comment,
    required this.createdAt,
    this.attachment,
    this.replyTo,
    this.user,
    required this.isAnonymous,
    required this.postTitle,
  });

  bool get isReplyingToComment => replyTo != null;

  String get commentReplyTo =>
      isReplyingToComment ? replyTo!.username : postTitle;

  factory TalkAmComment.fromJson(Map<String, dynamic> json) {
    return TalkAmComment(
      id: json['id'],
      postTitle: json['post']['title'],
      comment: json['comment'],
      isAnonymous: json['is_anonymous'],
      createdAt: DateTime.parse(json['created_at']),
      replyTo: json['reply_to'] != null
          ? TalkAmCommenter.fromJson(json['reply_to'])
          : null,
      user:
          json['user'] != null ? TalkAmCommenter.fromJson(json['user']) : null,
      attachment: json['attachment'],
    );
  }

  @override
  String toString() {
    return 'TalkAmComment{id: $id, comment: $comment, createdAt: $createdAt, attachment: $attachment, replyTo: $replyTo}';
  }
}
