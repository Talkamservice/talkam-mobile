import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/core/theme/pallets.dart';

class TimePickerButton extends StatelessWidget {
  const TimePickerButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Pallets.borderGrey.withOpacity(0.2),
        shape: const StadiumBorder(
          side: BorderSide(color: Pallets.borderGrey),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Pallets.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          10.horizontalSpace,
          const Icon(
            color: Pallets.grey,
            Icons.keyboard_arrow_down_rounded,
          ),
        ],
      ),
    );
  }
}
