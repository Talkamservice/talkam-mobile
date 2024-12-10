import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';

mixin ReturningUserMixin<T extends StatefulWidget> on State<T> {
  void gotoNextScreen(BuildContext context, TalkamUser state) {
    if (state.emailVerifiedAt == null) {
      context.pushNamed(PageUrl.verifyOtpScreen, queryParameters: {PathParam.email: state.email, PathParam.otpType: VerifyOtpType.returningUser.name});

      AuthBloc(injector.get()).add(SendOtpEvent(state.email, "verify_email"));
    } else if (state.interests.isEmpty) {
      context.goNamed(PageUrl.interestsScreen);
    } else if (state.username.isEmpty) {
      context.goNamed(PageUrl.userNameScreen);
    } else {
      injector.get<PostBloc>().add(const PostEvent.getGuidelines());
      injector.get<PostBloc>().add(const PostEvent.getCategories());
      SessionManager().hasOnboarded = true;
      context.goNamed(PageUrl.homeScreen);
    }
  }
}
