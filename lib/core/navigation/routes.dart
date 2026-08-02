import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screen.dart';
import 'package:talkam/features/ads/presentation/screens/empty_ad_page.dart';
import 'package:talkam/features/authentication/presentation/screens/email_sent_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/interests_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/intro_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/login_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/password_recovery_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/password_reset_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/signup_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/get_started_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/splash_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/anonymous_signin_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_availability_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_onboarding_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_payout_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_personal_info_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_qualifications_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_requirements_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_specialties_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/therapist/therapist_verification_pending_screen.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';
import 'package:talkam/features/authentication/presentation/screens/user_type_selection_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/username_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:talkam/features/group/data/models/create_group_payload.dart';
import 'package:talkam/features/group/presentation/screens/create_group/add_group_rules_screen.dart';
import 'package:talkam/features/group/presentation/screens/create_group/create_group_screen.dart';
import 'package:talkam/features/group/presentation/screens/create_group/create_group_success_screen.dart';
import 'package:talkam/features/group/presentation/screens/group_details_screen.dart';
import 'package:talkam/features/group/presentation/screens/group_info_screen.dart';
import 'package:talkam/features/group/presentation/screens/group_members_screen.dart';
import 'package:talkam/features/group/presentation/screens/groups_screen.dart';
import 'package:talkam/features/group/presentation/screens/create_group/preview_group_screen.dart';
import 'package:talkam/features/group/presentation/screens/pending_requests_screen.dart';
import 'package:talkam/features/home/presentation/screens/base_page.dart';
import 'package:talkam/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:talkam/features/earnings/presentation/screens/earnings_screen.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/wellness/presentation/screens/wellness_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/messages_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/new_message_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/new_request_screen.dart';
import 'package:talkam/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/screens/post_details_screen.dart';
import 'package:talkam/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:talkam/features/profile/presentation/screens/profile_screen.dart';
import 'package:talkam/features/profile/presentation/screens/sceduled_posts_screen.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/settings/presentation/screens/account_settings_screen.dart';
import 'package:talkam/features/settings/presentation/screens/blocked_users_screen.dart';
import 'package:talkam/features/settings/presentation/screens/change_password_screen.dart';
import 'package:talkam/features/settings/presentation/screens/delete_account_screen.dart';
import 'package:talkam/features/settings/presentation/screens/notifications_settings_screen.dart';
import 'package:talkam/features/settings/presentation/screens/settings_screen.dart';
import 'package:talkam/features/profile/presentation/screens/user_profile_screen.dart';
import 'package:talkam/features/search/presentation/screens/search_result_screen.dart';
import 'package:talkam/features/subscription/presentation/screens/subscription_screen.dart';

import '../../common/widgets/custom_dialogs.dart';
import '../../features/authentication/presentation/screens/onboarding.dart';
import '../../features/authentication/presentation/screens/welcome_screen.dart';
import '../../features/privacy/presentation/screens/data_privacy_screen.dart';
import '../services/data/session_manager.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'shellE');
final _shellNavigatorFKey = GlobalKey<NavigatorState>(debugLabel: 'shellF');
final _shellNavigatorGKey = GlobalKey<NavigatorState>(debugLabel: 'shellG');
final _shellNavigatorHKey = GlobalKey<NavigatorState>(debugLabel: 'shellH');

/// Tabs inside the main app shell. A guest reaching any of these without an
/// alias is bounced to the anonymous sign-in screen first.
const _shellPaths = <String>{
  '/homeScreen',
  '/groups',
  '/messagingScreen',
};

/// Guests must choose an alias before entering the app.
///
/// This is enforced at the router rather than on each button, so no entry
/// point — current or future — can land a guest in the shell without one.
String? _requireAliasForGuests(BuildContext context, GoRouterState state) {
  if (SessionManager.instance.isLoggedIn) return null;
  if (SessionManager.instance.anonymousUsername.isNotEmpty) return null;
  if (!_shellPaths.contains(state.matchedLocation)) return null;

  return '/anonymousSignInScreen';
}

