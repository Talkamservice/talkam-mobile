import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/components/talkam_tab_bar.dart';

/// Matches the designSize configured in `TalkAmApp`.
Widget _host(Widget child) => ScreenUtilInit(
      designSize: const Size(390, 852),
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        home: Scaffold(body: Center(child: child)),
      ),
    );

/// The underline is the only decorated Container inside the tab.
Size _indicatorSize(WidgetTester tester) {
  final container = find.descendant(
    of: find.byType(TalkamTabBar),
    matching: find.byType(Container),
  );
  return tester.getSize(container.first);
}

void main() {
  group('TalkamTabBar', () {
    testWidgets('uses a fixed-width indicator by default', (tester) async {
      await tester.pumpWidget(
        _host(TalkamTabBar(title: 'Posts', isSelected: true, onTap: () {})),
      );
      await tester.pumpAndSettle();

      final size = _indicatorSize(tester);
      expect(size.height, 3.0);
      // 60 logical px scaled by ScreenUtil; independent of the label length.
      expect(size.width, greaterThan(0));
    });

    testWidgets('indicator hugs the label when indicatorWidth is null',
        (tester) async {
      await tester.pumpWidget(
        _host(
          TalkamTabBar(
            title: 'Settings',
            isSelected: true,
            indicatorWidth: null,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final indicator = _indicatorSize(tester);
      final label = tester.getSize(find.text('Settings'));

      // Regression guard: a childless Container in a centre-aligned Column
      // collapses to zero width, which silently hides the underline.
      expect(indicator.width, greaterThan(0));
      expect(indicator.width, closeTo(label.width, 0.5));
      expect(indicator.height, 3.0);
    });

    testWidgets('hugging indicators differ in width across labels',
        (tester) async {
      Future<double> widthFor(String title) async {
        await tester.pumpWidget(
          _host(
            TalkamTabBar(
              title: title,
              isSelected: true,
              indicatorWidth: null,
              onTap: () {},
            ),
          ),
        );
        await tester.pumpAndSettle();
        return _indicatorSize(tester).width;
      }

      expect(await widthFor('Settings'), greaterThan(await widthFor('Post')));
    });

    testWidgets('unselected tab renders a transparent indicator',
        (tester) async {
      await tester.pumpWidget(
        _host(TalkamTabBar(title: 'Post', isSelected: false, onTap: () {})),
      );
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(TalkamTabBar),
              matching: find.byType(Container),
            )
            .first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.transparent);
    });

    testWidgets('selected tab paints the brand underline', (tester) async {
      await tester.pumpWidget(
        _host(TalkamTabBar(title: 'Post', isSelected: true, onTap: () {})),
      );
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(TalkamTabBar),
              matching: find.byType(Container),
            )
            .first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Pallets.tabBarBlue);
    });

    testWidgets('reports taps', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _host(
          TalkamTabBar(title: 'Post', isSelected: false, onTap: () => taps++),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TalkamTabBar));
      expect(taps, 1);
    });
  });
}
