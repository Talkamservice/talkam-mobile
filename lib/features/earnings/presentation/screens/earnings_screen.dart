import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/empty_state.dart';

/// Placeholder for the therapist earnings tab — no payouts backend exists
/// yet (see TherapistPayoutScreen, which simulates the same rate math).
/// Keeps the bottom-nav destination real (not a dead tap).
class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
        tittleText: "Earnings",
      ),
      body: Center(
        child: EmptyState(
          title: "Coming soon",
          subtitle: "Your session earnings and payout history will show up here.",
        ),
      ),
    );
  }
}
