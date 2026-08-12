import 'package:talkam/features/post/data/models/get_posts_response.dart';

/// v2 `GET /user/search?sort=people` — same pagination shape as posts,
/// carrying `PostCreator` rows with `is_following` set on each.
class PeopleSearchResponse {
  PostsPaginationData paginationMeta;
  List<PostCreator> data;

  PeopleSearchResponse({
    required this.paginationMeta,
    required this.data,
  });

  factory PeopleSearchResponse.fromJson(Map<String, dynamic> json) =>
      PeopleSearchResponse(
        paginationMeta: PostsPaginationData.fromJson(json["pagination_meta"]),
        data: List<PostCreator>.from(
            json["data"].map((x) => PostCreator.fromJson(x))),
      );
}
