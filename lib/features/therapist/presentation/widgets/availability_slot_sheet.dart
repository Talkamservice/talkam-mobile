import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/section_label.dart';
import 'package:talkam/common/widgets/selectable_pill.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/common/widgets/time_select_sheet.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/time_format.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:uuid/uuid.dart';

/// Add or edit one recurring availability window.
///
/// Every rule is enforced by [WeeklyAvailability.validate] — this sheet never
/// re-implements the interval logic, it only decides how to present it.
class AvailabilitySlotSheet extends StatefulWidget {
  const AvailabilitySlotSheet({
    super.key,
    required this.availability,
    this.editing,
  });

  /// The whole week, so a candidate can be checked against every other window.
  final WeeklyAvailability availability;

  /// Non-null when editing an existing window.
  final AvailabilitySlot? editing;

  static Future<AvailabilitySlot?> show(
    BuildContext context, {
    required WeeklyAvailability availability,
    AvailabilitySlot? editing,
  }) =>
      CustomDialogs.showBottomSheet<AvailabilitySlot>(
        context,
        AvailabilitySlotSheet(availability: availability, editing: editing),
      );

  @override
  State<AvailabilitySlotSheet> createState() => _AvailabilitySlotSheetState();
}

class _AvailabilitySlotSheetState extends State<AvailabilitySlotSheet> {
  /// Stable for the lifetime of the sheet: a new window keeps one generated id
  /// so `replacingId` can exclude the in-progress row from its own comparison,
  /// exactly as it does when editing.
  late final String _id = widget.editing?.id ?? const Uuid().v4();

  late Weekday _day = widget.editing?.day ?? Weekday.monday;
  late int? _start = widget.editing?.startMinutes;
  late int? _end = widget.editing?.endMinutes;

  bool get _isEditing => widget.editing != null;

  bool get _isComplete => _start != null && _end != null;

  AvailabilitySlot? get _candidate => _isComplete
      ? AvailabilitySlot(
          id: _id,
          day: _day,
          startMinutes: _start!,
          endMinutes: _end!,
        )
      : null;

  SlotValidationError? get _error {
    final candidate = _candidate;
    if (candidate == null) return null;
    return widget.availability.validate(candidate, replacingId: _id);
  }

  bool get _canSubmit => _isComplete && _error == null;

  int _toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  /// A start inside an existing window can never yield a valid range — every
  /// end after it would overlap. Also needs room for the minimum duration
  /// before the end of the day.
  bool _isStartEnabled(TimeOfDay time) {
    final minutes = _toMinutes(time);
    if (minutes + kMinSlotMinutes > kLatestEndMinutes) return false;
    return !widget.availability.slots.any(
      (s) =>
          s.id != _id &&
          s.day == _day &&
          minutes >= s.startMinutes &&
          minutes < s.endMinutes,
    );
  }

  /// Delegates wholesale to [WeeklyAvailability.validate], so an end time that
  /// would be rejected simply cannot be picked. Overlap stops being an error to
  /// recover from and becomes unreachable on the common path.
  bool _isEndEnabled(TimeOfDay time) {
    if (_start == null) return true;
    return widget.availability.validate(
          AvailabilitySlot(
            id: _id,
            day: _day,
            startMinutes: _start!,
            endMinutes: _toMinutes(time),
          ),
          replacingId: _id,
        ) ==
        null;
  }

  Future<void> _pickStart() async {
    final picked = await TimeSelectSheet.show(
      context,
      title: "Start time",
      initialTime: TimeOfDay(
        hour: (_start ?? 9 * 60) ~/ 60,
        minute: (_start ?? 9 * 60) % 60,
      ),
      startMinutes: 0,
      endMinutes: kLatestEndMinutes,
      minuteStep: kSlotMinuteStep,
      isEnabled: _isStartEnabled,
    );
    if (picked == null) return;

    setState(() {
      _start = _toMinutes(picked);
      // A later start can invalidate an already-chosen end; clear it rather
      // than leave a silently broken range on screen.
      if (_end != null && _end! <= _start!) _end = null;
    });
  }

