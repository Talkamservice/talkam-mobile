import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// Bottom-sheet time picker — a list of whole-hour slots between [startHour]
/// and [endHour] with the current pick highlighted, confirmed via "Done".
/// Used in place of the platform's dial-style [showTimePicker] to match the
/// app's own sheet style.
class TimeSelectSheet extends StatefulWidget {
  const TimeSelectSheet({
    super.key,
    required this.initialTime,
    this.startHour = 9,
    this.endHour = 17,
  });

  final TimeOfDay initialTime;

  /// Bounds are inclusive and in 24-hour form — defaults span 9:00 AM to
  /// 5:00 PM, the app's working-hours window.
  final int startHour;
  final int endHour;

  static Future<TimeOfDay?> show(
    BuildContext context, {
    required TimeOfDay initialTime,
    int startHour = 9,
    int endHour = 17,
  }) {
    return CustomDialogs.showBottomSheet<TimeOfDay>(
      context,
      TimeSelectSheet(
        initialTime: initialTime,
        startHour: startHour,
        endHour: endHour,
      ),
    );
  }

  @override
  State<TimeSelectSheet> createState() => _TimeSelectSheetState();
}

class _TimeSelectSheetState extends State<TimeSelectSheet> {
  late TimeOfDay _selected = widget.initialTime;

  late final List<TimeOfDay> _slots = [
    for (int hour = widget.startHour; hour <= widget.endHour; hour++)
      TimeOfDay(hour: hour, minute: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom + 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                const Expanded(
                  child: TextView(
                    text: "Select Time",
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlackV2,
                  ),
                ),
                TextView(
                  text: "Done",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Pallets.blueBubbleColor,
                  onTap: () => Navigator.of(context).pop(_selected),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Pallets.grey90),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: _slots.length,
              itemBuilder: (context, index) {
                final slot = _slots[index];
                final isSelected = slot.hour == _selected.hour;

                return GestureDetector(
                  onTap: () => setState(() => _selected = slot),
                  child: Container(
                    height: 52.h,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Pallets.blueBubbleColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TextView(
                      text: MaterialLocalizations.of(context)
                          .formatTimeOfDay(slot),
                      fontSize: 15,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? Colors.white : Pallets.boldBlackV2,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
