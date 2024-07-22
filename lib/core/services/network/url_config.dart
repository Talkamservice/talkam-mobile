enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.production;

  static const String STAGING_URL = String.fromEnvironment('DEV_BASE_URL');
  static const String PRODUCTION_URL = String.fromEnvironment('PROD_BASE_URL');

  static const String imageBaseUrl = String.fromEnvironment('IMAGE_BASE_URL');
  static const String dojahTestAppId = String.fromEnvironment('DOJAH_APP_ID');
  static const String dojahTestPublicKey =
      String.fromEnvironment('DOJAH_PUBLIC_KEY');
  static const String stripeTestKey = String.fromEnvironment('STRIPE_TEST_KEY');
  static const String stripeSecretKey =
      String.fromEnvironment('STRIPE_SECRET_KEY');
  static const String facePlusTestApiKey =
      String.fromEnvironment('FACE_PLUS_TEST_API_KEY');
  static const String facePlusTestApiSecret =
      String.fromEnvironment('FACE_PLUS_TEST_API_SECRET');
  static const String messageUserEmail =
      String.fromEnvironment('MESSAGE_USER_EMAIL');
  static const String messageUserPassKey =
      String.fromEnvironment('MESSAGE_USER_PASSKEY');

  // static const String facePlusProdApiKey =
  //     String.fromEnvironment('FACE_PLUS_PROD_API_KEY');
  // static const String facePlusProdApiSecret =
  //     String.fromEnvironment('FACE_PLUS_PROD_API_SECRET');
  static final coreBaseUrl =
      environment == Environment.production ? PRODUCTION_URL : STAGING_URL;

  static const String getLibraryCoursesEndpoint =
      "/wellness-library/courses/list";

  static const String getNotificationDetailsEndpoint =
      "/getNotificationDetailsEndpoint";

  static const String clearNotifications = "/notifications/clear-all";

  static String readNotificationEndpoint(String id) =>
      "/notifications/$id/show";

  static String getNotificationsEndpoint = '/notifications/list';

  static String deleteAccountEndpoint = '/user/profile/delete-account';

  static String eraseDataEndpoint = '/user/profile/erase-account-data';

  static String getCourseDetails(String id) =>
      "/wellness-library/courses/show/$id";
  static const String getFavourites = "/wellness-library/courses/favourites";
  static const String updateFavourite =
      "/wellness-library/courses/save-to-favourite";
  static const String getLibraryCategoriesEndpoint =
      "/wellness-library/categories/list";
  static const String getConversationStarterEndpoint =
      "/user/conversation-starter/get";

  //SOS
  static const String getEmergencyContacts = '/emergency-contacts/list';

  // Authentication
  static const String login = '/auth/login';
  static const String me = '/auth/me';
  static const String loginPreview = "/auth/login/preview";

  static String getUser(String userId) => '/auth/user/$userId';
  static const String verifyOtp = '/auth/otp/verify';
  static const String register = '/auth/register';
  static const String oauthLogin = '/auth/oauth-login';
  static const String sendOtp = '/auth/otp/request';
  static const String forgotPassword = '/auth/password/forgot';
  static const String passwordReset = '/auth/password/reset';

  ///ACCOUNT
  static const String updateProfile = '/user/profile/update';
  static const String getAvaters = '/user/profile/avatars';
  static const String changePassword = '/user/passcode/change-password';
  static const String verifyPasscode = '/user/passcode/verify';
  static const String updatePassword = '/user/passcode/update';
  static const String allowNotifications = 'general/account/allow-notification';
  static const String resetPassword = '/auth/password/reset';
  static const String getAvatars = '/profile/avatars';
  static const String blockUser = '/user/blocked-users/add';
  static const String uploadAvatar = '/user/profile/upload-avatar';
  static const String getProfile = '/user/me';

//   POST
  static const String getCategories = '/user/post-categories';
  static const String getPosts = '/user/posts';
  static const String createPost = '/user/posts';

  static String getPostDetails(String id) => '/user/posts/$id';
  static const String deletePosts = '/user/posts';
  static const String postReaction = '/user/posts/reaction';
  static const String reportPost = '/user/posts/report';
  static const String getPolls = '/user/posts-polls';

  static const String getComments = '/user/post-comments';
  static const String getAComment = '/user/post-comments';
  static const String saveAComment = '/user/post-comments';
  static const String deleteComment = '/user/post-comments';
  static const String commentReaction = '/user/post-comments/reaction';


  static const String selectPoll = '/user/post-polls/';
  static const String deletePoll = '/user/post-polls/';
}
