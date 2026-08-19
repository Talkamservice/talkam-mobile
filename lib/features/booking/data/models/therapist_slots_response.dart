// Models for GET /user/therapists/:id/slots?date=

class TherapistSlot {
  final String startsAt;
  final String endsAt;

  const TherapistSlot({required this.startsAt, required this.endsAt});

  factory TherapistSlot.fromJson(Map<String, dynamic> json) => TherapistSlot(
        startsAt: json['starts_at'] as String,
        endsAt: json['ends_at'] as String,
      );

  /// Formatted time string, e.g. "3:00 PM"
  String get formattedTime {
    final dt = DateTime.tryParse(startsAt);
    if (dt == null) return startsAt;
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final min = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$min $period';
  }

  /// ISO date string portion for grouping, e.g. "2026-08-19"
  String get dateKey {
    final dt = DateTime.tryParse(startsAt);
    if (dt == null) return '';
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}

class TherapistSlotsResponse {
  final String? date;
  final List<TherapistSlot> slots;

  const TherapistSlotsResponse({this.date, required this.slots});

  factory TherapistSlotsResponse.fromJson(Map<String, dynamic> json) =>
      TherapistSlotsResponse(
        date: json['date'] as String?,
        slots: (json['slots'] as List<dynamic>? ?? [])
            .map((e) => TherapistSlot.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  /// Slots grouped by date key — used to build the date-then-time picker.
  Map<String, List<TherapistSlot>> get byDate {
    final map = <String, List<TherapistSlot>>{};
    for (final slot in slots) {
      map.putIfAbsent(slot.dateKey, () => []).add(slot);
    }
    return map;
  }
}
