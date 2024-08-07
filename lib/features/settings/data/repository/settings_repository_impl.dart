import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/settings/data/models/blocked_users_response.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/update_settings_payload.dart';
import 'package:talkam/features/settings/dormain/repository/settings_repoitory.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final NetworkService _networkService;

  SettingsRepositoryImpl(this._networkService);

  @override
  Future<NotificationsPreferenceResponse> fetchNotificationPreferences() async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchNotificationPreferences, RequestMethod.get);
      return NotificationsPreferenceResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> saveNotificationPreferences(
      UpdateSettingsPayload preferences) async {
    try {
      final response = await _networkService.call(
          UrlConfig.saveNotificationPreferences, RequestMethod.post,
          data: preferences.toJson());
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BlockedUsersResponse> fetchBlockedUsers() async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchBlockedUsers, RequestMethod.get);
      return BlockedUsersResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> linkSocialAccount(OauthReqDto socialAccountData) async {
    try {
      final response = await _networkService.call(
          UrlConfig.linkSocialAccount, RequestMethod.post,
          data: socialAccountData.toJson());
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> unlinkSocialAccount(String provider) async {
    try {
      final response = await _networkService.call(
          UrlConfig.unlinkSocialAccount, RequestMethod.post,
          data: {"provider": provider});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteAccount({String? reason}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.deleteAccount, RequestMethod.post,
          data: {"reason": reason});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> blockUser(String userId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.blockUser, RequestMethod.post,
          data: {"blocked_user_id": userId});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
