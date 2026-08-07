import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/features/notifications/presentation/widgets/therapist_action_dialogs.dart';

class SessionActionSheets {
  static void showRescheduleSheet(BuildContext context, SessionModel session) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _RescheduleStepOneSheet(session: session),
    );
  }

  static void showCancelSheet(BuildContext context, SessionModel session) {
    TherapistActionDialogs.showDeclineReasonBottomSheet(context, session: session);
  }

  static void showStatusDialog(BuildContext context, {required bool isSuccess}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _SessionStatusDialog(isSuccess: isSuccess),
    );
  }

  static void showInSessionNotesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      builder: (context) => const _InSessionNotesSheet(),
    );
  }
}

class _RescheduleStepOneSheet extends StatefulWidget {
  final SessionModel session;

  const _RescheduleStepOneSheet({required this.session});

  @override
  State<_RescheduleStepOneSheet> createState() => _RescheduleStepOneSheetState();
}

class _RescheduleStepOneSheetState extends State<_RescheduleStepOneSheet> {
  String _selectedDay = "MON";
  String _startTime = "9:00 AM";
  String _endTime = "5:00 PM";

  final List<String> _days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

  void _pickTime(bool isStart) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TimePickerSheet(
        initialTime: isStart ? _startTime : _endTime,
        onSelected: (time) {
          setState(() {
            if (isStart) {
              _startTime = time;
            } else {
              _endTime = time;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          20.verticalSpace,
          TextView(
            text: "Reschedule this\nsession?",
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
            lineHeight: 1.2,
          ),
          8.verticalSpace,
          TextView(
            text: "${widget.session.therapistName} • Wed Jul 16 • 2:00PM",
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF94A3B8),
          ),
          24.verticalSpace,
          TextView(
            text: "DAYS",
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF475569),
          ),
          12.verticalSpace,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _days.map((day) {
                final isSelected = _selectedDay == day;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = day;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: TextView(
                      text: day,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Pallets.white : const Color(0xFF64748B),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          24.verticalSpace,
          TextView(
            text: "WORKING HOURS",
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF475569),
          ),
          12.verticalSpace,
          Row(
            children: [
              TextView(
                text: "Mon",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Pallets.boldBlack,
              ),
              16.horizontalSpace,
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickTime(true),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Pallets.white,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        TextView(
                          text: _startTime,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Pallets.boldBlack,
                        ),
                        2.verticalSpace,
                        TextView(
                          text: "Start",
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF94A3B8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Icon(
                Icons.chevron_right_rounded,
                color: const Color(0xFF94A3B8),
                size: 20.w,
              ),
              12.horizontalSpace,
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickTime(false),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Pallets.white,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        TextView(
                          text: _endTime,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Pallets.boldBlack,
                        ),
                        2.verticalSpace,
                        TextView(
                          text: "End",
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF94A3B8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          32.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: const Color(0xFFF8FAFC),
                  child: TextView(
                    text: "Keep session",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      useSafeArea: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => _RescheduleReasonSheet(session: widget.session),
                    );
                  },
                  text: "Next",
                ),
              ),
            ],
          ),
          20.verticalSpace,
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    ),
    );
  }
}

class _TimePickerSheet extends StatelessWidget {
  final String initialTime;
  final ValueChanged<String> onSelected;

  const _TimePickerSheet({
    required this.initialTime,
    required this.onSelected,
  });

