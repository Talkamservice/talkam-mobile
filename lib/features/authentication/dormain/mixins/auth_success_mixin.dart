import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/constants/dev_flags.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';

mixin AuthSuccessMixin<T extends StatefulWidget> on State<T> {

  void handleLoginSuccess(BuildContext context, TalkamUser state) {
    if (state.emailVerifiedAt == null) {
      context.pushNamed(PageUrl.verifyOtpScreen, queryParameters: {
        PathParam.email: state.email,
        PathParam.otpType: VerifyOtpType.auth.name
      });

    } else if (!kSkipInterestsGate && state.interests.isEmpty) {

      // Onboarding isn't finished — pick the account type before interests.
      context.goNamed(PageUrl.userTypeSelectionScreen);

    } else if (state.username.isEmpty || state.avatar == null) {

      context.goNamed(PageUrl.userNameScreen);

    } else {

      SessionManager().hasOnboarded = true;
      context.goNamed(PageUrl.homeScreen);
    }
  }
}
