import 'package:talkam/core/_core.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:talkam/features/post/data/models/update_profile_response.dart';
import 'package:talkam/features/profile/data/models/block_user_response.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/data/models/user_media_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final NetworkService _networkService;

  ProfileRepositoryImpl(this._networkService);

  @override
  Future<dynamic> uploadAvatar(String imagePath) async {
    try {
      final response = await _networkService.call(UrlConfig.uploadAvatar, RequestMethod.post, data: {});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpdateProfileResponse> updateProfile(UpdateProfilePayload payload) async {
    try {
      final response = await _networkService.call(UrlConfig.updateProfile, RequestMethod.post, data: payload.toJson());

      return UpdateProfileResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetAvatarsResponse> getAvatars() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getAvatars,
        RequestMethod.get,
      );

      return GetAvatarsResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e);
      logger.e(stack);

      rethrow;
    }
  }

  @override
  Future<BlockUserResponse> blockUser(String userId) async {
    try {
      final response = await _networkService.call(UrlConfig.blockUser, RequestMethod.post, data: {"blocked_user_id": userId});

      return BlockUserResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TalkAmComment>> fetchUserComments() async {
    if (SessionManager.instance.doesUserDataExists) {
      final user = TalkamUser.fromJson(SessionManager.instance.usersData);
      final response = await _networkService.call("/user/post-comments?user_id=${user.id}&exclude_anonymous=1&type=all", RequestMethod.get);
      return List.from(response.data['data']).map((e) => TalkAmComment.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<TalkamPost>> fetchUserPosts({int page = 1, bool isPaginating = false, bool isScheduled = false}) async {
    if (SessionManager.instance.doesUserDataExists) {
      final user = TalkamUser.fromJson(SessionManager.instance.usersData);
      if (!isPaginating) {
        final res = await Future.wait([
          if (!isScheduled) _networkService.call("/user/posts?user_id=${user.id}&tab=latest&page=1&exclude_anonymous=1&tab=latest", RequestMethod.get),
          if (isScheduled) _networkService.call("/user/post-schedules", RequestMethod.get),
        ]);
        // final List<TalkamPost> schedulePosts = List.from(res[1].data['data']).map((e) => TalkamPost.fromJson(e)).toList();
        final List<TalkamPost> posts = isScheduled
            ? List.from(res[0].data['data']).map((e) => TalkamPost.fromJson(e)).toList()
            : List.from(res[0].data['data']['data']).map((e) => TalkamPost.fromJson(e)).toList();



        return [...posts];
      } else {
        final response = await _networkService.call("/user/posts?user_id=${user.id}&tab=latest&page=$page&exclude_anonymous=1", RequestMethod.get);
        return List.from(response.data['data']['data']).map((e) => TalkamPost.fromJson(e)).toList();
      }
    } else {
      return [];
    }
  }

  @override
  Future<TalkamUser?> fetchUserProfile() async {
    if (SessionManager.instance.doesUserDataExists) {
      final user = TalkamUser.fromJson(SessionManager.instance.usersData);
      final response = await _networkService.call("/user/profile/fetch?user_id=${user.id}", RequestMethod.get);
      final newUserResponse = TalkamUser.fromJson(response.data['data']);
      SessionManager.instance.usersData = newUserResponse.toJson();
      return newUserResponse;
    } else {
      return null;
    }
  }

  @override
  Future<List<TalkamPost>> fetchUserUpvote({int page = 1}) async {
    if (SessionManager.instance.doesUserDataExists) {
      final user = TalkamUser.fromJson(SessionManager.instance.usersData);
      final response = await _networkService.call("/user/posts/actions/get-upvotes?user_id=${user.id}&page=1", RequestMethod.get);
      return List.from(response.data['data']['data']).map((e) => TalkamPost.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<TalkamUser> getProfile(String userId) async {
    try {
      final response = await _networkService.call(userId.containsAlphabet() ? UrlConfig.getUserByUserName(userId) : UrlConfig.getUser, RequestMethod.get,
          queryParams: {if (!userId.containsAlphabet()) "user_id": userId});

      return TalkamUser.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future addOrRemoveInterest(String categoryId) async {
    try {
      final response = await _networkService.call(UrlConfig.addOrRemoveInterest, RequestMethod.post, queryParams: {"category_id": categoryId});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TalkamPost>> fetchUserPostsById({int page = 1, bool isPaginating = false, required String userId}) async {
    if (!isPaginating) {
      final res = await Future.wait([
        _networkService.call("/user/posts?user_id=$userId?page=1&tab=latest", RequestMethod.get),
        // _networkService.call("/user/post-schedules", RequestMethod.get),
      ]);
      // final List<TalkamPost> schedulePosts = List.from(res[1].data['data'])
      //     .map((e) => TalkamPost.fromJson(e))
      //     .toList();
      final List<TalkamPost> posts = List.from(res[0].data['data']['data']).map((e) => TalkamPost.fromJson(e)).toList();

      return [...posts];
    } else {
      final response = await _networkService.call("/user/posts?user_id=$userId&page=$page", RequestMethod.get);
      return List.from(response.data['data']['data']).map((e) => TalkamPost.fromJson(e)).toList();
    }
  }

  @override
  Future<TalkamUser?> fetchUserProfileById(String userId) async {
    final response = await _networkService.call("/user/profile/fetch?user_id=$userId", RequestMethod.get);
    final newUserResponse = TalkamUser.fromJson(response.data['data']);
    SessionManager.instance.usersData = newUserResponse.toJson();
    return newUserResponse;
  }

  @override
  Future<List<TalkamPost>> fetchUserUpvoteById({int page = 1, required String userId}) async {
    if (SessionManager.instance.doesUserDataExists) {
      final user = TalkamUser.fromJson(SessionManager.instance.usersData);
      final response = await _networkService.call("/user/posts/actions/get-upvotes?user_id=$userId&page=1", RequestMethod.get);
      return List.from(response.data['data']['data']).map((e) => TalkamPost.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<TalkAmComment>> fetchUserCommentsById(String userId) async {
    final response = await _networkService.call("/user/post-comments?user_id=$userId&exclude_anonymous=1&type=all", RequestMethod.get);
    return List.from(response.data['data']).map((e) => TalkAmComment.fromJson(e)).toList();
  }

  @override
  Future<List<UserMedia>> fetchUserMediaById({int page = 1, required String userId}) async {
    if (SessionManager.instance.doesUserDataExists) {
      final user = TalkamUser.fromJson(SessionManager.instance.usersData);
      final response = await _networkService.call("/user/posts/media/fetch?user_id=$userId&exclude_anonymous=1&page=$page", RequestMethod.get);
      return List.from(response.data['data']['data']).map((e) => UserMedia.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
