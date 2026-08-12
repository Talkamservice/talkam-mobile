import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/create_post_response.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_guidlines_response.dart';
import 'package:talkam/features/post/data/models/get_polls_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_details_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/data/models/trends_response.dart';

abstract class PostRepository {
  Future<GetCategoriesResponse> getCategories(
      {String? categoryId, bool? mergeGroups});

  /// The onboarding interest chips — post_categories rows marked
  /// `type=interest_topic`.
  Future<GetCategoriesResponse> getInterestTopics();

  Future<PostCategory> getCategoryById({
    String? categoryId,
  });

  Future<GetPostsResponse> getPosts(PostFilterModel model);
  Future<GetPostsResponse> getPromotedPosts();

  /// v2 home feed — `tab` is `for_you` or `trending`. Unlike the v1
  /// [getPosts]/[getPromotedPosts] pair, promoted posts are already
  /// interleaved server-side and marked via `TalkamPost.promotion`, so there
  /// is no separate promoted-posts call or client-side merge to do.
  Future<GetPostsResponse> getFeed(
      {required String tab, String? categoryId, int? page});

  // Future<TalkamPost> getAPosts(String id);

  Future<CreatePostResponse> createPost(CreatePostPayload postData);

  Future<CreatePostResponse> saveDraft(CreatePostPayload postData);

  Future<GetGuidlinesResponse> getRules();

  Future<PostDetailsResponse> getPostDetails(String postId);

  Future<dynamic> deletePost(String postId);

  Future<dynamic> postReaction(String postId, String action);

  Future<dynamic> reportPost(String postId, String reason);

  Future<GetPollsResponse> getPolls();

  Future<GetCommentsResponse> getComments(String postId);

  Future<dynamic> getAComment(String commentId);

  Future<TrendsResponse> getTrends();

  Future<GetCategoriesResponse> getSubCategories();

  Future<dynamic> saveAComment(SaveCommentPayload payload);

  Future<dynamic> deleteComment(String commentId);

  Future<dynamic> commentReaction(String commentId, String action);

  Future<dynamic> selectPoll(String pollId);

  Future<dynamic> deletePoll(String pollId);

  Future<dynamic> reportComment(String postId, String commentId, String reason);

  /// Hides the post from the caller's v2 feeds. Returns the new
  /// `not_interested` state.
  Future<bool> toggleNotInterested(String postId);
}
