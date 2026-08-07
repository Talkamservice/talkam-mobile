import 'package:flutter/material.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';

/// Formats minutes-from-midnight for display.
///
/// Always goes through [MaterialLocalizations] so the device's 12/24-hour
/// setting is honoured — a therapist on a 24-hour phone must see "13:30", not
/// "1:30 PM". This is why [AvailabilitySlot] carries no formatted label of its
/// own: formatting needs a [BuildContext] and the domain model must not.
String formatMinutesOfDay(BuildContext context, int minutes) =>
    MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
    );

/// "9:00 AM – 10:30 AM"
String formatSlotRange(BuildContext context, AvailabilitySlot slot) =>
    '${formatMinutesOfDay(context, slot.startMinutes)} – '
    '${formatMinutesOfDay(context, slot.endMinutes)}';

/// Compact duration: "1h 30m", "2h", "45m".
String formatDurationShort(int minutes) {
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours == 0) return '${rest}m';
  if (rest == 0) return '${hours}h';
  return '${hours}h ${rest}m';
}
