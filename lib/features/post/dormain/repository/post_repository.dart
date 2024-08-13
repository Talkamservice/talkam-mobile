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

abstract class PostRepository {
  Future<GetCategoriesResponse> getCategories({String? categoryId});

  Future<GetPostsResponse> getPosts(PostFilterModel model);

  // Future<TalkamPost> getAPosts(String id);

  Future<CreatePostResponse> createPost(CreatePostPayload postData);

  Future<GetGuidlinesResponse> getRules();

  Future<PostDetailsResponse> getPostDetails(String postId);

  Future<dynamic> deletePost(String postId);

  Future<dynamic> postReaction(String postId, String action);

  Future<dynamic> reportPost(String postId, String reason);

  Future<GetPollsResponse> getPolls();

  Future<GetCommentsResponse> getComments(String postId);

  Future<dynamic> getAComment(String commentId);

  Future<GetCategoriesResponse> getSubCategories();

  Future<dynamic> saveAComment(SaveCommentPayload payload);

  Future<dynamic> deleteComment(String commentId);

  Future<dynamic> commentReaction(String commentId, String action);

  Future<dynamic> selectPoll(String pollId);

  Future<dynamic> deletePoll(String pollId);

  Future<dynamic> reportComment(String postId, String commentId, String reason);
}