  static const List<String> _times = [
    "12:00 AM",
    "1:00 AM",
    "2:00 AM",
    "3:00 AM",
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "1:00 PM",
    "2:00 PM",
    "5:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 0.7.sh),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Select Time",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlack,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: TextView(
                  text: "Done",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Pallets.blueBubbleColor,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _times.map((t) {
                  final isSelected = t == initialTime;
                  return GestureDetector(
                    onTap: () {
                      onSelected(t);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Pallets.blueBubbleColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Center(
                        child: TextView(
                          text: t,
                          fontSize: 15,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? Pallets.white : Pallets.boldBlack,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          16.verticalSpace,
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class _RescheduleReasonSheet extends StatefulWidget {
  final SessionModel session;

  const _RescheduleReasonSheet({required this.session});

  @override
  State<_RescheduleReasonSheet> createState() => _RescheduleReasonSheetState();
}

class _RescheduleReasonSheetState extends State<_RescheduleReasonSheet> {
  String _selectedReason = "Technical issues";

  final List<String> _reasons = [
    "Personal emergency",
    "Technical issues",
    "Client request",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          20.verticalSpace,
          TextView(
            text: "Reschedule this\nsession?",
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
            lineHeight: 1.2,
          ),
          8.verticalSpace,
          TextView(
            text: "${widget.session.therapistName} • Wed Jul 16 • 2:00PM",
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF94A3B8),
          ),
          24.verticalSpace,
          TextView(
            text: "REASON FOR RESCHEDULE",
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF475569),
          ),
          12.verticalSpace,
          ..._reasons.map((reason) {
            final isSelected = _selectedReason == reason;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedReason = reason;
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF4FBFF) : Pallets.white,
                  border: Border.all(
                    color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFE2E8F0),
                    width: isSelected ? 1.5 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: reason,
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? Pallets.blueBubbleColor : Pallets.boldBlack,
                    ),
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFCBD5E1),
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: const BoxDecoration(
                                  color: Pallets.blueBubbleColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: const Color(0xFFF8FAFC),
                  child: TextView(
                    text: "Keep session",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                    final isSuccess = Random().nextBool();
                    SessionActionSheets.showStatusDialog(context, isSuccess: isSuccess);
                  },
                  bgColor: const Color(0xFFEF4444),
                  text: "Reschedule",
                ),
              ),
            ],
          ),
          20.verticalSpace,
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    ),
    );
  }
}

class _SessionStatusDialog extends StatelessWidget {
  final bool isSuccess;

  const _SessionStatusDialog({required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
      backgroundColor: Pallets.white,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            12.verticalSpace,
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: isSuccess ? const Color(0xFFE6F9F0) : const Color(0xFFFFF1F2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSuccess ? const Color(0xFFDCFCE7) : const Color(0xFFFFE4E6),
                  width: 5.w,
                ),
              ),
              child: Center(
                child: Icon(
                  isSuccess ? Icons.check_rounded : Icons.close_rounded,
                  color: isSuccess ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                  size: 40.w,
                ),
              ),
            ),
            20.verticalSpace,
            TextView(
              text: isSuccess ? "Session Rescheduled" : "Session Declined",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlack,
            ),
            12.verticalSpace,
            TextView(
              text: isSuccess
                  ? "Your session is rescheduled. Continue using the service uninterrupted."
                  : "Your rescheduled session has been declined",
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
              align: TextAlign.center,
              lineHeight: 1.4,
            ),
            24.verticalSpace,
            CustomButton(
              onPressed: () => Navigator.pop(context),
              bgColor: isSuccess ? Pallets.blueBubbleColor : const Color(0xFFEF4444),
              text: isSuccess ? "Back to sessions" : "Try again",
            ),
            8.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _InSessionNotesSheet extends StatefulWidget {
  const _InSessionNotesSheet();

  @override
  State<_InSessionNotesSheet> createState() => _InSessionNotesSheetState();
}

class _InSessionNotesSheetState extends State<_InSessionNotesSheet> {
  final TextEditingController _noteController =
      TextEditingController(text: "Clients reports sleeping better this week");

  final Set<String> _selectedChips = {"Anxiety", "Depression"};

  final List<String> _chips = [
    "Anxiety",
    "Depression",
    "Trauma & PTSD",
    "Grief",
    "Bipolar",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        top: 16.h,
        left: 20.w,
        right: 20.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          16.verticalSpace,
          const TextView(
            text: "Session Notes",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
          ),
          16.verticalSpace,

          // Tag Chips
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _chips.map((chip) {
              final isSelected = _selectedChips.contains(chip);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedChips.remove(chip);
                    } else {
                      _selectedChips.add(chip);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? Pallets.blueBubbleColor : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: TextView(
                    text: chip,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              );
            }).toList(),
          ),
          20.verticalSpace,

          // Notes Input Box
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Pallets.blueBubbleColor, width: 1.5),
            ),
            child: TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter session notes...",
              ),
              style: TextStyle(
                fontSize: 14.sp,
                color: Pallets.boldBlack,
              ),
            ),
          ),
          24.verticalSpace,

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: const Color(0xFFF8FAFC),
                  child: const TextView(
                    text: "Save draft",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: Pallets.blueBubbleColor,
                  child: const TextView(
                    text: "Save & Close",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,
        ],
      ),
    )
    );
  }
}
