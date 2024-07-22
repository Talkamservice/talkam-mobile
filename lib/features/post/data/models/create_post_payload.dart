// To parse this JSON data, do
//
//     final createPostPayload = createPostPayloadFromJson(jsonString);

import 'dart:convert';

CreatePostPayload createPostPayloadFromJson(String str) =>
    CreatePostPayload.fromJson(json.decode(str));

String createPostPayloadToJson(CreatePostPayload data) =>
    json.encode(data.toJson());

class CreatePostPayload {
  int? categoryId;
  String? type;
  String? title;
  String? body;
  String? status;
  dynamic publishAt;
  int canComment;
  int? isAnonymous;
  List<Attachment>? attachments;
  List<String>? tags;
  Poll? poll;

  CreatePostPayload({
    this.categoryId,
    this.type,
    this.title,
    this.body,
    this.status = "Active",
    this.publishAt,
    this.canComment = 1,
    this.isAnonymous = 0,
    this.attachments,
    this.tags,
    this.poll,
  });

  CreatePostPayload copyWith({
    int? categoryId,
    String? type,
    String? title,
    String? body,
    String? status,
    dynamic publishAt,
    int? canComment,
    int? isAnonymous,
    List<Attachment>? attachments,
    List<String>? tags,
    Poll? poll,
  }) =>
      CreatePostPayload(
        categoryId: categoryId ?? this.categoryId,
        type: type ?? this.type,
        title: title ?? this.title,
        body: body ?? this.body,
        status: status ?? this.status,
        publishAt: publishAt ?? this.publishAt,
        canComment: canComment ?? this.canComment,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        attachments: attachments ?? this.attachments,
        tags: tags ?? this.tags,
        poll: poll ?? this.poll,
      );

  factory CreatePostPayload.fromJson(Map<String, dynamic> json) =>
      CreatePostPayload(
        categoryId: json["category_id"],
        type: json["type"],
        title: json["title"],
        body: json["body"],
        status: json["status"],
        publishAt: json["publish_at"],
        canComment: json["can_comment"],
        isAnonymous: json["is_anonymous"],
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        tags: List<String>.from(json["tags"].map((x) => x)),
        poll: Poll.fromJson(json["poll"]),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "type": type,
        "title": title,
        "body": body,
        "status": status,
        "publish_at": publishAt,
        "can_comment": canComment,
        "is_anonymous": isAnonymous,
        "attachments": attachments == null
            ? []
            : List<Attachment>.from(attachments!.map((x) => x)),
        "tags": tags == null ? [] : List<String>.from(tags!.map((x) => x)),
        "poll": poll?.toJson(),
      };

  factory CreatePostPayload.empty() => CreatePostPayload(
      categoryId: 0,
      // Or any default value for categoryId
      type: "Text",
      title: '',
      body: '',
      status: 'Active',
      publishAt: null,
      // Or any default value for publishAt
      canComment: 1,
      // Or any default value for canComment
      isAnonymous: 1,
      // Or any default value for isAnonymous
      attachments: [],
      poll: null,
      tags: []);
}

class Attachment {
  String url;
  String type;

  Attachment({
    required this.url,
    required this.type,
  });

  Attachment copyWith({
    String? url,
    String? type,
  }) =>
      Attachment(
        url: url ?? this.url,
        type: type ?? this.type,
      );

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        url: json["url"],
        type: json["type"],
      );

  factory Attachment.image(String url) => Attachment(url: url, type: "Image");

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
      };
}

class Poll {
  String type;
  double duration;
  List<String> options;

  Poll({
    required this.type,
    required this.duration,
    required this.options,
  });

  Poll copyWith({
    String? type,
    double? duration,
    List<String>? options,
  }) =>
      Poll(
        duration: duration ?? this.duration,
        type: type ?? this.type,
        options: options ?? this.options,
      );

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
        type: json["type"],
        duration: json["duration"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "type": type,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}
