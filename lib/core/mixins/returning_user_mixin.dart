import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/constants/dev_flags.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/path_params.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/data/models/onboarding_user_type.dart';
import 'package:talkam/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:talkam/features/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/therapist_application/dormain/repository/therapist_application_repository.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

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

    final isTherapist =
        SessionManager.instance.isTherapistAccount || state.isTherapist;

    if (isTherapist) {
      _handleTherapistRouting(context, state);
      return;
    }

    // The v2 `/user/me` payload (fetched via GetRemoteUser) carries a
    // server-computed onboarding summary — resume at its first false step.
    // Login/register responses don't include it, so fall back to the old
    // field-based heuristic until the next `/user/me` refresh lands.
    final onboarding = state.onboarding;
    if (onboarding != null) {
      if (!onboarding.isComplete || !onboarding.interests || !onboarding.consents) {
        if (!kSkipInterestsGate && !onboarding.interests) {
          context.goNamed(PageUrl.interestsScreen);
          return;
        }
        if (!onboarding.consents) {
          context.goNamed(PageUrl.dataPrivacyScreen);
          return;
        }
      }
    } else {
      if (!kSkipInterestsGate && state.interests.isEmpty) {
        context.goNamed(PageUrl.interestsScreen);
        return;
      }
    }

    _navigateToHome(context);
  }

  Future<void> _handleTherapistRouting(
      BuildContext context, TalkamUser state) async {
    if (state.status.toLowerCase() == 'active' && SessionManager().hasOnboarded) {
      _navigateToHome(context);
      return;
    }

    try {
      final repo = injector.get<TherapistApplicationRepository>();
      final statusResp = await repo.getApplicationStatus();
      final steps = statusResp.steps;
      final bloc = TherapistApplicationBloc(repo);

      // Resume at the first false step:
      // personal -> documents -> specialties -> availability -> payout
      if (!steps.personal) {
        if (context.mounted) {
          context.goNamed(PageUrl.therapistPersonalInfoScreen, extra: bloc);
        }
        return;
      }
      if (!steps.documents) {
        if (context.mounted) {
          context.goNamed(PageUrl.therapistQualificationsScreen, extra: bloc);
        }
        return;
      }
      if (!steps.specialties) {
        if (context.mounted) {
          context.goNamed(PageUrl.therapistSpecialtiesScreen, extra: bloc);
        }
        return;
      }
      if (!steps.availability) {
        if (context.mounted) {
          context.goNamed(PageUrl.therapistAvailabilityScreen, extra: bloc);
        }
        return;
      }
      if (!steps.payout) {
        if (context.mounted) {
          context.goNamed(PageUrl.therapistPayoutScreen, extra: bloc);
        }
        return;
      }

      // All steps are true
      final status = (statusResp.status ?? '').toLowerCase();

      // If user has already tapped "Explore TalkAm" or application status is active/approved, enter app
      if (SessionManager().hasOnboarded ||
          status == 'approved' ||
          status == 'active') {
        if (context.mounted) {
          _navigateToHome(context);
        }
        return;
      }

      if (context.mounted) {
        context.goNamed(PageUrl.therapistVerificationPendingScreen);
      }
    } catch (_) {
      if (context.mounted) {
        if (SessionManager().hasOnboarded) {
          _navigateToHome(context);
        } else {
          final bloc = TherapistApplicationBloc(
              injector.get<TherapistApplicationRepository>());
          context.goNamed(PageUrl.therapistPersonalInfoScreen, extra: bloc);
        }
      }
    }
  }

  void _navigateToHome(BuildContext context) {
    injector.get<PostBloc>().add(const PostEvent.getGuidelines());
    injector.get<PostBloc>().add(const PostEvent.getCategories());
    SessionManager().hasOnboarded = true;
    context.goNamed(PageUrl.homeScreen);
  }
}
