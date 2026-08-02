import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/empty_state.dart';

/// Placeholder for the bookings/appointments tab — no booking backend exists
/// yet. Keeps the bottom-nav destination real (not a dead tap).
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
        tittleText: "Calendar",
      ),
      body: Center(
        child: EmptyState(
          title: "Coming soon",
          subtitle: "Your booked sessions will show up here.",
        ),
      ),
    );
  }
}
