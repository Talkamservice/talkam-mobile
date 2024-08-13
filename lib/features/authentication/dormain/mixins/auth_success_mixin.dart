import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';

mixin AuthSuccessMixin<T extends StatefulWidget> on State<T> {
  void handleLoginSuccess(BuildContext context, TalkamUser state) {
    if (state.emailVerifiedAt == null) {
      context.pushNamed(PageUrl.verifyOtpScreen, queryParameters: {
        PathParam.email: state.email,
        PathParam.otpType: VerifyOtpType.auth.name
      });

    } else if (state.interests.isEmpty) {

      context.goNamed(PageUrl.interestsScreen);

    } else if (state.username.isEmpty || state.avatar == null) {

      context.goNamed(PageUrl.userNameScreen);

    } else {
      context.goNamed(PageUrl.homeScreen);
    }
  }
}
