import 'package:talkam/features/post/data/models/get_posts_response.dart';

/// `GET /user/post-drafts` — a plain array of posts (status=drafted), not
/// the paginated `{pagination_meta, data}` envelope [GetPostsResponse] uses
/// for the feed.
class GetDraftsResponse {
  final String message;
  final List<TalkamPost> data;
  final bool success;
  final int code;

  GetDraftsResponse({
    required this.message,
    required this.data,
    required this.success,
    required this.code,
  });

  factory GetDraftsResponse.fromJson(Map<String, dynamic> json) =>
      GetDraftsResponse(
        message: json["message"],
        data: List<TalkamPost>.from(
            (json["data"] as List).map((x) => TalkamPost.fromJson(x))),
        success: json["success"],
        code: json["code"],
      );
}
