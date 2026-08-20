import 'package:dio/dio.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/settings/data/models/blocked_users_response.dart';
import 'package:talkam/features/settings/data/models/data_export_status.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/notification_preferences.dart';
import 'package:talkam/features/settings/data/models/payment_method.dart';
import 'package:talkam/features/settings/data/models/privacy_settings.dart';
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
      final response = await _v2.call(
        UrlConfigV2.deleteAccount,
        RequestMethod.post,
        formData: FormData.fromMap({if (reason != null) "reason": reason}),
        options: _formOptions,
      );
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

  // ── v2 ────────────────────────────────────────────────────────────────

  @override
  Future<NotificationPreferences> getNotificationPreferences() async {
    try {
      final response = await _v2.call(
          UrlConfigV2.notificationPreferences, RequestMethod.get);
      return NotificationPreferences.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NotificationPreferences> updateNotificationPreferences(
      NotificationPreferences preferences) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.notificationPreferences,
        RequestMethod.post,
        data: preferences.toJson(),
      );
      return NotificationPreferences.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PrivacySettings> getPrivacySettings() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.privacySettings, RequestMethod.get);
      return PrivacySettings.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PrivacySettings> updatePrivacySettings(PrivacySettings settings,
      {String? otp}) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.privacySettings,
        RequestMethod.post,
        data: {
          ...settings.toJson(),
          if (otp != null) "otp": otp,
        },
      );
      return PrivacySettings.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.paymentMethods, RequestMethod.get);
      final data = response.data['data'] as List? ?? [];
      return data
          .map((e) => PaymentMethod.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePaymentMethod(String id) async {
    try {
      await _v2.call(
        UrlConfigV2.deletePaymentMethod(id),
        RequestMethod.delete,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setPaymentPin({
    required String pin,
    String? currentPin,
    String? otp,
  }) async {
    try {
      await _v2.call(
        UrlConfigV2.paymentPin,
        RequestMethod.post,
        formData: FormData.fromMap({
          "pin": pin,
          if (currentPin != null) "current_pin": currentPin,
          if (otp != null) "otp": otp,
        }),
        options: _formOptions,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataExportStatus> requestDataExport() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.dataExport, RequestMethod.post);
      return DataExportStatus.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataExportStatus> getDataExportStatus() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.dataExportLatest, RequestMethod.get);
      return DataExportStatus.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
