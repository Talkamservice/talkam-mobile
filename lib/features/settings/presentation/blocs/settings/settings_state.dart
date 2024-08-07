// settings_state.dart
part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {

  const factory SettingsState.initial() = _Initial;


  const factory SettingsState.fetchNotificationPreferencesLoading() = _FetchNotificationPreferencesLoading;
  const factory SettingsState.fetchNotificationPreferencesSuccess(NotificationsPreferenceResponse response) = _FetchNotificationPreferencesSuccess;
  const factory SettingsState.fetchNotificationPreferencesFailure(String error) = _FetchNotificationPreferencesFailure;

  const factory SettingsState.saveNotificationPreferencesLoading() = _SaveNotificationPreferencesLoading;
  const factory SettingsState.saveNotificationPreferencesSuccess(dynamic response) = _SaveNotificationPreferencesSuccess;
  const factory SettingsState.saveNotificationPreferencesFailure(String error) = _SaveNotificationPreferencesFailure;

  const factory SettingsState.fetchBlockedUsersLoading() = _FetchBlockedUsersLoading;
  const factory SettingsState.fetchBlockedUsersSuccess(BlockedUsersResponse response) = _FetchBlockedUsersSuccess;
  const factory SettingsState.fetchBlockedUsersFailure(String error) = _FetchBlockedUsersFailure;

  const factory SettingsState.linkSocialAccountLoading() = _LinkSocialAccountLoading;
  const factory SettingsState.linkSocialAccountSuccess(dynamic response) = _LinkSocialAccountSuccess;
  const factory SettingsState.linkSocialAccountFailure(String error) = _LinkSocialAccountFailure;

  const factory SettingsState.unlinkSocialAccountLoading() = _UnlinkSocialAccountLoading;
  const factory SettingsState.unlinkSocialAccountSuccess(dynamic response) = _UnlinkSocialAccountSuccess;
  const factory SettingsState.unlinkSocialAccountFailure(String error) = _UnlinkSocialAccountFailure;

  const factory SettingsState.deleteAccountLoading() = _DeleteAccountLoading;
  const factory SettingsState.deleteAccountSuccess(dynamic response) = _DeleteAccountSuccess;
  const factory SettingsState.deleteAccountFailure(String error) = _DeleteAccountFailure;

  const factory SettingsState.blockUserLoading() = _BlockUserLoading;
  const factory SettingsState.blockUserSuccess(dynamic response) = _BlockUserSuccess;
  const factory SettingsState.blockUserFailure(String error) = _BlockUserFailure;
}
