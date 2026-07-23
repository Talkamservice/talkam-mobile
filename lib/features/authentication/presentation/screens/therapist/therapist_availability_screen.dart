import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_data.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

const List<({int minutes, String label})> kSessionDurations = [
  (minutes: 15, label: "Standard"),
  (minutes: 20, label: "Express"),
  (minutes: 30, label: "Extended"),
];

const List<int> kBufferOptions = [0, 10, 15];

/// Step 4 of 5 — Availability.
class TherapistAvailabilityScreen extends StatelessWidget {
  const TherapistAvailabilityScreen({super.key, required this.bloc});

  final TherapistApplicationBloc bloc;

  Future<void> _pickTime(
      BuildContext context, DayAvailability day, {required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? day.start : day.end,
    );
    if (picked == null) return;

    bloc.add(SetWorkingHoursEvent(
      day.day,
      start: isStart ? picked : null,
      end: isStart ? null : picked,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<TherapistApplicationBloc, TherapistApplicationState>(
        bloc: bloc,
        builder: (context, state) {
          final activeDays =
              state.availability.days.where((d) => d.active).toList();

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StepProgressBar(
                  step: 4,
                  totalSteps: 5,
                  label: "Availability",
                ),
                20.verticalSpace,
                const TextView(
                  text: "Set your availability",
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Pallets.boldBlackV2,
                ),
                8.verticalSpace,
                const TextView(
                  text:
                      "Choose when clients can book you. You can edit this anytime.",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),
                24.verticalSpace,

                // ── Session duration ─────────────────────────────────
                const TextView(
                  text: "SESSION DURATION",
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Pallets.grey400,
                ),
                10.verticalSpace,
                Row(
                  children: [
                    for (final option in kSessionDurations) ...[
                      Expanded(
                        child: _DurationChip(
                          minutes: option.minutes,
                          label: option.label,
                          selected: state.availability.sessionDurationMinutes ==
                              option.minutes,
                          onTap: () => bloc
                              .add(SetSessionDurationEvent(option.minutes)),
                        ),
                      ),
                      if (option != kSessionDurations.last) 8.horizontalSpace,
                    ],
                  ],
                ),
                24.verticalSpace,

                // ── Working days ──────────────────────────────────────
                const TextView(
                  text: "WORKING DAYS",
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Pallets.grey400,
                ),
                10.verticalSpace,
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    for (final day in state.availability.days)
                      _DayChip(
                        day: day,
                        onTap: () => bloc.add(ToggleWorkingDayEvent(day.day)),
                      ),
                  ],
                ),
                24.verticalSpace,

                // ── Working hours ─────────────────────────────────────
                if (activeDays.isNotEmpty) ...[
                  const TextView(
                    text: "WORKING HOURS",
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Pallets.grey400,
                  ),
                  10.verticalSpace,
                  for (final day in activeDays) ...[
                    _WorkingHoursRow(
                      day: day,
                      onTapStart: () =>
                          _pickTime(context, day, isStart: true),
                      onTapEnd: () => _pickTime(context, day, isStart: false),
                      onTogglePaid: () =>
                          bloc.add(ToggleDayPaidEvent(day.day)),
                    ),
                    12.verticalSpace,
                  ],
                  8.verticalSpace,
                ],

                // ── Buffer ─────────────────────────────────────────────
                const TextView(
                  text: "Buffer between sessions",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Pallets.boldBlackV2,
                ),
                4.verticalSpace,
                const TextView(
                  text: "Gives you time to write Notes",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                ),
                10.verticalSpace,
                Row(
                  children: [
                    for (final minutes in kBufferOptions) ...[
                      Expanded(
                        child: _DurationChip(
                          minutes: minutes,
                          label: null,
                          selected: state.availability.bufferMinutes == minutes,
                          onTap: () => bloc.add(SetBufferEvent(minutes)),
                        ),
                      ),
                      if (minutes != kBufferOptions.last) 8.horizontalSpace,
                    ],
                  ],
                ),

                32.verticalSpace,
                CustomButton(
                  elevation: 0,
                  onPressed: state.availability.isValid
                      ? () => context.pushNamed(
                            PageUrl.therapistPayoutScreen,
                            extra: bloc,
                          )
                      : null,
                  bgColor: Pallets.blueBubbleColor,
                  borderRadius: BorderRadius.circular(24.r),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const TextView(
                    text: "Continue",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                24.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.minutes,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final int minutes;
  final String? label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: selected
              ? Pallets.blueBubbleColor.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? Pallets.blueBubbleColor : Pallets.grey90,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            TextView(
              text: "$minutes min",
              align: TextAlign.center,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color:
                  selected ? Pallets.blueBubbleColor : Pallets.boldBlackV2,
            ),
            if (label != null) ...[
              2.verticalSpace,
              TextView(
                text: label!,
                align: TextAlign.center,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Pallets.grey400,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.day, required this.onTap});

  final DayAvailability day;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: day.active ? Pallets.blueBubbleColor : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: day.active ? Pallets.blueBubbleColor : Pallets.grey90,
          ),
        ),
        child: TextView(
          text: day.day.substring(0, 3).toUpperCase(),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: day.active ? Colors.white : Pallets.boldBlackV2,
        ),
      ),
    );
  }
}

class _WorkingHoursRow extends StatelessWidget {
  const _WorkingHoursRow({
    required this.day,
    required this.onTapStart,
    required this.onTapEnd,
    required this.onTogglePaid,
  });

  final DayAvailability day;
  final VoidCallback onTapStart;
  final VoidCallback onTapEnd;
  final VoidCallback onTogglePaid;

  String _format(BuildContext context, TimeOfDay time) =>
      MaterialLocalizations.of(context).formatTimeOfDay(time);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Pallets.bgLight,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 36.w,
                child: TextView(
                  text: day.day,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
              ),
              Expanded(
                child: _TimePill(
                  label: _format(context, day.start),
                  onTap: onTapStart,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Icon(Icons.chevron_right_rounded,
                    size: 18.sp, color: Pallets.grey400),
              ),
              Expanded(
                child: _TimePill(
                  label: _format(context, day.end),
                  onTap: onTapEnd,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            children: [
              const TextView(
                text: "Paid",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Pallets.boldBlackV2,
              ),
              const Spacer(),
              CustomSwitch(value: day.paid, onChanged: (_) => onTogglePaid()),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimePill extends StatelessWidget {
  const _TimePill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Pallets.grey90),
        ),
        child: TextView(
          text: label,
          align: TextAlign.center,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Pallets.boldBlackV2,
        ),
      ),
    );
  }
}
