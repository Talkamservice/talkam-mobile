import 'package:flutter_test/flutter_test.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';

/// Minutes from midnight, so tests read like a clock.
int at(int hour, [int minute = 0]) => hour * 60 + minute;

AvailabilitySlot slot(
  Weekday day,
  int startHour,
  int endHour, {
  String id = 'a',
  int startMinute = 0,
  int endMinute = 0,
}) =>
    AvailabilitySlot(
      id: id,
      day: day,
      startMinutes: at(startHour, startMinute),
      endMinutes: at(endHour, endMinute),
    );

void main() {
  // The reference window every overlap case is measured against.
  final thu9to11 = slot(Weekday.thursday, 9, 11, id: 'ref');

  group('AvailabilitySlot.overlaps', () {
    test('rejects a window starting inside an existing one', () {
      expect(thu9to11.overlaps(slot(Weekday.thursday, 10, 12, id: 'b')), isTrue);
    });

    test('rejects a window ending inside an existing one', () {
      expect(thu9to11.overlaps(slot(Weekday.thursday, 8, 10, id: 'b')), isTrue);
    });

    test('rejects an identical window', () {
      expect(thu9to11.overlaps(slot(Weekday.thursday, 9, 11, id: 'b')), isTrue);
    });

    test('rejects a contained window', () {
      expect(
        thu9to11.overlaps(slot(Weekday.thursday, 9, 10,
            id: 'b', startMinute: 30, endMinute: 30)),
        isTrue,
      );
    });

    test('rejects a containing window', () {
      expect(thu9to11.overlaps(slot(Weekday.thursday, 8, 12, id: 'b')), isTrue);
    });

    test('allows a window starting exactly when the other ends', () {
      // The whole point of half-open intervals.
      expect(
          thu9to11.overlaps(slot(Weekday.thursday, 11, 12, id: 'b')), isFalse);
    });

    test('allows a window ending exactly when the other starts', () {
      expect(thu9to11.overlaps(slot(Weekday.thursday, 8, 9, id: 'b')), isFalse);
    });

    test('allows the same hours on a different day', () {
      expect(thu9to11.overlaps(slot(Weekday.friday, 10, 12, id: 'b')), isFalse);
    });

    test('is symmetric', () {
      final other = slot(Weekday.thursday, 10, 12, id: 'b');
      expect(thu9to11.overlaps(other), other.overlaps(thu9to11));
    });

    test('is only meaningful for non-degenerate windows', () {
      // A zero-length window is the empty set and can truly overlap nothing,
      // but the predicate does not model that: inside another window both
      // strict comparisons still hold, while in a free gap neither does.
      // Hence validate() must screen out degenerate windows before it gets
      // here — see the precedence tests below.
      final zeroInside = slot(Weekday.thursday, 10, 10, id: 'z');
      expect(zeroInside.overlaps(thu9to11), isTrue);

      final zeroInGap = slot(Weekday.thursday, 15, 15, id: 'z');
      expect(zeroInGap.overlaps(thu9to11), isFalse);
    });
  });

  group('AvailabilitySlot.isAdjacentTo', () {
    test('detects both orderings, and only on the same day', () {
      final after = slot(Weekday.thursday, 11, 12, id: 'b');
      expect(thu9to11.isAdjacentTo(after), isTrue);
      expect(after.isAdjacentTo(thu9to11), isTrue);
      expect(
        thu9to11.isAdjacentTo(slot(Weekday.friday, 11, 12, id: 'c')),
        isFalse,
      );
    });
  });

  group('WeeklyAvailability.validate', () {
    final week = WeeklyAvailability(slots: [thu9to11]);

    test('accepts a clear window', () {
      expect(week.validate(slot(Weekday.thursday, 12, 13, id: 'b')), isNull);
    });

    test('accepts an adjacent window', () {
      expect(week.validate(slot(Weekday.thursday, 11, 12, id: 'b')), isNull);
    });

    test('reports overlap for a clashing window', () {
      expect(
        week.validate(slot(Weekday.thursday, 10, 12, id: 'b')),
        SlotValidationError.overlap,
      );
    });

    test('reports endBeforeStart when end precedes start', () {
      expect(
        week.validate(slot(Weekday.thursday, 12, 10, id: 'b')),
        SlotValidationError.endBeforeStart,
      );
    });

    test('rejects a zero-length window wherever it sits', () {
      // Precedence guard. Inside an existing window the conflict scan would
      // call this an overlap; in a free gap it would pass the scan entirely
      // and be committed as an unbookable ghost row. Both must be caught up
      // front, and with the same actionable reason.
      expect(
        week.validate(slot(Weekday.thursday, 10, 10, id: 'b')),
        SlotValidationError.endBeforeStart,
      );
      expect(
        week.validate(slot(Weekday.thursday, 15, 15, id: 'b')),
        SlotValidationError.endBeforeStart,
      );
    });

    test('reports tooShort below the minimum', () {
      expect(
        week.validate(slot(Weekday.thursday, 12, 12, id: 'b', endMinute: 15)),
        SlotValidationError.tooShort,
      );
    });

    test('accepts exactly the minimum duration', () {
      expect(
        week.validate(slot(Weekday.thursday, 12, 12, id: 'b', endMinute: 30)),
        isNull,
      );
    });

    test('reports tooLong above the maximum', () {
      expect(
        week.validate(slot(Weekday.saturday, 1, 14, id: 'b')),
        SlotValidationError.tooLong,
      );
    });

    test('accepts exactly the maximum duration', () {
      expect(week.validate(slot(Weekday.saturday, 1, 13, id: 'b')), isNull);
    });

    test('reports outsideDayBounds past the latest end', () {
      expect(
        week.validate(
          AvailabilitySlot(
            id: 'b',
            day: Weekday.saturday,
            startMinutes: at(23),
            endMinutes: kLatestEndMinutes + 1,
          ),
        ),
        SlotValidationError.outsideDayBounds,
      );
    });

    test('accepts a window ending exactly at the latest end', () {
      expect(
        week.validate(
          AvailabilitySlot(
            id: 'b',
            day: Weekday.saturday,
            startMinutes: at(23),
            endMinutes: kLatestEndMinutes,
          ),
        ),
        isNull,
      );
    });

    test('a shrinking edit does not conflict with itself when replacingId is '
        'supplied', () {
      final shrunk = slot(Weekday.thursday, 9, 10, id: 'ref');
      expect(week.validate(shrunk, replacingId: 'ref'), isNull);
      // Without the exclusion it clashes with its own previous value — the
      // exact bug the parameter exists to prevent.
      expect(week.validate(shrunk), SlotValidationError.overlap);
    });

    test('an edit still conflicts with a different window', () {
      final week2 = WeeklyAvailability(slots: [
        thu9to11,
        slot(Weekday.thursday, 14, 16, id: 'other'),
      ]);
      expect(
        week2.validate(slot(Weekday.thursday, 15, 17, id: 'ref'),
            replacingId: 'ref'),
        SlotValidationError.overlap,
      );
    });
  });

  group('WeeklyAvailability.conflictFor', () {
    test('names the conflicting window so the error can quote it', () {
      final week = WeeklyAvailability(slots: [thu9to11]);
      final conflict =
          week.conflictFor(slot(Weekday.thursday, 10, 12, id: 'b'));
      expect(conflict?.id, 'ref');
    });

    test('returns null when clear', () {
      final week = WeeklyAvailability(slots: [thu9to11]);
      expect(week.conflictFor(slot(Weekday.friday, 10, 12, id: 'b')), isNull);
    });
  });

  group('WeeklyAvailability.upsert', () {
    test('sorts by day then start regardless of insertion order', () {
      final week = const WeeklyAvailability()
          .upsert(slot(Weekday.friday, 9, 10, id: 'f'))
          .upsert(slot(Weekday.monday, 14, 15, id: 'm2'))
          .upsert(slot(Weekday.monday, 9, 10, id: 'm1'));

      expect(week.slots.map((s) => s.id).toList(), ['m1', 'm2', 'f']);
    });

    test('replaces by id rather than appending', () {
      final week = const WeeklyAvailability()
          .upsert(slot(Weekday.monday, 9, 10, id: 'm'))
          .upsert(slot(Weekday.monday, 14, 15, id: 'm'));

      expect(week.slots.length, 1);
      expect(week.slots.single.startMinutes, at(14));
    });

    test('returns an unmodifiable list', () {
      final week =
          const WeeklyAvailability().upsert(slot(Weekday.monday, 9, 10));
      expect(() => week.slots.add(slot(Weekday.tuesday, 9, 10)),
          throwsUnsupportedError);
    });
  });

  group('WeeklyAvailability.removeById', () {
    test('removes the matching window', () {
      final week = WeeklyAvailability(slots: [thu9to11]).removeById('ref');
      expect(week.isEmpty, isTrue);
    });

    test('is a no-op for an unknown id', () {
      final week = WeeklyAvailability(slots: [thu9to11]).removeById('nope');
      expect(week.slots.length, 1);
    });
  });

  group('WeeklyAvailability grouping', () {
    final week = WeeklyAvailability(slots: [
      slot(Weekday.monday, 9, 10, id: 'm'),
      slot(Weekday.thursday, 9, 11, id: 't1'),
      slot(Weekday.thursday, 14, 16, id: 't2'),
    ]);

    test('populatedDays omits empty days and keeps week order', () {
      expect(week.populatedDays, [Weekday.monday, Weekday.thursday]);
    });

    test('slotsFor returns only that day', () {
      expect(week.slotsFor(Weekday.thursday).map((s) => s.id), ['t1', 't2']);
      expect(week.slotsFor(Weekday.sunday), isEmpty);
    });

    test('totalWeeklyMinutes sums every window', () {
      expect(week.totalWeeklyMinutes, 60 + 120 + 120);
    });
  });

  group('WeeklyAvailability JSON', () {
    test('round-trips an empty week', () {
      final decoded =
          WeeklyAvailability.fromJson(const WeeklyAvailability().toJson());
      expect(decoded.isEmpty, isTrue);
    });

    test('round-trips populated weeks preserving order and values', () {
      final week = WeeklyAvailability(slots: [
        slot(Weekday.monday, 9, 10, id: 'm'),
        slot(Weekday.thursday, 9, 11, id: 't', startMinute: 30, endMinute: 45),
      ]);
      final decoded = WeeklyAvailability.fromJson(week.toJson());
      expect(decoded, week);
    });

    test('drops unreadable rows instead of throwing', () {
      // One corrupt entry must not brick the therapist's whole profile.
      final decoded = WeeklyAvailability.fromJson([
        {'id': 'ok', 'day': 'monday', 'start': 540, 'end': 600},
        {'id': 'bad-day', 'day': 'funday', 'start': 540, 'end': 600},
        {'id': 'bad-type', 'day': 'monday', 'start': '540', 'end': 600},
        'not-a-map',
        {'day': 'monday', 'start': 540, 'end': 600},
      ]);
      expect(decoded.slots.map((s) => s.id), ['ok']);
    });
  });

  group('Weekday', () {
    test('maps to and from DateTime ISO indices', () {
      expect(Weekday.fromIso(DateTime.thursday), Weekday.thursday);
      expect(Weekday.monday.isoIndex, DateTime.monday);
      expect(Weekday.sunday.isoIndex, DateTime.sunday);
    });

    test('declaration order is Monday-first', () {
      expect(Weekday.values.first, Weekday.monday);
      expect(Weekday.values.last, Weekday.sunday);
    });

    test('tryParse round-trips names and rejects junk', () {
      expect(Weekday.tryParse('thursday'), Weekday.thursday);
      expect(Weekday.tryParse('funday'), isNull);
    });
  });
}
