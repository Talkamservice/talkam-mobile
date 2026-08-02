import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';

class AppActionSheet extends StatelessWidget {
  final List<Widget> actions;

  const AppActionSheet({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: actions,
      ),
    );
  }
}

class AppActionItem extends StatelessWidget {
  const AppActionItem({super.key, required this.title, required this.onTap, this.textColor});

  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: TextView(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: textColor ?? context.theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
