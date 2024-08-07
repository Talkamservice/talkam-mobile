import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

class SchedulePostForm extends StatefulWidget {
  const SchedulePostForm(
      {super.key,
      required this.schedulePost,
      required this.onChanged,
      required this.onScheduleDateSelected});

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
            TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Pallets.grey,
                    padding: const EdgeInsets.all(16),
                    side:
                        const BorderSide(color: Pallets.borderGrey, width: 1)),
                onPressed: () {
                  pickDateAndTime(context);
                },
                child: Row(
                  children: [
                    Expanded(
                        child: TextView(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            text: scheduleDate != null
                                ? TimeUtil.formartToDayTime(scheduleDate!)
                                : "Date & Time")),
                    const Icon(Icons.keyboard_arrow_right)
                  ],
                ))
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

    final selectedTime = await selectTime(context);
    if (selectedTime == null) return null;

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    final now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );
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
