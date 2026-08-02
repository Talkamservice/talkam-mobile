import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

class SubscribeButton extends StatelessWidget {
  const SubscribeButton({super.key, required this.onTap, this.text = "Subscribe", this.child, this.color});

  final VoidCallback onTap;
  final String text;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color ?? Pallets.blueBubbleColor,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: child ?? TextView(
            text: text,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13),
      ),
    );
  }
}