  Future<void> _pickEnd() async {
    final fallback = (_start ?? 9 * 60) + kMinSlotMinutes;
    final picked = await TimeSelectSheet.show(
      context,
      title: "End time",
      initialTime: TimeOfDay(
        hour: (_end ?? fallback) ~/ 60,
        minute: (_end ?? fallback) % 60,
      ),
      startMinutes: 0,
      endMinutes: kLatestEndMinutes,
      minuteStep: kSlotMinuteStep,
      isEnabled: _isEndEnabled,
    );
    if (picked == null) return;
    setState(() => _end = _toMinutes(picked));
  }

  /// The overlap message names the window it clashes with — the difference
  /// between a usable error and a dead end.
  String? _errorText(BuildContext context) {
    final error = _error;
    if (error == null) return null;

    switch (error) {
      case SlotValidationError.endBeforeStart:
        return "End time must be after the start time.";
      case SlotValidationError.tooShort:
        return "A time range must be at least $kMinSlotMinutes minutes.";
      case SlotValidationError.tooLong:
        return "A time range can't be longer than "
            "${formatDurationShort(kMaxSlotMinutes)}. Split it into two.";
      case SlotValidationError.outsideDayBounds:
        return "A time range must end by "
            "${formatMinutesOfDay(context, kLatestEndMinutes)}.";
      case SlotValidationError.overlap:
        final clash =
            widget.availability.conflictFor(_candidate!, replacingId: _id);
        if (clash == null) return "This overlaps another time range.";
        return "This overlaps ${clash.day.label} "
            "${formatSlotRange(context, clash)}. Pick a different time.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorText = _errorText(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        // Keeps the primary button clear of the iPhone home indicator.
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
                    text: _isEditing ? "Edit time range" : "Add time range",
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
                const SectionLabel("Day"),
                12.verticalSpace,
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    for (final day in Weekday.values)
                      SelectablePill(
                        label: day.shortLabel.toUpperCase(),
                        selected: day == _day,
                        style: SelectablePillStyle.solid,
                        labelSize: 11,
                        radius: 8,
                        width: 44.w,
                        height: 32.h,
                        padding: EdgeInsets.zero,
                        onTap: () => setState(() => _day = day),
                      ),
                  ],
                ),
                20.verticalSpace,
                const SectionLabel("Time"),
                12.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: SelectablePill(
                        label: _start == null
                            ? "--:--"
                            : formatMinutesOfDay(context, _start!),
                        caption: "Start",
                        selected: false,
                        labelSize: 14,
                        labelWeight: FontWeight.w600,
                        radius: 12,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 12.w),
                        onTap: _pickStart,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Icon(Icons.chevron_right_rounded,
                          size: 18.sp, color: Pallets.grey400),
                    ),
                    Expanded(
                      child: SelectablePill(
                        label: _end == null
                            ? "--:--"
                            : formatMinutesOfDay(context, _end!),
                        caption: "End",
                        selected: false,
                        enabled: _start != null,
                        labelSize: 14,
                        labelWeight: FontWeight.w600,
                        radius: 12,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 12.w),
                        onTap: _pickEnd,
                      ),
                    ),
                  ],
                ),
                if (errorText != null) ...[
                  10.verticalSpace,
                  TextView(
                    text: errorText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Pallets.errorRed,
                    lineHeight: 1.4,
                  ),
                ],
                24.verticalSpace,
                CustomButton(
                  elevation: 0,
                  // CustomButton's own disabled styling is broken
                  // (withAlpha(-200)), so the colour is swapped manually —
                  // the convention across every V2 screen.
                  bgColor: _canSubmit
                      ? Pallets.blueBubbleColor
                      : Pallets.lightBlue,
                  onPressed: _canSubmit
                      ? () => Navigator.of(context).pop(_candidate)
                      : null,
                  child: TextView(
                    text: _isEditing ? "Save changes" : "Add time range",
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
