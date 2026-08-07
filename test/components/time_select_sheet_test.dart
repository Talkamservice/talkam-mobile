import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talkam/common/widgets/selectable_pill.dart';
import 'package:talkam/common/widgets/time_select_sheet.dart';

Widget _host(Widget child, {bool use24Hour = false}) => ScreenUtilInit(
      designSize: const Size(390, 852),
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        home: Builder(
          // copyWith, not a fresh MediaQueryData — a bare one has Size.zero
          // and collapses the layout.
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(alwaysUse24HourFormat: use24Hour),
            child: Scaffold(body: SingleChildScrollView(child: child)),
          ),
        ),
      ),
    );

/// Finds a tile by its exact label.
Finder _tile(String label) => find.widgetWithText(SelectablePill, label);

SelectablePill _pill(WidgetTester tester, String label) =>
    tester.widget<SelectablePill>(_tile(label).first);

void main() {
  group('TimeSelectSheet layout', () {
    testWidgets('shows every hour at once rather than a scrolling slot list',
        (tester) async {
      // The whole point of the grid: no scrolling to reach an evening time.
      await tester.pumpWidget(
        _host(const TimeSelectSheet(
          initialTime: TimeOfDay(hour: 21, minute: 15),
          startMinutes: 0,
          endMinutes: 23 * 60 + 45,
          minuteStep: 15,
        )),
      );
      await tester.pumpAndSettle();

      // 12 hour tiles + AM/PM + 4 minute tiles, all rendered.
      for (final h in ['12', '1', '6', '9', '11']) {
        expect(_tile(h), findsWidgets, reason: 'hour $h');
      }
      for (final m in [':00', ':15', ':30', ':45']) {
        expect(_tile(m), findsOneWidget, reason: 'minute $m');
      }
      expect(_tile('AM'), findsOneWidget);
      expect(_tile('PM'), findsOneWidget);
    });

    testWidgets('hides the minute row when the step is a whole hour',
        (tester) async {
      await tester.pumpWidget(
        _host(const TimeSelectSheet(initialTime: TimeOfDay(hour: 9, minute: 0))),
      );
      await tester.pumpAndSettle();

      expect(_tile(':00'), findsNothing);
      expect(_tile(':15'), findsNothing);
    });

    testWidgets('renders 24 hours and no AM/PM on a 24-hour device',
        (tester) async {
      await tester.pumpWidget(
        _host(
          const TimeSelectSheet(
            initialTime: TimeOfDay(hour: 13, minute: 0),
            startMinutes: 0,
            endMinutes: 23 * 60 + 45,
            minuteStep: 15,
          ),
          use24Hour: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(_tile('AM'), findsNothing);
      expect(_tile('PM'), findsNothing);
      expect(_tile('00'), findsOneWidget);
      expect(_tile('13'), findsOneWidget);
      expect(_tile('23'), findsOneWidget);
    });
  });

  group('TimeSelectSheet selection', () {
    Future<TimeOfDay?> openAndPick(
      WidgetTester tester,
      Future<void> Function(WidgetTester) interact, {
      TimeOfDay initial = const TimeOfDay(hour: 9, minute: 0),
      int minuteStep = 15,
    }) async {
      TimeOfDay? result;
      await tester.pumpWidget(
        _host(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await showModalBottomSheet<TimeOfDay>(
                  context: context,
                  // Matches CustomDialogs.showBottomSheet, which is how the
                  // sheet is actually presented; without it the height is
                  // capped at 50% and the grid is clipped.
                  isScrollControlled: true,
                  builder: (_) => TimeSelectSheet(
                    initialTime: initial,
                    startMinutes: 0,
                    endMinutes: 23 * 60 + 45,
                    minuteStep: minuteStep,
                  ),
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await interact(tester);
      return result;
    }

    testWidgets('period + hour + minute selects an evening time in three taps',
        (tester) async {
      final result = await openAndPick(tester, (t) async {
        await t.tap(_tile('PM'));
        await t.pumpAndSettle();
        await t.tap(_tile('9').first);
        await t.pumpAndSettle();
        await t.tap(_tile(':15'));
        await t.pumpAndSettle();
        // The confirm button echoes the pick.
        await t.tap(find.text('9:15 PM'));
        await t.pumpAndSettle();
      });

      expect(result, const TimeOfDay(hour: 21, minute: 15));
    });

    testWidgets('the confirm button reflects the current pick live',
        (tester) async {
      await tester.pumpWidget(
        _host(const TimeSelectSheet(
          initialTime: TimeOfDay(hour: 9, minute: 0),
          startMinutes: 0,
          endMinutes: 23 * 60 + 45,
          minuteStep: 15,
        )),
      );
      await tester.pumpAndSettle();

      expect(find.text('9:00 AM'), findsOneWidget);
      await tester.tap(_tile(':30'));
      await tester.pumpAndSettle();
      expect(find.text('9:30 AM'), findsOneWidget);
    });

    testWidgets('changing hour keeps the chosen minute', (tester) async {
      await tester.pumpWidget(
        _host(const TimeSelectSheet(
          initialTime: TimeOfDay(hour: 9, minute: 45),
          startMinutes: 0,
          endMinutes: 23 * 60 + 45,
          minuteStep: 15,
        )),
      );
      await tester.pumpAndSettle();

      await tester.tap(_tile('11').first);
      await tester.pumpAndSettle();

      expect(find.text('11:45 AM'), findsOneWidget);
    });

    testWidgets('switching period preserves hour and minute', (tester) async {
      await tester.pumpWidget(
        _host(const TimeSelectSheet(
          initialTime: TimeOfDay(hour: 9, minute: 30),
          startMinutes: 0,
          endMinutes: 23 * 60 + 45,
          minuteStep: 15,
        )),
      );
      await tester.pumpAndSettle();

      await tester.tap(_tile('PM'));
      await tester.pumpAndSettle();

      expect(find.text('9:30 PM'), findsOneWidget);
    });
  });

  group('TimeSelectSheet bounds and isEnabled', () {
    testWidgets('hours outside the range are disabled', (tester) async {
      // The onboarding caller's default 9 AM - 5 PM window.
      await tester.pumpWidget(
        _host(const TimeSelectSheet(initialTime: TimeOfDay(hour: 9, minute: 0))),
      );
      await tester.pumpAndSettle();

      // 9 AM is in range; 8 AM is not, and AM 7 likewise.
      expect(_pill(tester, '9').enabled, isTrue);
      expect(_pill(tester, '8').enabled, isFalse);
      expect(_pill(tester, '7').enabled, isFalse);
    });

    testWidgets('an hour with no selectable minute is disabled', (tester) async {
      await tester.pumpWidget(
        _host(TimeSelectSheet(
          initialTime: const TimeOfDay(hour: 9, minute: 0),
          startMinutes: 0,
          endMinutes: 23 * 60 + 45,
          minuteStep: 15,
          isEnabled: (t) => t.hour != 10,
        )),
      );
      await tester.pumpAndSettle();

      expect(_pill(tester, '10').enabled, isFalse);
      expect(_pill(tester, '11').enabled, isTrue);
    });

    testWidgets('individual minutes can be disabled within an enabled hour',
        (tester) async {
      await tester.pumpWidget(
        _host(TimeSelectSheet(
          initialTime: const TimeOfDay(hour: 9, minute: 0),
          startMinutes: 0,
          endMinutes: 23 * 60 + 45,
          minuteStep: 15,
          isEnabled: (t) => !(t.hour == 9 && t.minute == 30),
        )),
      );
      await tester.pumpAndSettle();

      expect(_pill(tester, ':30').enabled, isFalse);
      expect(_pill(tester, ':15').enabled, isTrue);
    });

    testWidgets('a disabled tile cannot be selected', (tester) async {
      await tester.pumpWidget(
        _host(TimeSelectSheet(
          initialTime: const TimeOfDay(hour: 9, minute: 0),
          startMinutes: 0,
          endMinutes: 23 * 60 + 45,
          minuteStep: 15,
          isEnabled: (t) => t.hour != 11,
        )),
      );
      await tester.pumpAndSettle();

      await tester.tap(_tile('11').first);
      await tester.pumpAndSettle();

      // Still on the opening pick.
      expect(find.text('9:00 AM'), findsOneWidget);
    });

    testWidgets('an out-of-range initial time snaps to the first allowed slot',
        (tester) async {
      // Midnight is outside the default 9-5 window; the sheet must not open on
      // a disabled selection.
      await tester.pumpWidget(
        _host(const TimeSelectSheet(initialTime: TimeOfDay(hour: 0, minute: 0))),
      );
      await tester.pumpAndSettle();

      expect(find.text('9:00 AM'), findsOneWidget);
    });
  });
}
