import 'package:equatable/equatable.dart';

/// Minutes in a full day. A defensive upper bound only — the pickers stop at
/// [kLatestEndMinutes].
const int kMinutesPerDay = 24 * 60;

/// Granularity the time pickers offer. 15 minutes covers the realistic
/// scheduling grid (9:00, 9:15, 9:30, 9:45) without a 1,440-row picker.
const int kSlotMinuteStep = 15;

/// Shortest useful window. Anything below this cannot hold a session.
const int kMinSlotMinutes = 30;

/// Longest single window. A therapist wanting more splits it in two, which
/// also keeps a runaway 24-hour range out of the data.
const int kMaxSlotMinutes = 12 * 60;

/// Default length of a bookable session — the 50-minute "therapeutic hour".
///
/// Anything that prices or labels a session reads this rather than hardcoding
/// a number, so the rate label and the configured duration cannot drift apart.
const int kDefaultSessionDurationMinutes = 50;

/// Latest a window may end: 23:45.
///
/// Deliberately not midnight — `TimeOfDay` cannot represent hour 24, and
/// `formatTimeOfDay` renders it incorrectly. Capping here removes an entire
/// class of edge case for a range no therapist needs.
const int kLatestEndMinutes = 23 * 60 + 45;

/// Days of the week, Monday-first and aligned to `DateTime.monday`..`sunday`
/// so a recurring slot can be mapped onto a real date without a lookup table.
///
/// Declaration order is the canonical sort order.
enum Weekday {
  monday(DateTime.monday, 'Monday', 'Mon'),
  tuesday(DateTime.tuesday, 'Tuesday', 'Tue'),
  wednesday(DateTime.wednesday, 'Wednesday', 'Wed'),
  thursday(DateTime.thursday, 'Thursday', 'Thu'),
  friday(DateTime.friday, 'Friday', 'Fri'),
  saturday(DateTime.saturday, 'Saturday', 'Sat'),
  sunday(DateTime.sunday, 'Sunday', 'Sun');

  const Weekday(this.isoIndex, this.label, this.shortLabel);

  final int isoIndex;
  final String label;
  final String shortLabel;

  static Weekday fromIso(int iso) =>
      Weekday.values.firstWhere((d) => d.isoIndex == iso);

  static Weekday? tryParse(String name) {
    for (final day in Weekday.values) {
      if (day.name == name) return day;
    }
    return null;
  }
}

/// Why a candidate window cannot be committed.
///
/// Copy lives in the presentation layer — the overlap message has to
/// interpolate a formatted time, which needs a `BuildContext`.
enum SlotValidationError {
  endBeforeStart,
  outsideDayBounds,
  tooShort,
  tooLong,
  overlap,
}

/// One recurring weekly availability window.
///
/// Interpreted as the **half-open** interval `[startMinutes, endMinutes)` in
/// the therapist's local time, so 09:00–10:00 and 10:00–11:00 sit back to back
/// without overlapping.
///
/// Bounds are minutes from midnight rather than `TimeOfDay`: `TimeOfDay` has no
/// ordering operator, does not serialise, and would drag `dart:ui` into the
/// domain layer. Integers keep the interval maths total and let this whole file
/// be tested with no Flutter binding.
class AvailabilitySlot extends Equatable {
  const AvailabilitySlot({
    required this.id,
    required this.day,
    required this.startMinutes,
    required this.endMinutes,
  });

  /// Stable local identity.
  ///
  /// The collection re-sorts after every mutation, so a positional index cannot
  /// target an edit or a delete. It also lets the overlap check exclude the row
  /// being edited from comparison against its own previous value.
  final String id;

  final Weekday day;
  final int startMinutes;
  final int endMinutes;

  int get durationMinutes => endMinutes - startMinutes;

  /// Half-open intersection:
  /// `[aStart, aEnd) ∩ [bStart, bEnd) ≠ ∅  ⟺  aStart < bEnd ∧ bStart < aEnd`
  ///
  /// Both comparisons are strict `<`, never `<=` — that is precisely what makes
  /// 09:00–10:00 and 10:00–11:00 adjacent rather than overlapping.
  ///
  /// Defined for non-degenerate windows only. A zero-length window is the empty
  /// set and can overlap nothing, but this predicate does not model that: it
  /// reports `true` for a zero-length window sitting strictly inside another
  /// and `false` everywhere else. [WeeklyAvailability.validate] therefore
  /// rejects degenerate and too-short windows *before* reaching this check, so
  /// the caller gets an actionable duration error rather than a bewildering
  /// "overlaps" message — or, for a zero-length window in a free gap, silent
  /// acceptance as an unbookable ghost row.
  bool overlaps(AvailabilitySlot other) =>
      day == other.day &&
      startMinutes < other.endMinutes &&
      other.startMinutes < endMinutes;

  /// True when this window ends exactly where [other] begins, or vice versa.
  /// Never a conflict — exposed so the UI could offer to merge, not to block.
  bool isAdjacentTo(AvailabilitySlot other) =>
      day == other.day &&
      (endMinutes == other.startMinutes || other.endMinutes == startMinutes);

