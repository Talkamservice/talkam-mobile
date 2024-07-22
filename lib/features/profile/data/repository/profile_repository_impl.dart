import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/data/models/get_avatars_response.dart';
import 'package:talkam/features/post/data/models/update_profile_response.dart';
import 'package:talkam/features/profile/data/models/update_profile_payload.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final NetworkService _networkService;

  ProfileRepositoryImpl(this._networkService);

  @override
  Future<dynamic> uploadAvatar(String imagePath) async {
    try {
      final response = await _networkService
          .call(UrlConfig.uploadAvatar, RequestMethod.post, data: {});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfilePayload payload) async {
    try {
      final response = await _networkService.call(
          UrlConfig.updateProfile, RequestMethod.post,
          data: payload.toJson());

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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetAvatarsResponse> blockUser(String userId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.blockUser, RequestMethod.post,
          data: {"blocked_user_id": userId});

      return GetAvatarsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
