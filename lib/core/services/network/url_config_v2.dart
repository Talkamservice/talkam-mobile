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
  static const String registerTherapist = '/auth/register-therapist';
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
  static String updateProfile = '/user/profile/update';
  static const String saveInterests = '/user/profile/interests';

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
  static const String reportPost = '$posts/report';
  static const String reportComment = '$posts/report-comment';
  static const String notInterested = '$posts/not-interested';
  static const String postDrafts = '/user/post-drafts';

  // Comments
  static const String postComments = '/user/post-comments';
  static const String postCommentReaction = '$postComments/reaction';

  // Guidelines
  static const String guidelines = '/user/guidelines';

  // Interest topics — the onboarding interest chips (post_categories rows
  // marked type=interest_topic).
  static const String interestTopics = '/user/interest-topics';

  // Drawer — one aggregate call: profile card, follow counts, followed
  // topics, groups + private groups.
  static const String drawer = '/user/drawer';

  // Follows
  static const String followToggle = '/user/follows/toggle';
  static const String following = '/user/follows/following';
  static const String followers = '/user/follows/followers';

  // Mutes
  static const String muteToggle = '/user/mutes/toggle';
  static const String mutedUsers = '/user/mutes';

  // Blocked users
  static const String blockedUsersAdd = '/user/blocked-users/add';
  static const String blockedUsers = '/user/blocked-users';

  // Mood
  static const String moodCheckins = '/user/mood-checkins';

  // Groups
  static const String groups = '/user/groups';
  static String groupDetail(String id) => '$groups/$id';
  static const String groupMembers = '/user/group-members';
  static const String unfollowGroup = '$groups/unfollow-group';
  static const String groupFollowToggle = '$groups/follow';
  static const String followedGroups = '$groups/members/following';
  static const String suggestedGroups = '$groups/suggested';
  static String inviteToGroup(String id) => '$groups/$id/invite';
  static const String acceptGroupInvite = '$groups/invites/accept';
  static String requestGroupAccess(String id) => '$groups/$id/request-access';
  static const String reportGroup = '$groups/reports/create';

  // Search
  static const String search = '/user/search';
  static const String recentSearches = '/user/search/recent';
  static const String trendingSearches = '/user/search/trending';
  static String deleteSearch(String id) => '/user/search/$id/delete';

  // Therapist application (5-step onboarding wizard)
  static const String therapistApplicationStatus = '/therapist/application';
  static const String therapistApplicationPersonal =
      '/therapist/application/personal';
  static const String therapistApplicationDocuments =
      '/therapist/application/documents';
  static String therapistApplicationDocument(String id) =>
      '$therapistApplicationDocuments/$id';
  static const String therapistApplicationSpecialties =
      '/therapist/application/specialties';
  static const String therapistApplicationAvailability =
      '/therapist/application/availability';
  static const String therapistBanks = '/therapist/banks';
  static const String therapistVerifyAccount =
      '/therapist/payout-account/verify';
  static const String therapistApplicationPayout =
      '/therapist/application/payout';
  static const String therapistApplicationSubmit =
      '/therapist/application/submit';

  // Messaging — conversations
  static const String messagingConversations = '/user/messaging/conversations';

  /// mute | unmute | archive | unarchive | star | unstar | seen.
  static String conversationState(String action) =>
      '$messagingConversations/$action';

  // Messaging — messages. Paths are unchanged from v1, just moved to the v2
  // base — see MessagingRepositoryImpl.
  static const String messagingMessagesList = '/user/messaging/messages/list';
  static const String messagingMessagesSend = '/user/messaging/messages/send';

  // Therapist — clients roster & session notes
  static const String therapistClients = '/therapist/clients';
  static String therapistClientDetail(int id) => '$therapistClients/$id';
  static String therapistClientTreatmentPlan(int id) =>
      '$therapistClients/$id/treatment-plan';
  static String therapistSessionNotes(int sessionId) =>
      '/therapist/sessions/$sessionId/notes';
  static const String therapistSessions = '/therapist/sessions';
  static const String therapistNotesLibrary = '/therapist/notes';
  static const String therapistOwnProfile = '/therapist/profile';
  static const String therapistOwnProfileUpdate = '/therapist/profile/update';

  // Therapist Directory & Booking
  static const String therapistDirectory = '/user/therapists';
  static String therapistProfile(int id) => '/user/therapists/$id';
  static String therapistSlots(int id) => '/user/therapists/$id/slots';
  static String therapistReviews(int id) => '/user/therapists/$id/reviews';

  // Bookings (consumer-facing)
  static const String bookings = '/user/bookings';
  static String bookingDetail(int id) => '/user/bookings/$id';
  static String initiatePayment(int id) =>
      '/user/bookings/$id/initiate-payment';
  static String reviewBooking(int id) => '/user/bookings/$id/review';

  // Payment callback
  static const String paymentCallback = '/finance/payments/callback';

  // Notification & privacy preferences
  static const String notificationPreferences =
      '/user/notification-preferences';
  static const String privacySettings = '/user/privacy-settings';

  // Payment methods & PIN
  static const String paymentMethods = '/user/payment-methods';
  static String deletePaymentMethod(String id) => '$paymentMethods/$id';
  static const String paymentPin = '/user/security/payment-pin';

  // Data export
  static const String dataExport = '/user/data-export';
  static const String dataExportLatest = '/user/data-export/latest';

  // Account
  static const String deleteAccount = '/user/profile/delete-account';

  // Reports — one open report per (reporter, target).
  static const String userReports = '/user/user-reports';
}
