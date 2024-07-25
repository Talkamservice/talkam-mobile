import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
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
import 'package:talkam/features/group/presentation/screens/groups_screen.dart';
import 'package:talkam/features/home/presentation/screens/base_page.dart';
import 'package:talkam/features/home/presentation/screens/home_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/messages_screen.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/screens/categories_screen.dart';
import 'package:talkam/features/post/presentation/screens/create_post_screen.dart';
import 'package:talkam/features/post/presentation/screens/post_details_screen.dart';
import 'package:talkam/features/profile/presentation/screens/profile_screen.dart';
import 'package:talkam/features/profile/presentation/screens/settings_screen.dart';
import 'package:talkam/features/search/presentation/screens/search_screen.dart';

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
          post: state.extra as TalkamPost,
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
        path: '/createPostScreen',
        name: PageUrl.createPostScreen,
        builder: (context, state) => const CreatePostScreen(),
      ),
      GoRoute(
        path: '/categoriesScreen',
        name: PageUrl.categoriesScreen,
        builder: (context, state) => const CategoriesScreen(),
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
          // StatefulShellBranch(
          //   navigatorKey: _shellNavigatorEKey,
          //   routes: [
          //     GoRoute(
          //       path: '/profileTab',
          //       name: PageUrl.profileTab,
          //       pageBuilder: (context, state) => const NoTransitionPage(
          //         child: ProfileTab(),
          //       ),
          //       routes: const [],
          //     ),
          //   ],
          // ),
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
