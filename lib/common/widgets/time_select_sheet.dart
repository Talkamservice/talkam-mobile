import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/section_label.dart';
import 'package:talkam/common/widgets/selectable_pill.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Bottom-sheet time picker laid out as a grid: period, then hour, then minute.
///
/// Deliberately **not** a scrolling list of every slot. At 15-minute
/// granularity that is 96 rows, so picking an evening time meant a long scroll
/// past times nobody was looking for. The grid puts every choice on screen at
/// once — worst case three taps, no scrolling — and stays a fixed height
/// regardless of granularity.
///
/// Used in place of the platform's dial-style [showTimePicker] to match the
/// app's own sheet style.
class TimeSelectSheet extends StatefulWidget {
  const TimeSelectSheet({
    super.key,
    required this.initialTime,
    this.startHour = 9,
    this.endHour = 17,
    this.startMinutes,
    this.endMinutes,
    this.minuteStep = 60,
    this.isEnabled,
    this.title = "Select Time",
  }) : assert(minuteStep > 0 && 60 % minuteStep == 0,
            'minuteStep must divide an hour evenly');

  final TimeOfDay initialTime;

  /// Inclusive bounds in 24-hour form. Defaults span the app's 9:00 AM–5:00 PM
  /// working-hours window.
  final int startHour;
  final int endHour;

  /// Minute-precision overrides for [startHour]/[endHour], inclusive. Separate
  /// parameters so `endHour` keeps its "inclusive whole hour" meaning while a
  /// range like 00:00–23:45 stays expressible.
  final int? startMinutes;
  final int? endMinutes;

  /// Granularity of the minute row. 60 hides the row entirely.
  final int minuteStep;

  /// Disables any time for which this returns false — used to make an invalid
  /// end time unpickable rather than merely rejected. An hour is disabled when
  /// no minute within it is selectable.
  final bool Function(TimeOfDay)? isEnabled;

  final String title;

  static Future<TimeOfDay?> show(
    BuildContext context, {
    required TimeOfDay initialTime,
    int startHour = 9,
    int endHour = 17,
    int? startMinutes,
    int? endMinutes,
    int minuteStep = 60,
    bool Function(TimeOfDay)? isEnabled,
    String title = "Select Time",
  }) {
    return CustomDialogs.showBottomSheet<TimeOfDay>(
      context,
      TimeSelectSheet(
        initialTime: initialTime,
        startHour: startHour,
        endHour: endHour,
        startMinutes: startMinutes,
        endMinutes: endMinutes,
        minuteStep: minuteStep,
        isEnabled: isEnabled,
        title: title,
      ),
    );
  }

  @override
  State<TimeSelectSheet> createState() => _TimeSelectSheetState();
}

class _TimeSelectSheetState extends State<TimeSelectSheet> {
  static const int _tilesPerRow = 6;

  late final int _from = widget.startMinutes ?? widget.startHour * 60;
  late final int _to = widget.endMinutes ?? widget.endHour * 60;

  /// Minutes from midnight.
  late int _selected;

  bool _didResolveInitial = false;

  List<int> get _minuteOptions => widget.minuteStep >= 60
      ? const [0]
      : [for (var m = 0; m < 60; m += widget.minuteStep) m];

  bool get _showsMinutes => widget.minuteStep < 60;

  int get _hour24 => _selected ~/ 60;
  int get _minute => _selected % 60;
  bool get _isPm => _hour24 >= 12;

  bool _allowed(int minutesOfDay) {
    if (minutesOfDay < _from || minutesOfDay > _to) return false;
    final time = TimeOfDay(
      hour: minutesOfDay ~/ 60,
      minute: minutesOfDay % 60,
    );
    return widget.isEnabled?.call(time) ?? true;
  }

  /// Every selectable minute inside [hour24], respecting the minute grid.
  Iterable<int> _selectableMinutesIn(int hour24) =>
      _minuteOptions.where((m) => _allowed(hour24 * 60 + m));

  bool _hourEnabled(int hour24) => _selectableMinutesIn(hour24).isNotEmpty;

  bool _periodEnabled(bool pm) {
    final base = pm ? 12 : 0;
    for (var h = base; h < base + 12; h++) {
      if (_hourEnabled(h)) return true;
    }
    return false;
  }

  /// The first selectable time at or after [preferred], else the first
  /// selectable time at all. Keeps the sheet from opening on a disabled pick.
  int _nearestAllowed(int preferred) {
    if (_allowed(preferred)) return preferred;

    final candidates = <int>[
      for (var h = 0; h < 24; h++)
        for (final m in _minuteOptions) h * 60 + m,
    ].where(_allowed).toList();

    if (candidates.isEmpty) return preferred;
    return candidates.firstWhere(
      (c) => c >= preferred,
      orElse: () => candidates.first,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didResolveInitial) return;
    _didResolveInitial = true;
    _selected = _nearestAllowed(
      widget.initialTime.hour * 60 + widget.initialTime.minute,
    );
  }