  AvailabilitySlot copyWith({
    Weekday? day,
    int? startMinutes,
    int? endMinutes,
  }) =>
      AvailabilitySlot(
        id: id,
        day: day ?? this.day,
        startMinutes: startMinutes ?? this.startMinutes,
        endMinutes: endMinutes ?? this.endMinutes,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'day': day.name,
        'start': startMinutes,
        'end': endMinutes,
      };

  /// Returns null for a row that cannot be understood, so one corrupt entry
  /// drops out instead of failing the whole decode.
  static AvailabilitySlot? tryFromJson(Map<String, dynamic> json) {
    final day = Weekday.tryParse(json['day'] as String? ?? '');
    final start = json['start'];
    final end = json['end'];
    final id = json['id'];
    if (day == null || start is! int || end is! int || id is! String) {
      return null;
    }
    return AvailabilitySlot(
      id: id,
      day: day,
      startMinutes: start,
      endMinutes: end,
    );
  }

  @override
  List<Object?> get props => [id, day, startMinutes, endMinutes];
}

/// A therapist's full recurring week.
class WeeklyAvailability extends Equatable {
  const WeeklyAvailability({this.slots = const []});

  /// Always in canonical order — [Weekday] declaration order, then ascending
  /// start. Maintained by [upsert] so rendering, equality and the persisted
  /// JSON are all stable. Two logically identical weeks must encode
  /// identically or the edit screen's dirty check false-positives.
  final List<AvailabilitySlot> slots;

  bool get isEmpty => slots.isEmpty;

  bool get isNotEmpty => slots.isNotEmpty;

  List<AvailabilitySlot> slotsFor(Weekday day) =>
      slots.where((s) => s.day == day).toList(growable: false);

  /// Days that actually have windows, in week order — days with none are
  /// omitted so the UI doesn't render empty headers.
  List<Weekday> get populatedDays =>
      Weekday.values.where((d) => slots.any((s) => s.day == d)).toList();

  int get totalWeeklyMinutes =>
      slots.fold(0, (sum, s) => sum + s.durationMinutes);

  /// The existing window [candidate] would collide with, or null.
  ///
  /// Returns the slot rather than a bool so the error message can name it —
  /// "This overlaps Thursday 9:00 AM – 11:00 AM" is the difference between a
  /// usable error and a dead end.
  ///
  /// [replacingId] is the id of the window being edited; it is skipped so a
  /// window never conflicts with its own previous value.
  AvailabilitySlot? conflictFor(
    AvailabilitySlot candidate, {
    String? replacingId,
  }) {
    for (final slot in slots) {
      if (slot.id == replacingId) continue;
      if (slot.overlaps(candidate)) return slot;
    }
    return null;
  }

  /// The first rule [candidate] breaks, or null when it can be committed.
  ///
  /// **Order is load-bearing.** Duration and bounds are checked *before*
  /// overlap because a zero-length window (10:00–10:00) satisfies
  /// [AvailabilitySlot.overlaps] against nothing — both strict comparisons
  /// fail — so it would sail past the conflict scan and land in the list as an
  /// unbookable ghost row.
  SlotValidationError? validate(
    AvailabilitySlot candidate, {
    String? replacingId,
  }) {
    if (candidate.endMinutes <= candidate.startMinutes) {
      return SlotValidationError.endBeforeStart;
    }
    if (candidate.startMinutes < 0 ||
        candidate.endMinutes > kLatestEndMinutes) {
      return SlotValidationError.outsideDayBounds;
    }
    if (candidate.durationMinutes < kMinSlotMinutes) {
      return SlotValidationError.tooShort;
    }
    if (candidate.durationMinutes > kMaxSlotMinutes) {
      return SlotValidationError.tooLong;
    }
    if (conflictFor(candidate, replacingId: replacingId) != null) {
      return SlotValidationError.overlap;
    }
    return null;
  }

  /// Insert or replace by id, then re-sort into canonical order.
  ///
  /// Callers are expected to have run [validate] first; this does not re-check
  /// (the bloc does, as defence in depth).
  WeeklyAvailability upsert(AvailabilitySlot slot) {
    final next = [...slots.where((s) => s.id != slot.id), slot]..sort(_compare);
    return WeeklyAvailability(slots: List.unmodifiable(next));
  }

  WeeklyAvailability removeById(String id) => WeeklyAvailability(
        slots: List.unmodifiable(slots.where((s) => s.id != id)),
      );

  static int _compare(AvailabilitySlot a, AvailabilitySlot b) {
    final byDay = a.day.index.compareTo(b.day.index);
    return byDay != 0 ? byDay : a.startMinutes.compareTo(b.startMinutes);
  }

  List<Map<String, dynamic>> toJson() => [for (final s in slots) s.toJson()];

  /// Tolerant of malformed input: unreadable rows are dropped rather than
  /// throwing, so one bad entry cannot brick a therapist's whole profile.
  factory WeeklyAvailability.fromJson(List<dynamic> json) {
    final parsed = <AvailabilitySlot>[];
    for (final entry in json) {
      if (entry is! Map) continue;
      final slot =
          AvailabilitySlot.tryFromJson(Map<String, dynamic>.from(entry));
      if (slot != null) parsed.add(slot);
    }
    parsed.sort(_compare);
    return WeeklyAvailability(slots: List.unmodifiable(parsed));
  }

  @override
  List<Object?> get props => [slots];
}
