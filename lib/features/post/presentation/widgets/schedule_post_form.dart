import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/date_extensions.dart';

class SchedulePostForm extends StatefulWidget {
  const SchedulePostForm({super.key, required this.schedulePost, required this.onChanged, required this.onScheduleDateSelected});

  final bool schedulePost;
  final Function(bool) onChanged;
  final Function(DateTime) onScheduleDateSelected;

  @override
  State<SchedulePostForm> createState() => _SchedulePostFormState();
}

class _SchedulePostFormState extends State<SchedulePostForm> {
  DateTime? scheduleDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: context.theme.cardColor),
      child: Column(
        children: [
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextView(
                text: "Schedule this post",
                fontSize: 16,
              ),
              CupertinoSwitch(
                trackColor: Colors.grey,
                activeColor: Colors.orange,
                value: widget.schedulePost,
                onChanged: widget.onChanged,
              ),
            ],
          ),
          23.verticalSpace,
          if (widget.schedulePost)
            InkWell(
              onTap: () => pickDateAndTime(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                decoration: BoxDecoration(
                  color: Pallets.borderGrey.withOpacity(0.1),
                  border: Border.all(color: Pallets.borderGrey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minHeight: 55),
                width: 1.sw,
                child: Row(
                  children: [
                    Expanded(
                      child: TextView(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: scheduleDate != null
                            ? context.colorScheme.onSurface
                            : Pallets.grey75,
                        text: scheduleDate != null
                            ? TimeUtil.formartToDayTime(scheduleDate!)
                            : "Date & Time",
                      ),
                    ),
                    10.horizontalSpace,
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  Future<void> pickDateAndTime(BuildContext context) async {
    var date = await _selectDate(context);
    if (date != null) {
      widget.onScheduleDateSelected(date);
      scheduleDate = date;
      setState(() {});
    }
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final selectedDate = await selectDate(context);
    if (selectedDate == null) return null;

    final selectedTime = await selectTime(context, selectedDate);
    if (selectedTime == null) return null;

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  Future<TimeOfDay?> selectTime(BuildContext context, DateTime selectedDate) async {
    final now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );

    if (pickedTime != null && selectedDate.isToday && pickedTime.isBefore(TimeOfDay.now())) {
      CustomDialogs.error("Please select a future time.");

      return null;
    }
    return pickedTime;
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null && pickedDate != now) {
      return pickedDate;
    } else {
      return null; // User canceled or did not select
    }
  }
}
