import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow.dart';
import 'package:talkam/features/ads/presentation/screens/ads_page.dart';
import 'package:talkam/features/authentication/presentation/screens/email_sent_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/interests_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/intro_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/login_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/password_recovery_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/password_reset_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/signup_screen.dart';
import 'package:talkam/features/authentication/presentation/screens/splash_screen.dart';
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
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/messages_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/new_message_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/new_request_screen.dart';
import 'package:talkam/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/screens/categories_screen.dart';
import 'package:talkam/features/post/presentation/screens/create_post_screen.dart';
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
import 'package:talkam/features/search/presentation/screens/search_screen.dart';
import 'package:talkam/features/subscription/presentation/screens/subscription_screen.dart';

import '../../common/widgets/custom_dialogs.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

class CustomRoutes {
  static final goRouter = GoRouter(
    observers: [
      // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
    ],
    initialLocation: '/splash',
    // initialLocation: '/profile/setupProfileIntroPage/setupProfilePage',
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: PageUrl.splash,
        builder: (context, state) => const SplashScreen(),
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
        ),
      ),
      GoRoute(
        path: '/postDetailsScreen',
        name: PageUrl.postDetailsScreen,
        builder: (context, state) => PostDetailsScreen(
          postId: state.extra as String,
        ),
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
        path: '/createPostScreen',
        name: PageUrl.createPostScreen,
        builder: (context, state) => const CreatePostScreen(),
      ),
      GoRoute(
        path: '/categoriesScreen',
        name: PageUrl.categoriesScreen,
        builder: (context, state) => CategoriesScreen(
          category: state.extra as PostCategory,
        ),
      ),
      GoRoute(
        path: '/searchResultScreen',
        name: PageUrl.searchResultScreen,
        builder: (context, state) => SearchResultScreen(
          query: state.extra as String,
        ),
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
        path: '/adsPage',
        name: PageUrl.adsPage,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AdsPage(),
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
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: '/search',
                name: PageUrl.search,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SearchScreen(),
                ),
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
            navigatorKey: _shellNavigatorDKey,
            routes: [
              GoRoute(
                path: '/messagingScreen',
                name: PageUrl.messagingScreen,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: MessagesScreen(),
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
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
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
