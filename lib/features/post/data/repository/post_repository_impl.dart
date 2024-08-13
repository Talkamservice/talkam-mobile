import 'dart:io';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/firebase_storage/firebase_storage_service.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
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
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final NetworkService _networkService;

  PostRepositoryImpl(this._networkService);

  @override
  Future<GetCategoriesResponse> getCategories({String? categoryId}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getCategories, RequestMethod.get,
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
    try {
      var imageUrls = await FirebaseStorageService().uploadMultipleFiles(
          FirebaseStoragePaths.posts,
          postData.type! == "File"
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
      final response = await _networkService.call(
        UrlConfig.getPostDetails(postId),
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
      final response = await _networkService.call(
          UrlConfig.postReaction, RequestMethod.post,
          data: {"post_id": postId, "action": action});

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
        ? await FirebaseStorageService()
            .uploadImage(FirebaseStoragePaths.posts, File(payload.attachment!))
        : null;

    try {
      final response = await _networkService.call(
          UrlConfig.saveAComment, RequestMethod.post,
          data: payload.copyWith(attachment: imageUrl).toJson());
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
        UrlConfig.getRules,
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
}
