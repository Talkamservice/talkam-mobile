import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CustomCountDown extends StatelessWidget {
  const CustomCountDown({
    super.key,
    this.style,
    this.onEnd,
    this.endTime,
  });

  final TextStyle? style;
  final VoidCallback? onEnd;
  final DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      spacerWidth: 3,
      timeTextStyle: style,
      minutesDescription: '',
      secondsDescription: '',
      // Descriptions are blank anyway, and leaving them enabled adds a 5px gap
      // plus an empty Text line under the digits — which pushes the digits up
      // relative to any text beside them.
      enableDescriptions: false,
      format: CountDownTimerFormat.minutesSeconds,
      endTime: endTime ??
          DateTime.now().add(
            const Duration(
              minutes: 5,
              seconds: 0,
            ),
          ),
      onEnd: onEnd ?? () {},
    );
  }
}
