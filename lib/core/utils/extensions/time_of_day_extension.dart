import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool isBefore(TimeOfDay time2) {
    return hour < time2.hour || (hour == time2.hour && minute < time2.minute);
  }
}
