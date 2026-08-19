import 'package:flutter/material.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/features/authentication/presentation/widgets/app_logo.dart';

import '../../../../core/constants/package_exports.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/data/session_manager.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_bloc.dart';

import '../../../profile/dormain/repository/profile_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with ReturningUserMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Brief pause so the splash isn't an instant flash before navigating on.
    Future.delayed(const Duration(milliseconds: 900), _goToNextScreen);
  }

  @override
  void dispose() {
    dialogKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: const Center(
        child: AppLogoWidget(iconHeight: 72),
      ),
    );
  }

  Future<void> _goToNextScreen() async {
    if (SessionManager.instance.isLoggedIn) {
      // Fetch fresh remote user data from /user/me on launch to validate current onboarding state
      try {
        final remoteUser =
            await injector.get<ProfileRepository>().fetchUserProfile();
        if (remoteUser != null) {
          injector.get<ProfileBloc>().add(SaveUserLocallyEvent(remoteUser));
          if (mounted) {
            gotoNextScreen(context, remoteUser);
            return;
          }
        }
      } catch (_) {}

      final user = injector.get<ProfileBloc>().appUser;
      if (user != null && mounted) {
        gotoNextScreen(context, user);
      } else if (mounted) {
        context.goNamed(PageUrl.getStartedScreen);
      }
    } else {
      if (SessionManager().hasOnboarded) {
        context.goNamed(PageUrl.getStartedScreen);
      } else {
        context.goNamed(PageUrl.onboardingScreen);
      }
    }
  }
}