class CustomRoutes {
  static final goRouter = GoRouter(
    observers: [
      // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
    ],
    initialLocation: '/splash',
    // initialLocation: '/profile/setupProfileIntroPage/setupProfilePage',
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: _requireAliasForGuests,
    routes: [
      GoRoute(
        path: '/splash',
        name: PageUrl.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/getStarted',
        name: PageUrl.getStartedScreen,
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(
        path: '/onboardingIntro',
        name: PageUrl.onboardingIntro,
        builder: (context, state) => const IntroScreen(),
      ),
      GoRoute(
        path: '/login',
        name: PageUrl.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signUp',
        name: PageUrl.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/verifyOtpScreen',
        name: PageUrl.verifyOtpScreen,
        builder: (context, state) => VerifyOtpScreen(
            email: state.uri.queryParameters[PathParam.email] ?? '',
            verifyOtpType: verifyOtpFromString(
              state.uri.queryParameters[PathParam.otpType] ?? '',
            )),
      ),
      GoRoute(
        path: '/passwordRecoveryScreen',
        name: PageUrl.passwordRecoveryScreen,
        builder: (context, state) => const PassWordRecoveryScreen(),
      ),
      GoRoute(
        path: '/emailSentScreen',
        name: PageUrl.emailSentScreen,
        builder: (context, state) => const EmailSentScreen(),
      ),
      GoRoute(
        path: '/anonymousSignInScreen',
        name: PageUrl.anonymousSignInScreen,
        builder: (context, state) => const AnonymousSignInScreen(),
      ),
      GoRoute(
        path: '/userTypeSelectionScreen',
        name: PageUrl.userTypeSelectionScreen,
        builder: (context, state) => const UserTypeSelectionScreen(),
      ),
      GoRoute(
        path: '/therapistOnboardingScreen',
        name: PageUrl.therapistOnboardingScreen,
        builder: (context, state) => const TherapistOnboardingScreen(),
      ),
      GoRoute(
        path: '/therapistRequirementsScreen',
        name: PageUrl.therapistRequirementsScreen,
        builder: (context, state) => TherapistRequirementsScreen(
          bloc: state.extra as TherapistApplicationBloc,
        ),
      ),
      GoRoute(
        path: '/therapistPersonalInfoScreen',
        name: PageUrl.therapistPersonalInfoScreen,
        builder: (context, state) => TherapistPersonalInfoScreen(
          bloc: state.extra as TherapistApplicationBloc,
        ),
      ),
      GoRoute(
        path: '/therapistQualificationsScreen',
        name: PageUrl.therapistQualificationsScreen,
        builder: (context, state) => TherapistQualificationsScreen(
          bloc: state.extra as TherapistApplicationBloc,
        ),
      ),
      GoRoute(
        path: '/therapistSpecialtiesScreen',
        name: PageUrl.therapistSpecialtiesScreen,
        builder: (context, state) => TherapistSpecialtiesScreen(
          bloc: state.extra as TherapistApplicationBloc,
        ),
      ),
      GoRoute(
        path: '/therapistAvailabilityScreen',
        name: PageUrl.therapistAvailabilityScreen,
        builder: (context, state) => TherapistAvailabilityScreen(
          bloc: state.extra as TherapistApplicationBloc,
        ),
      ),
      GoRoute(
        path: '/therapistPayoutScreen',
        name: PageUrl.therapistPayoutScreen,
        builder: (context, state) => TherapistPayoutScreen(
          bloc: state.extra as TherapistApplicationBloc,
        ),
      ),
      GoRoute(
        path: '/therapistVerificationPendingScreen',
        name: PageUrl.therapistVerificationPendingScreen,
        builder: (context, state) => const TherapistVerificationPendingScreen(),
      ),
      GoRoute(
        path: '/interestsScreen',
        name: PageUrl.interestsScreen,
        builder: (context, state) => const InterestsScreen(),
      ),
      GoRoute(
        path: '/userNameScreen',
        name: PageUrl.userNameScreen,
        builder: (context, state) => const UsernameScreen(),
      ),
      GoRoute(
        path: '/dataPrivacyScreen',
        name: PageUrl.dataPrivacyScreen,
        builder: (context, state) => const DataPrivacyScreen(),
      ),
      GoRoute(
        path: '/welcomeScreen',
        name: PageUrl.welcomeScreen,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/editProfileScreen',
        name: PageUrl.editProfileScreen,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/userScheduledPosts',
        name: PageUrl.userScheduledPosts,
        builder: (context, state) => const ScheduledPostsScreen(),
      ),
      GoRoute(
        path: '/passWordResetScreen',
        name: PageUrl.passWordResetScreen,
        builder: (context, state) => PassWordResetScreen(
          otp: state.uri.queryParameters[PathParam.otp] ?? "",
          email: state.uri.queryParameters[PathParam.email] ?? "",
        ),
      ),
      GoRoute(
        path: '/postDetailsScreen',
        name: PageUrl.postDetailsScreen,
        builder: (context, state) => state.extra is TalkamPost
            ? PostDetailsScreen(post: state.extra as TalkamPost)
            : PostDetailsScreen(postId: state.extra as String),
      ),
      GoRoute(
        path: '/${PageUrl.profileScreen}',
        name: PageUrl.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/${PageUrl.settingsScreen}',
        name: PageUrl.settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/${PageUrl.userProfileScreen}',
        name: PageUrl.userProfileScreen,
        builder: (context, state) => UserProfileScreen(
          userId: state.extra as String,
        ),
      ),
      GoRoute(
        path: '/${PageUrl.blockedUsersScreen}',
        name: PageUrl.blockedUsersScreen,
        builder: (context, state) => const BlockedUsersScreen(
            // userId: state.extra as String,
            ),
      ),
      GoRoute(
        path: '/${PageUrl.accountSettingsScreen}',
        name: PageUrl.accountSettingsScreen,
        builder: (context, state) => const AccountSettingsScreen(
            // userId: state.extra as String,
            ),
      ),
      GoRoute(
        path: '/${PageUrl.deleteAccountScreen}',
        name: PageUrl.deleteAccountScreen,
        builder: (context, state) => const DeleteAccountScreen(
            // userId: state.extra as String,
            ),
      ),
      GoRoute(
        path: '/${PageUrl.notificationSettingsScreen}',
        name: PageUrl.notificationSettingsScreen,
        builder: (context, state) => const NotificationsSettingsScreen(
            // userId: state.extra as String,
            ),
      ),
      GoRoute(
        path: '/${PageUrl.changePasswordScreen}',
        name: PageUrl.changePasswordScreen,
        builder: (context, state) => const ChangePasswordScreen(
            // userId: state.extra as String,
            ),
      ),
      GoRoute(
        path: '/searchResultScreen',
        name: PageUrl.searchResultScreen,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          String query = '';
          int initialTab = 0;
          if (state.extra is String) {
            query = state.extra as String;
          } else if (state.extra is Map<String, dynamic>) {
            final map = state.extra as Map<String, dynamic>;
            query = map['query'] as String? ?? '';
            initialTab = map['initialTab'] as int? ?? 0;
          }
          return SearchResultScreen(
            query: query,
            initialTab: initialTab,
          );
        },
      ),
      GoRoute(
        path: '/groupsInfoScreen',
        name: PageUrl.groupsInfoScreen,
        builder: (context, state) => GroupInfoScreen(
          groupId: state.extra as String,
        ),
      ),
      GoRoute(
        path: '/groupDetailsScreen',
        name: PageUrl.groupDetailsScreen,
        builder: (context, state) => GroupDetailsScreen(
          group: state.extra as TalkamGroup,
        ),
      ),
      GoRoute(
        path: '/groupMembersScreen',
        name: PageUrl.groupMembersScreen,
        builder: (context, state) => const GroupMembersScreen(
            // query: state.extra as String,
            ),
      ),
      GoRoute(
        path: '/groupRequestsScreen',
        name: PageUrl.groupRequestsScreen,
        builder: (context, state) => Container(
            // query: state.extra as String,
            ),
      ),
      GoRoute(
        path: '/createGroupScreen',
        name: PageUrl.createGroupScreen,
        builder: (context, state) => CreateGroupScreen(
          group: state.extra as TalkamGroup?,
          // query: state.extra as String,
        ),
      ),
      GoRoute(
        path: '/createGroupRulesScreen',
        name: PageUrl.createGroupRulesScreen,
        builder: (context, state) => const AddGroupRulesScreen(
            // query: state.extra as String,
            ),
      ),
      GoRoute(
        path: '/previewGroupScreen',
        name: PageUrl.previewGroupScreen,
        builder: (context, state) => PreviewGroupScreen(
          payload: state.extra as PreviewGroupScreenParam,
        ),
      ),
      GoRoute(
        path: '/createGroupSuccessScreen',
        name: PageUrl.createGroupSuccessScreen,
        builder: (context, state) {
          return CreateGroupSuccessScreen(
            payload: state.extra as TalkamGroup,
          );
        },
      ),
      GoRoute(
        path: '/chatScreen',
        name: PageUrl.chatScreen,
        pageBuilder: (context, state) => NoTransitionPage(
          child: ChatScreen(
            param: state.extra as ChatScreenParam,
          ),
        ),
      ),
      GoRoute(
        path: '/new_requestScreen',
        name: PageUrl.new_requestScreen,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: NewRequestScreen(),
        ),
      ),
      GoRoute(
        path: '/new_messageScreen',
        name: PageUrl.new_messageScreen,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: NewMessageScreen(),
        ),
      ),
      GoRoute(
        path: '/notificationScreen',
        name: PageUrl.notificationScreen,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: NotificationsScreen(),
        ),
      ),
      GoRoute(
        path: '/messagingScreen',
        name: PageUrl.messagingScreen,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: MessagesScreen(),
        ),
      ),
      GoRoute(
        path: '/adsPage',
        name: PageUrl.adsPage,
        pageBuilder: (context, state) => NoTransitionPage(
          child: AdsReviewScreen(),
        ),
      ),
      GoRoute(
        path: '/pendingRequestsScreen',
        name: PageUrl.pendingRequestsScreen,
        pageBuilder: (context, state) => NoTransitionPage(
          child: PendingRequestsScreen(
            groupId: state.extra as String,
          ),
        ),
      ),
      GoRoute(
        path: '/subscriptionScreen',
        name: PageUrl.subscriptionScreen,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SubscriptionScreen(),
        ),
      ),
      GoRoute(
        path: '/createAdsScreen',
        name: PageUrl.createAdsScreen,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AdsFlowPage(),
        ),
      ),
      GoRoute(
        path: '/onboardingScreen',
        name: PageUrl.onboardingScreen,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnboardingScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BasePage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/homeScreen',
                name: PageUrl.homeScreen,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
                routes: const [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              GoRoute(
                path: '/groups',
                name: PageUrl.groups,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: GroupsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorEKey,
            routes: [
              GoRoute(
                path: '/wellnessScreen',
                name: PageUrl.wellnessScreen,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: WellnessScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorFKey,
            routes: [
              GoRoute(
                path: '/calendarScreen',
                name: PageUrl.calendarScreen,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CalendarScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorGKey,
            routes: [
              GoRoute(
                path: '/earningsScreen',
                name: PageUrl.earningsScreen,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: EarningsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHKey,
            routes: [
              GoRoute(
                path: '/profileTabScreen',
                name: PageUrl.profileTabScreen,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  static VerifyOtpType verifyOtpFromString(String value) {
    switch (value.toLowerCase()) {
      case 'auth':
        return VerifyOtpType.auth;
      case 'passwordreset':
        return VerifyOtpType.passwordReset;
      case 'returninguser':
        return VerifyOtpType.returningUser;
      default:
        throw ArgumentError('Invalid VerifyOtpType string: $value');
    }
  }
}
