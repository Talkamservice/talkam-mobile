part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {


  const factory SettingsEvent.started() = _Started;
  const factory SettingsEvent.fetchNotificationPreferences({bool? refresh}) = _FetchNotificationPreferences;
  const factory SettingsEvent.saveNotificationPreferences(UpdateSettingsPayload preferences) = _SaveNotificationPreferences;
  const factory SettingsEvent.fetchBlockedUsers() = _FetchBlockedUsers;
  const factory SettingsEvent.linkSocialAccount(String provider) = _LinkSocialAccount;
  const factory SettingsEvent.unlinkSocialAccount(String accountId) = _UnlinkSocialAccount;
  const factory SettingsEvent.deleteAccount({String? reason}) = _DeleteAccount;
  const factory SettingsEvent.blockUser(String userId) = _BlockUser;


}
