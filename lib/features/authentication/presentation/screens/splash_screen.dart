import 'package:flutter/material.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/features/authentication/presentation/widgets/app_logo.dart';

import '../../../../core/constants/package_exports.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/data/session_manager.dart';
import '../../../profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with ReturningUserMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  /// Key used to call [AppLogoWidgetState.forward] after the first frame.
  final GlobalKey<AppLogoWidgetState> _logoKey =
      GlobalKey<AppLogoWidgetState>();

  @override
  void initState() {
    super.initState();

    // Start the logo animation on the first rendered frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logoKey.currentState?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Short pause after animation settles, then navigate.
          Future.delayed(const Duration(milliseconds: 500), _goToNextScreen);
        }
      });
      _logoKey.currentState?.forward();
    });
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
      body: ClipRect(
        child: Center(
          child: IgnorePointer(
            child: AppLogoWidget(
              key: _logoKey,
              iconHeight: 72,
            ),
          ),
        ),
      ),
    );
  }

  void _goToNextScreen() {
    if (SessionManager.instance.isLoggedIn) {
      gotoNextScreen(context, injector.get<ProfileBloc>().appUser!);
    } else {
      if (SessionManager().hasOnboarded) {
        context.goNamed(PageUrl.getStartedScreen);
      } else {
        context.goNamed(PageUrl.onboardingScreen);
      }
    }
  }
}
