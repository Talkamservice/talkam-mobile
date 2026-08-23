import 'dart:io';
import 'package:dio/dio.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/firebase_storage/firebase_storage_service.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/create_post_response.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_drafts_response.dart';
import 'package:talkam/features/post/data/models/get_guidlines_response.dart';
import 'package:talkam/features/post/data/models/get_polls_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_details_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/data/models/trends_response.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final NetworkService _networkService;

  /// Feed, post detail/reaction, create/save-draft, comments (list/create/
  /// react), report post/comment, not-interested, and guidelines have
  /// migrated to /api/v2 — polls, deletePost, getAComment, deleteComment,
  /// selectPoll/deletePoll, categories, and trends still use the v1
  /// [_networkService] until they migrate too.
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  /// The Authorization header is automatically injected by [_AuthInterceptor].
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

  PostRepositoryImpl(this._networkService);

  @override
  Future<GetPostsResponse> getFeed(
      {required String tab, String? categoryId, int? page}) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.posts,
        RequestMethod.get,
        queryParams: {
          "tab": tab,
          if (categoryId != null && categoryId.isNotEmpty)
            "category_id": categoryId,
          if (page != null) "page": page,
        },
      );

      return GetPostsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);

      rethrow;
    }
  }

  @override
  Future<GetCategoriesResponse> getCategories(
      {String? categoryId, bool? mergeGroups}) async {
    try {
      final response = await _networkService.call(
          !(mergeGroups ?? false)
              ? UrlConfig.getCategories
              : UrlConfig.getCategoriesWithGroup,
          RequestMethod.get,
          queryParams: {"category_id": categoryId});

      return GetCategoriesResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);

      rethrow;
    }
  }

  @override
  Future<GetCategoriesResponse> getInterestTopics() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.interestTopics, RequestMethod.get);

      return GetCategoriesResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);

      rethrow;
    }
  }

  @override
  Future<GetPostsResponse> getPosts(PostFilterModel filters) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getPosts, RequestMethod.get,
          queryParams: filters.toJson());

      return GetPostsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);

      rethrow;
    }
  }

  @override
  Future<CreatePostResponse> createPost(CreatePostPayload postData) async {
    var imageUrls = [];
    try {
      imageUrls = await FirebaseStorageService().uploadMultipleFiles(
          FirebaseStoragePaths.posts,
          postData.type! == "File" ||
                  postData.type! == "Image" ||
                  postData.type! == "Video"
              ? postData.attachments?.map(
                    (e) {
                      return File(e.url);
                    },
                  ).toList() ??
                  []
              : []);

      final response = await _v2.call(UrlConfigV2.posts, RequestMethod.post,
          data: postData
              .copyWith(
                  body: postData.body == null
                      ? null
                      : updateMentions(postData.body!),
                  attachments:
                      imageUrls.map((e) => Attachment.image(e)).toList())
              .toJson());

      return CreatePostResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreatePostResponse> saveDraft(CreatePostPayload postData) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.postDrafts,
        RequestMethod.post,
        formData: FormData.fromMap({
          "category_id": postData.categoryId,
          "type": postData.type,
          "title": postData.title,
          "body": postData.body,
        }),
        options: _formOptions,
      );

      return CreatePostResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetDraftsResponse> getDrafts() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.postDrafts, RequestMethod.get);

      return GetDraftsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreatePostResponse> updateDraft(
      String draftId, CreatePostPayload postData) async {
    try {
      // Unlike saveDraft's create call, this is a text-only edit (no
      // attachment re-upload), and NetworkService's RequestMethod.put
      // branch doesn't accept formData/custom Options anyway — plain JSON
      // matches createPost's pattern and is what PostDraftController::update
      // (`$request->all()`) expects just as well.
      final response = await _v2.call(
        UrlConfigV2.postDraftDetail(draftId),
        RequestMethod.put,
        data: {
          "category_id": postData.categoryId,
          "type": postData.type,
          "title": postData.title,
          "body": postData.body,
          // Included so a draft can be "published" via the same call —
          // update(status: Active) moves it out of the drafts index and
          // into the real feed (PostService::list filters status=Active).
          if (postData.status != null) "status": postData.status,
        },
      );

      return CreatePostResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteDraft(String draftId) async {
    try {
      await _v2.call(
          UrlConfigV2.postDraftDetail(draftId), RequestMethod.delete);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostDetailsResponse> getPostDetails(String postId) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.postDetail(postId),
        RequestMethod.get,
      );

      return PostDetailsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deletePost(String postId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.deletePosts(postId), RequestMethod.delete,
          queryParams: {"post_id": postId});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> postReaction(String postId, String action) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.postReaction,
        RequestMethod.post,
        formData: FormData.fromMap({"post_id": postId, "action": action}),
        options: _formOptions,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> reportPost(String postId, String reason) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.reportPost,
        RequestMethod.post,
        formData: FormData.fromMap({"post_id": postId, "reason": reason}),
        options: _formOptions,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> toggleNotInterested(String postId) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.notInterested,
        RequestMethod.post,
        formData: FormData.fromMap({"post_id": postId}),
        options: _formOptions,
      );

      return response.data["data"]["not_interested"] as bool;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetPollsResponse> getPolls() async {
    try {
      final response =
          await _networkService.call(UrlConfig.getPolls, RequestMethod.get);

      return GetPollsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetCommentsResponse> getComments(String postId) async {
    try {
      final response = await _v2.call(
          UrlConfigV2.postComments, RequestMethod.get,
          queryParams: {"post_id": postId});
      return GetCommentsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());

      rethrow;
    }
  }

  @override
  Future<dynamic> getAComment(String commentId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getAComment, RequestMethod.get,
          data: {"commentId": commentId});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> saveAComment(SaveCommentPayload payload) async {
    var imageUrl = payload.attachment != null
        ? await FirebaseStorageService().uploadMultipleFiles(
            FirebaseStoragePaths.posts, [File(payload.attachment!)])
        : null;

    try {
      final response = await _v2.call(
        UrlConfigV2.postComments,
        RequestMethod.post,
        formData: FormData.fromMap({
          "post_id": payload.postId,
          "comment": updateMentions(payload.comment),
          "is_anonymous": payload.isAnonymous ?? 0,
          if (payload.parentId != null) "parent_id": payload.parentId,
          if (payload.replyComment != null)
            "reply_comment_id": payload.replyComment,
          if (imageUrl?.firstOrNull != null) "attachment": imageUrl!.first,
        }),
        options: _formOptions,
      );
      return response.data;
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteComment(String commentId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.deleteComment(commentId), RequestMethod.delete,
          data: {"post_comment_id": commentId});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> commentReaction(String commentId, String action) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.postCommentReaction,
        RequestMethod.post,
        formData: FormData.fromMap({"comment_id": commentId, "action": action}),
        options: _formOptions,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deletePoll(String pollId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.commentReaction, RequestMethod.delete,
          queryParams: {"id": pollId});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future selectPoll(String pollId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.selectPoll, RequestMethod.post,
          data: {"poll_id": pollId});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetGuidlinesResponse> getRules() async {
    try {
      final response = await _v2.call(
        UrlConfigV2.guidelines,
        RequestMethod.get,
      );

      return GetGuidlinesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future reportComment(String postId, String commentId, String reason) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.reportComment,
        RequestMethod.post,
        formData: FormData.fromMap(
            {"post_id": postId, "comment_id": commentId, "reason": reason}),
        options: _formOptions,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetCategoriesResponse> getSubCategories() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getSubCategories,
        RequestMethod.get,
      );

      return GetCategoriesResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);

      rethrow;
    }
  }

//   @override
//   Future<TalkamPost> getAPosts(String id) async {
//     try {
//       final response = await _networkService.call(
//           UrlConfig.selectPoll, RequestMethod.post,
//           data: {"id": id});
//
//       return response.data;
//     } catch (e) {
//       rethrow;
//     }

  String updateMentions(String input) {
    // Regular expression to find mentions like '@username'
    final mentionRegex = RegExp(r'@\w+');

    // Replace each mention found with the mention surrounded by '$'
    String updatedString = input.replaceAllMapped(mentionRegex, (match) {
      return '\$${match.group(0)}\$'; // Surround the mention with '$'
    });

    return updatedString;
  }

  @override
  Future<TrendsResponse> getTrends() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getTrends,
        RequestMethod.get,
      );

      return TrendsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);
      rethrow;
    }
  }

  @override
  Future<GetPostsResponse> getPromotedPosts() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getPromotedPosts,
        RequestMethod.get,
      );

      return GetPostsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);

      rethrow;
    }
  }

  @override
  Future<PostCategory> getCategoryById({String? categoryId}) async {
    try {
      final response = await _networkService.call(
        UrlConfig.getCategoryById(categoryId),
        RequestMethod.get,
      );
      return PostCategory.fromJson(response.data["data"]);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);

      rethrow;
    }
  }
}
