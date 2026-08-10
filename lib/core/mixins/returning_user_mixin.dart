import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/constants/dev_flags.dart';
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
      context.pushNamed(PageUrl.verifyOtpScreen, queryParameters: {
        PathParam.email: state.email,
        PathParam.otpType: VerifyOtpType.returningUser.name
      });

      AuthBloc(injector.get()).add(SendOtpEvent(state.email, "verify_email"));
      return;
    }

    // The v2 `/user/me` payload (fetched via GetRemoteUser) carries a
    // server-computed onboarding summary — resume at its first false step.
    // Login/register responses don't include it, so fall back to the old
    // field-based heuristic until the next `/user/me` refresh lands.
    final onboarding = state.onboarding;
    if (onboarding != null) {
      // `completedAt` is the authoritative signal — some steps (avatar) are
      // optional, so the server can mark onboarding complete while that
      // flag is still false. Only walk the granular per-step checks when
      // it genuinely isn't done yet, otherwise a user who deliberately
      // skipped their avatar gets sent back to that screen on every login.
      if (!onboarding.isComplete) {
        if (onboarding.userType == null ||
            (!kSkipInterestsGate && !onboarding.interests)) {
          context.goNamed(PageUrl.userTypeSelectionScreen);
          return;
        }
        if (!onboarding.avatar) {
          context.goNamed(PageUrl.userNameScreen);
          return;
        }
        if (!onboarding.consents) {
          context.goNamed(PageUrl.dataPrivacyScreen);
          return;
        }
      }
    } else {
      // No onboarding summary yet — fall back to the old field-based
      // heuristic.
      if (!kSkipInterestsGate && state.interests.isEmpty) {
        context.goNamed(PageUrl.userTypeSelectionScreen);
        return;
      }
      if (state.username.isEmpty) {
        context.goNamed(PageUrl.userNameScreen);
        return;
      }
    }

    injector.get<PostBloc>().add(const PostEvent.getGuidelines());
    injector.get<PostBloc>().add(const PostEvent.getCategories());
    SessionManager().hasOnboarded = true;
    context.goNamed(PageUrl.homeScreen);
  }
}
