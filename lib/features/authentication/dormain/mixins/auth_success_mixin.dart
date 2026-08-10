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
      return;
    }

    // Prefer the v2 `/user/me` server-computed onboarding summary when
    // available, resuming at its first false step; login/register responses
    // don't include it, so fall back to the old field-based heuristic.
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
      if (state.username.isEmpty || state.avatar == null) {
        context.goNamed(PageUrl.userNameScreen);
        return;
      }
    }

    SessionManager().hasOnboarded = true;
    context.goNamed(PageUrl.homeScreen);
  }
}
