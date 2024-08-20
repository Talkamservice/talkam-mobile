enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.production;

  static const String STAGING_URL = String.fromEnvironment('DEV_BASE_URL');
  static const String PRODUCTION_URL = String.fromEnvironment('PROD_BASE_URL');

  static const String WEB_STAGING_URL =
      String.fromEnvironment('WEB_DEV_BASE_URL');
  static const String WEB_PRODUCTION_URL =
      String.fromEnvironment('WEB_PROD_BASE_URL');

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
  static final webUrl = environment == Environment.production
      ? WEB_PRODUCTION_URL
      : WEB_STAGING_URL;

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

  static String getUser = '/user/profile/fetch';
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
  static const String user = '/user/me';

//   POST
  static const String getCategories = '/user/post-categories';
  static const String getSubCategories = '/user/post-categories/sub-categories';
  static const String getPosts = '/user/posts';
  static const String createPost = '/user/posts';

  static String getPostDetails(String id) => '/user/posts/$id';

  static String deletePosts(String id) => '/user/posts/$id';
  static const String postReaction = '/user/posts/reaction';
  static const String reportPost = '/user/posts/report';

  static const String reportComment = '/user/posts/report-comment';
  static const String getPolls = '/user/posts-polls';

  static const String getComments = '/user/post-comments';
  static const String getAComment = '/user/post-comments';
  static const String saveAComment = '/user/post-comments';

  static String deleteComment(String id) => '/user/post-comments/$id';
  static const String commentReaction = '/user/post-comments/reaction';

  static const String getRules = '/user/guildlines';
  static const String selectPoll = '/user/post-polls/';
  static const String deletePoll = '/user/post-polls/';
  static String addOrRemoveInterest = '/user/profile/interests/add-remove';

  // SETTINGS

  static const String fetchNotificationPreferences =
      '/user/notifications/preference/fetch';
  static const String saveNotificationPreferences =
      '/user/notifications/preference/save';
  static const String fetchBlockedUsers = '/user/blocked-users';
  static const String linkSocialAccount = '/user/profile/link-social-account';
  static const String unlinkSocialAccount =
      '/user/profile/unlink-social-account';
  static const String deleteAccount = '/user/profile/delete-account';

//   Search
  static const String fetchRecentSearches = '/user/search/recent';
  static const String search = '/user/search';
  static const String fetchTrendingSearches = '/user/search/trending';
  static const String deleteSearch = '/user/search';
  static const String fetchSearchSuggestions = '/user/search/suggestions';


  static const String getGroups = '/user/groups';
  static const String getFollowingGroupMembers = '/user/groups/members/following';
  static const String updateGroup = '/user/groups/';
  static const String getGroup = '/user/groups/';
  static const String deleteGroup = '/user/groups/';
  static const String createGroup = '/user/groups/';


  static const String getPendingGroupMembers = '/user/group-members';
  static const String requestAccess = '/user/groups/';
  static const String updateAccessRequest = '/user/groups/';
  static const String deleteGroupMember = '/user/group-members/';

  static const String getGroupMembers = '/user/group-members';
  static const String addGroupMember = '/user/group-members';
  static const String updateMemberRole = '/user/group-members/';
  static const String getMember = '/user/group-members/';
  static const String deleteMember = '/user/group-members/';
  static const String groupMembers = '/user/group-members/';

}
