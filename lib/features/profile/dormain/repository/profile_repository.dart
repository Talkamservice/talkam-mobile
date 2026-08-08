import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:talkam/features/post/data/models/talkam_upvote.dart';
import 'package:talkam/features/post/data/models/update_profile_response.dart';
import 'package:talkam/features/profile/data/models/block_user_response.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/data/models/user_media_response.dart';

abstract class ProfileRepository {
  Future<dynamic> uploadAvatar(String filePath);

  Future<UpdateProfileResponse> updateProfile(UpdateProfilePayload payload);

  Future<GetAvatarsResponse> getAvatars();

  Future<BlockUserResponse> blockUser(String userId);

  Future<dynamic> addOrRemoveInterest(String categoryId);

  Future<TalkamUser?> fetchUserProfile();

  Future<List<TalkamPost>> fetchUserPosts(
      {int page = 1, bool isPaginating = false, bool isScheduled = false});

  Future<List<TalkAmComment>> fetchUserComments();

  Future<List<TalkamPost>> fetchUserUpvote({int page = 1});

  Future<List<TalkamPost>> fetchUserPostsById(
      {int page = 1, bool isPaginating = false, required String userId});

  Future<List<TalkAmComment>> fetchUserCommentsById(String userId);

  Future<List<TalkamPost>> fetchUserUpvoteById(
      {int page = 1, required String userId});

  Future<List<UserMedia>> fetchUserMediaById(
      {int page = 1, required String userId});

  Future<dynamic> getProfile(String userId);

  /// Records onboarding intent — role stays "User" server-side either way.
  Future<dynamic> setUserType(String userType);

  /// Stamps the account's onboarding as complete server-side and returns the
  /// resulting onboarding summary.
  Future<Onboarding?> completeOnboarding();
}
