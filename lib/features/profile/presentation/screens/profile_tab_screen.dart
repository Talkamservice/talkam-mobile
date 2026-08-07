import 'package:flutter/material.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/profile/presentation/screens/profile_screen.dart';
import 'package:talkam/features/therapist/presentation/screens/my_therapist_profile_screen.dart';

/// Profile tab of the app shell.
///
/// Therapists get a profile built around their practice — stats, specialties
/// and reviews — while everyone else keeps the standard member profile.
///
/// Listens to the account type rather than reading it once: the shell keeps
/// visited branches alive, so a user who opens this tab before becoming a
/// therapist would otherwise stay on the member profile for the rest of the
/// session.
class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: SessionManager.instance.isTherapistAccountListenable,
      builder: (context, isTherapist, _) => isTherapist
          ? const MyTherapistProfileScreen()
          : const ProfileScreen(),
    );
  }
}
