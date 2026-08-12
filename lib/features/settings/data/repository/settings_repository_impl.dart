import 'package:dio/dio.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/settings/data/models/blocked_users_response.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/update_settings_payload.dart';
import 'package:talkam/features/settings/dormain/repository/settings_repoitory.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final NetworkService _networkService;

  /// Blocked-users add/list have migrated to /api/v2 — the rest of this
  /// repository stays on v1 until it migrates too.
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  /// The Authorization header is automatically injected by [_AuthInterceptor].
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

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
      final response =
          await _v2.call(UrlConfigV2.blockedUsers, RequestMethod.get);
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
      final response = await _v2.call(
        UrlConfigV2.blockedUsersAdd,
        RequestMethod.post,
        formData: FormData.fromMap({"blocked_user_id": userId}),
        options: _formOptions,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
