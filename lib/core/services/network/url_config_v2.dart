import 'url_config.dart';

/// Base URL and endpoint paths for the v2 API. Authentication has migrated
/// to /api/v2 (register, login, oauth-login, username availability,
/// password reset, OTP) — every other feature still uses [UrlConfig]'s
/// /api/v1 base until it migrates too.
class UrlConfigV2 {
  UrlConfigV2._();

  static const String DEV_BASE_URL_V2 =
      String.fromEnvironment('DEV_BASE_URL_V2');
  static const String PROD_BASE_URL_V2 =
      String.fromEnvironment('PROD_BASE_URL_V2');

  static final String coreBaseUrl =
      UrlConfig.environment == Environment.production
          ? PROD_BASE_URL_V2
          : DEV_BASE_URL_V2;

  // Authentication
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String oauthLogin = '/auth/oauth-login';
  static const String usernameAvailable = '/auth/username/available';
  static const String forgotPassword = '/auth/password/forgot';
  static const String passwordReset = '/auth/password/reset';
  static const String sendOtp = '/auth/otp/request';
  static const String verifyOtp = '/auth/otp/verify';

  // User
  static const String me = '/user/me';
  static const String getAvatars = '/profile/avatars';
  static const String updateProfile = '/user/profile/update';

  // Onboarding
  static const String setUserType = '/user/onboarding/user-type';
  static const String completeOnboarding = '/user/onboarding/complete';

  // Privacy
  static const String getConsents = '/user/consents';
  static const String updateConsents = '/user/consents';
  static const String privacyPolicies = '/user/privacy-policies';

  // Feed / Posts
  static const String posts = '/user/posts';
  static String postDetail(String id) => '$posts/$id';
  static const String postReaction = '$posts/reaction';
  static const String postStatsSave = '$posts/stats/save';
  static const String postStatsFetch = '$posts/stats/fetch';

  // Mood
  static const String moodCheckins = '/user/mood-checkins';
}
