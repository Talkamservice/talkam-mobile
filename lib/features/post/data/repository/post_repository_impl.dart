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

  /// Feed, post detail, and reaction have migrated to /api/v2 — everything
  /// else in this repository (comments, polls, create/report post, etc.)
  /// still uses the v1 [_networkService] until it migrates too.
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
    // if(postData.type=="Video" ){
    //
    // }
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

      logger.w(postData
          .copyWith(
              attachments: imageUrls.map((e) => Attachment.image(e)).toList())
          .toJson());

      final response = await _networkService.call(
          UrlConfig.createPost, RequestMethod.post,
          data: postData
              .copyWith(
                  attachments:
                      imageUrls.map((e) => Attachment.image(e)).toList())
              .toJson());

      return CreatePostResponse.fromJson(response.data);
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
      final response = await _networkService.call(
          UrlConfig.reportPost, RequestMethod.post,
          data: {"post_id": postId, "reason": reason});

      return response.data;
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
      final response = await _networkService.call(
          UrlConfig.getComments, RequestMethod.get,
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
      final response = await _networkService.call(
        UrlConfig.saveAComment,
        RequestMethod.post,
        data: payload
            .copyWith(
                attachment: imageUrl?.firstOrNull,
                comment: updateMentions(payload.comment))
            .toJson(),
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
      final response = await _networkService.call(
          UrlConfig.commentReaction, RequestMethod.post,
          data: {"comment_id": commentId, "action": action});

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
      final response = await _networkService.call(
        UrlConfig.guideline,
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
      final response = await _networkService.call(
          UrlConfig.reportComment, RequestMethod.post,
          data: {"post_id": postId, "comment_id": commentId, "reason": reason});

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
