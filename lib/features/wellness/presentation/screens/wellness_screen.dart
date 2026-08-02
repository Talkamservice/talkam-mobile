import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/empty_state.dart';

/// Placeholder for the wellness-library tab. The backend already exposes
/// `UrlConfig.getLibraryCategoriesEndpoint`, but no UI consumes it yet — this
/// keeps the bottom-nav destination real (not a dead tap) until that's built.
class WellnessScreen extends StatelessWidget {
  const WellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
        tittleText: "Wellness",
      ),
      body: Center(
        child: EmptyState(
          title: "Coming soon",
          subtitle: "Guided wellness content will live here.",
        ),
      ),
    );
  }
}
