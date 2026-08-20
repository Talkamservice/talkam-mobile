part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.started() = _Started;
  const factory SettingsEvent.fetchNotificationPreferences({bool? refresh}) =
      _FetchNotificationPreferences;
  const factory SettingsEvent.saveNotificationPreferences(
      UpdateSettingsPayload preferences) = _SaveNotificationPreferences;
  const factory SettingsEvent.fetchBlockedUsers() = _FetchBlockedUsers;
  const factory SettingsEvent.linkSocialAccount(String provider) =
      _LinkSocialAccount;
  const factory SettingsEvent.unlinkSocialAccount(String accountId) =
      _UnlinkSocialAccount;
  const factory SettingsEvent.deleteAccount({String? reason}) = _DeleteAccount;
  const factory SettingsEvent.blockUser(String userId) = _BlockUser;

  // ── v2 ────────────────────────────────────────────────────────────────

  const factory SettingsEvent.getNotificationPreferencesV2() =
      _GetNotificationPreferencesV2;
  const factory SettingsEvent.updateNotificationPreferencesV2(
      NotificationPreferences preferences) = _UpdateNotificationPreferencesV2;

  const factory SettingsEvent.getPrivacySettings() = _GetPrivacySettings;
  const factory SettingsEvent.updatePrivacySettings(PrivacySettings settings,
      {String? otp}) = _UpdatePrivacySettings;

  const factory SettingsEvent.getPaymentMethods() = _GetPaymentMethods;
  const factory SettingsEvent.deletePaymentMethod(String id) =
      _DeletePaymentMethod;

  const factory SettingsEvent.setPaymentPin({
    required String pin,
    String? currentPin,
    String? otp,
  }) = _SetPaymentPin;

  const factory SettingsEvent.requestDataExport() = _RequestDataExport;
  const factory SettingsEvent.getDataExportStatus() = _GetDataExportStatus;
}
