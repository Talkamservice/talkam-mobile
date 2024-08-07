import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/settings/data/models/blocked_users_response.dart';
import 'package:talkam/features/settings/data/models/notification_preference_response.dart';
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
}