  /// Moves to [hour24], keeping the current minute when it is still selectable
  /// and otherwise snapping to the first minute that is.
  void _selectHour(int hour24) {
    final minutes = _selectableMinutesIn(hour24);
    if (minutes.isEmpty) return;
    final minute = minutes.contains(_minute) ? _minute : minutes.first;
    setState(() => _selected = hour24 * 60 + minute);
  }

  void _selectMinute(int minute) {
    if (!_allowed(_hour24 * 60 + minute)) return;
    setState(() => _selected = _hour24 * 60 + minute);
  }

  void _selectPeriod(bool pm) {
    if (pm == _isPm) return;
    final shifted = pm ? _hour24 + 12 : _hour24 - 12;
    if (_hourEnabled(shifted)) {
      _selectHour(shifted);
      return;
    }
    // The mirrored hour isn't available — land on the first usable hour in the
    // chosen half instead of silently doing nothing.
    final base = pm ? 12 : 0;
    for (var h = base; h < base + 12; h++) {
      if (_hourEnabled(h)) {
        _selectHour(h);
        return;
      }
    }
  }

  /// 12-hour clocks label midnight and noon as 12, not 0.
  String _hourLabel(int hour24, bool use24) {
    if (use24) return hour24.toString().padLeft(2, '0');
    final base = hour24 % 12;
    return (base == 0 ? 12 : base).toString();
  }

  @override
  Widget build(BuildContext context) {
    final use24 = MediaQuery.alwaysUse24HourFormatOf(context);
    final hours = use24
        ? [for (var h = 0; h < 24; h++) h]
        // Ordered 12, 1..11 so the grid reads like a clock face.
        : [for (var h = 0; h < 12; h++) (_isPm ? 12 : 0) + ((h + 12) % 12)];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewPaddingOf(context).bottom + 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Pallets.grey90,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: TextView(
                    text: widget.title,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlackV2,
                  ),
                ),
                TextView(
                  text: "Cancel",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Pallets.grey400,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Pallets.grey90),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!use24) ...[
                  Row(
                    children: [
                      for (final pm in [false, true]) ...[
                        Expanded(
                          child: SelectablePill(
                            label: pm ? "PM" : "AM",
                            selected: _isPm == pm,
                            enabled: _periodEnabled(pm),
                            labelSize: 13,
                            radius: 10,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            onTap: () => _selectPeriod(pm),
                          ),
                        ),
                        if (!pm) 8.horizontalSpace,
                      ],
                    ],
                  ),
                  20.verticalSpace,
                ],
                const SectionLabel("Hour"),
                10.verticalSpace,
                _Grid(
                  perRow: _tilesPerRow,
                  children: [
                    for (final hour in hours)
                      SelectablePill(
                        label: _hourLabel(hour, use24),
                        selected: hour == _hour24,
                        enabled: _hourEnabled(hour),
                        labelSize: 13,
                        radius: 10,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        onTap: () => _selectHour(hour),
                      ),
                  ],
                ),
                if (_showsMinutes) ...[
                  20.verticalSpace,
                  const SectionLabel("Minute"),
                  10.verticalSpace,
                  _Grid(
                    perRow: _minuteOptions.length > 4
                        ? _tilesPerRow
                        : _minuteOptions.length,
                    children: [
                      for (final minute in _minuteOptions)
                        SelectablePill(
                          label: ":${minute.toString().padLeft(2, '0')}",
                          selected: minute == _minute,
                          enabled: _allowed(_hour24 * 60 + minute),
                          labelSize: 13,
                          radius: 10,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          onTap: () => _selectMinute(minute),
                        ),
                    ],
                  ),
                ],
                24.verticalSpace,
                CustomButton(
                  elevation: 0,
                  bgColor: Pallets.blueBubbleColor,
                  onPressed: () => Navigator.of(context).pop(
                    TimeOfDay(hour: _hour24, minute: _minute),
                  ),
                  child: TextView(
                    // Echoes the pick so the choice is confirmed before it is
                    // committed, and gives Done a full-width tap target.
                    text: MaterialLocalizations.of(context).formatTimeOfDay(
                      TimeOfDay(hour: _hour24, minute: _minute),
                    ),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Lays [children] out in equal-width rows of at most [perRow].
///
/// A Row of Expanded rather than a Wrap so tiles share the width evenly and
/// line up into columns on every screen size.
class _Grid extends StatelessWidget {
  const _Grid({required this.children, required this.perRow});

  final List<Widget> children;
  final int perRow;

  @override
  Widget build(BuildContext context) {
    final rows = <List<Widget>>[];
    for (var i = 0; i < children.length; i += perRow) {
      rows.add(children.sublist(
        i,
        i + perRow > children.length ? children.length : i + perRow,
      ));
    }

    return Column(
      children: [
        for (var r = 0; r < rows.length; r++) ...[
          Row(
            children: [
              for (var c = 0; c < perRow; c++) ...[
                // Pad the final row with blanks so its tiles keep the same
                // width as every other row's.
                Expanded(
                  child: c < rows[r].length
                      ? rows[r][c]
                      : const SizedBox.shrink(),
                ),
                if (c < perRow - 1) 8.horizontalSpace,
              ],
            ],
          ),
          if (r < rows.length - 1) 8.verticalSpace,
        ],
      ],
    );
  }
}
