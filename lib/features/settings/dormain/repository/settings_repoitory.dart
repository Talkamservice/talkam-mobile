import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/settings/data/models/blocked_users_response.dart';
import 'package:talkam/features/settings/data/models/data_export_status.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
import 'package:talkam/features/settings/data/models/notification_preferences.dart';
import 'package:talkam/features/settings/data/models/payment_method.dart';
import 'package:talkam/features/settings/data/models/privacy_settings.dart';
import 'package:talkam/features/settings/data/models/update_settings_payload.dart';

abstract class SettingsRepository {
  Future<NotificationsPreferenceResponse> fetchNotificationPreferences();

  Future<dynamic> saveNotificationPreferences(
      UpdateSettingsPayload preferences);

  Future<BlockedUsersResponse> fetchBlockedUsers();

  Future<dynamic> linkSocialAccount(OauthReqDto socialAccountData);

  Future<dynamic> unlinkSocialAccount(String provider);

  Future<dynamic> deleteAccount({String? reason});

  Future<dynamic> blockUser(String userId);

  // ── v2 ────────────────────────────────────────────────────────────────

  Future<NotificationPreferences> getNotificationPreferences();

  Future<NotificationPreferences> updateNotificationPreferences(
      NotificationPreferences preferences);

  Future<PrivacySettings> getPrivacySettings();

  /// [otp] is only required the first time [PrivacySettings.twoFactorEnabled]
  /// is turned on — a fresh TYPE_LOGIN OTP requested via [requestOtp].
  Future<PrivacySettings> updatePrivacySettings(PrivacySettings settings,
      {String? otp});

  Future<List<PaymentMethod>> getPaymentMethods();

  Future<void> deletePaymentMethod(String id);

  /// [currentPin] is required when changing an existing PIN (or [otp] as an
  /// alternative); neither is needed the first time a PIN is set.
  Future<void> setPaymentPin({
    required String pin,
    String? currentPin,
    String? otp,
  });

  Future<DataExportStatus> requestDataExport();

  Future<DataExportStatus> getDataExportStatus();

  /// One open report per (reporter, target) — a second call against the
  /// same target while one is still pending is rejected server-side.
  Future<dynamic> reportUser({
    required String reportedUserId,
    required String reason,
    String? context,
  });
}
