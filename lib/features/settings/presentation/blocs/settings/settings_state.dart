// settings_state.dart
part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;

  const factory SettingsState.fetchNotificationPreferencesLoading() =
      _FetchNotificationPreferencesLoading;
  const factory SettingsState.fetchNotificationPreferencesSuccess(
          NotificationsPreferenceResponse response) =
      _FetchNotificationPreferencesSuccess;
  const factory SettingsState.fetchNotificationPreferencesFailure(
      String error) = _FetchNotificationPreferencesFailure;

  const factory SettingsState.saveNotificationPreferencesLoading() =
      _SaveNotificationPreferencesLoading;
  const factory SettingsState.saveNotificationPreferencesSuccess(
      dynamic response) = _SaveNotificationPreferencesSuccess;
  const factory SettingsState.saveNotificationPreferencesFailure(String error) =
      _SaveNotificationPreferencesFailure;

  const factory SettingsState.fetchBlockedUsersLoading() =
      _FetchBlockedUsersLoading;
  const factory SettingsState.fetchBlockedUsersSuccess(
      BlockedUsersResponse response) = _FetchBlockedUsersSuccess;
  const factory SettingsState.fetchBlockedUsersFailure(String error) =
      _FetchBlockedUsersFailure;

  const factory SettingsState.linkSocialAccountLoading() =
      _LinkSocialAccountLoading;
  const factory SettingsState.linkSocialAccountSuccess(dynamic response) =
      _LinkSocialAccountSuccess;
  const factory SettingsState.linkSocialAccountFailure(String error) =
      _LinkSocialAccountFailure;

  const factory SettingsState.unlinkSocialAccountLoading() =
      _UnlinkSocialAccountLoading;
  const factory SettingsState.unlinkSocialAccountSuccess(dynamic response) =
      _UnlinkSocialAccountSuccess;
  const factory SettingsState.unlinkSocialAccountFailure(String error) =
      _UnlinkSocialAccountFailure;

  const factory SettingsState.deleteAccountLoading() = _DeleteAccountLoading;
  const factory SettingsState.deleteAccountSuccess(dynamic response) =
      _DeleteAccountSuccess;
  const factory SettingsState.deleteAccountFailure(String error) =
      _DeleteAccountFailure;

  const factory SettingsState.blockUserLoading() = _BlockUserLoading;
  const factory SettingsState.blockUserSuccess(dynamic response) =
      _BlockUserSuccess;
  const factory SettingsState.blockUserFailure(String error) =
      _BlockUserFailure;

  // ── v2 ────────────────────────────────────────────────────────────────

  const factory SettingsState.getNotificationPreferencesV2Loading() =
      _GetNotificationPreferencesV2Loading;
  const factory SettingsState.getNotificationPreferencesV2Success(
          NotificationPreferences preferences) =
      _GetNotificationPreferencesV2Success;
  const factory SettingsState.getNotificationPreferencesV2Failure(
      String error) = _GetNotificationPreferencesV2Failure;

  const factory SettingsState.updateNotificationPreferencesV2Loading() =
      _UpdateNotificationPreferencesV2Loading;
  const factory SettingsState.updateNotificationPreferencesV2Success(
          NotificationPreferences preferences) =
      _UpdateNotificationPreferencesV2Success;
  const factory SettingsState.updateNotificationPreferencesV2Failure(
      String error) = _UpdateNotificationPreferencesV2Failure;

  const factory SettingsState.getPrivacySettingsLoading() =
      _GetPrivacySettingsLoading;
  const factory SettingsState.getPrivacySettingsSuccess(
      PrivacySettings settings) = _GetPrivacySettingsSuccess;
  const factory SettingsState.getPrivacySettingsFailure(String error) =
      _GetPrivacySettingsFailure;

  const factory SettingsState.updatePrivacySettingsLoading() =
      _UpdatePrivacySettingsLoading;
  const factory SettingsState.updatePrivacySettingsSuccess(
      PrivacySettings settings) = _UpdatePrivacySettingsSuccess;
  const factory SettingsState.updatePrivacySettingsFailure(String error) =
      _UpdatePrivacySettingsFailure;

  const factory SettingsState.getPaymentMethodsLoading() =
      _GetPaymentMethodsLoading;
  const factory SettingsState.getPaymentMethodsSuccess(
      List<PaymentMethod> methods) = _GetPaymentMethodsSuccess;
  const factory SettingsState.getPaymentMethodsFailure(String error) =
      _GetPaymentMethodsFailure;

  const factory SettingsState.deletePaymentMethodLoading() =
      _DeletePaymentMethodLoading;
  const factory SettingsState.deletePaymentMethodSuccess(String id) =
      _DeletePaymentMethodSuccess;
  const factory SettingsState.deletePaymentMethodFailure(String error) =
      _DeletePaymentMethodFailure;

  const factory SettingsState.setPaymentPinLoading() = _SetPaymentPinLoading;
  const factory SettingsState.setPaymentPinSuccess() = _SetPaymentPinSuccess;
  const factory SettingsState.setPaymentPinFailure(String error) =
      _SetPaymentPinFailure;

  const factory SettingsState.requestDataExportLoading() =
      _RequestDataExportLoading;
  const factory SettingsState.requestDataExportSuccess(
      DataExportStatus status) = _RequestDataExportSuccess;
  const factory SettingsState.requestDataExportFailure(String error) =
      _RequestDataExportFailure;

  const factory SettingsState.getDataExportStatusLoading() =
      _GetDataExportStatusLoading;
  const factory SettingsState.getDataExportStatusSuccess(
      DataExportStatus status) = _GetDataExportStatusSuccess;
  const factory SettingsState.getDataExportStatusFailure(String error) =
      _GetDataExportStatusFailure;
}
