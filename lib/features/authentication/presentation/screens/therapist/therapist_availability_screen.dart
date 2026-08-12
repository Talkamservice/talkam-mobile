import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/custom_switch.dart';
import 'package:talkam/common/widgets/selectable_pill.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/common/widgets/time_select_sheet.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_data.dart';
import 'package:talkam/features/therapist_application/presentation/bloc/therapist_application_bloc.dart';

const List<({int minutes, String label})> kSessionDurations = [
  (minutes: 15, label: "Standard"),
  (minutes: 20, label: "Express"),
  (minutes: 30, label: "Extended"),
  (minutes: 50, label: "Full hour"),
];

const List<int> kBufferOptions = [0, 10, 15];

/// Step 4 of 5 — Availability.
class TherapistAvailabilityScreen extends StatelessWidget {
  const TherapistAvailabilityScreen({super.key, required this.bloc});

  final TherapistApplicationBloc bloc;

  Future<void> _pickTime(BuildContext context, DayAvailability day,
      {required bool isStart}) async {
    final picked = await TimeSelectSheet.show(
      context,
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
      body: BlocConsumer<TherapistApplicationBloc, TherapistApplicationState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.availabilitySaveStatus == StepSaveStatus.saving) {
            CustomDialogs.showLoading(context);
          }
          if (state.availabilitySaveStatus == StepSaveStatus.success) {
            context.pop();
            bloc.add(const ResetSaveStatusesEvent());
            context.pushNamed(
              PageUrl.therapistPayoutScreen,
              extra: bloc,
            );
          }
          if (state.availabilitySaveStatus == StepSaveStatus.error) {
            context.pop();
            CustomDialogs.error(
                state.availabilitySaveError ?? "Something went wrong");
          }
        },
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
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Pallets.grey400,
                  lineHeight: 1.4,
                ),
                24.verticalSpace,

                // ── Session duration ─────────────────────────────────
                const TextView(
                  text: "SESSION DURATION",
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Pallets.grey400,
                ),
                10.verticalSpace,
                Row(
                  children: [
                    for (final option in kSessionDurations) ...[
                      Expanded(
                        child: SelectablePill(
                          label: "${option.minutes} min",
                          caption: option.label,
                          selected: state.availability.sessionDurationMinutes ==
                              option.minutes,
                          onTap: () =>
                              bloc.add(SetSessionDurationEvent(option.minutes)),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Pallets.grey400,
                ),
                10.verticalSpace,
                Wrap(
                  spacing: 4.w,
                  runSpacing: 8.h,
                  children: [
                    for (final day in state.availability.days)
                      SelectablePill(
                        label: day.day.substring(0, 3).toUpperCase(),
                        selected: day.active,
                        style: SelectablePillStyle.solid,
                        labelSize: 11,
                        radius: 8,
                        width: 44.w,
                        height: 30.h,
                        padding: EdgeInsets.zero,
                        onTap: () => bloc.add(ToggleWorkingDayEvent(day.day)),
                      ),
                  ],
                ),
                24.verticalSpace,

                // ── Working hours ─────────────────────────────────────
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: activeDays.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextView(
                              text: "WORKING HOURS",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Pallets.grey400,
                            ),
                            // Every day stays mounted so toggling one animates
                            // its row in/out instead of popping the list.
                            for (final day in state.availability.days)
                              AnimatedSize(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeInOut,
                                alignment: Alignment.topCenter,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 180),
                                  opacity: day.active ? 1 : 0,
                                  child: day.active
                                      ? _WorkingHoursRow(
                                          day: day,
                                          onTapStart: () => _pickTime(
                                              context, day,
                                              isStart: true),
                                          onTapEnd: () => _pickTime(
                                              context, day,
                                              isStart: false),
                                          onTogglePaid: () => bloc
                                              .add(ToggleDayPaidEvent(day.day)),
                                        )
                                      : const SizedBox(width: double.infinity),
                                ),
                              ),
                            8.verticalSpace,
                          ],
                        ),
                ),

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
                        child: SelectablePill(
                          label: "$minutes min",
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
                      ? () => bloc.add(const SaveAvailabilityEvent())
                      : null,
                  bgColor: Pallets.blueBubbleColor,
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
                child: SelectablePill(
                  label: _format(context, day.start),
                  caption: "Start",
                  selected: false,
                  labelSize: 13,
                  labelWeight: FontWeight.w600,
                  radius: 10,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                  onTap: onTapStart,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Icon(Icons.chevron_right_rounded,
                    size: 18.sp, color: Pallets.grey400),
              ),
              Expanded(
                child: SelectablePill(
                  label: _format(context, day.end),
                  caption: "End",
                  selected: false,
                  labelSize: 13,
                  labelWeight: FontWeight.w600,
                  radius: 10,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                  onTap: onTapEnd,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            children: [
              CustomSwitch(value: day.paid, onChanged: (_) => onTogglePaid()),
              SizedBox(
                width: 8.w,
              ),
              const TextView(
                text: "Paid",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Pallets.boldBlackV2,
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
