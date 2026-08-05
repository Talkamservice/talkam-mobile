import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupActionSheet extends StatelessWidget {
  const GroupActionSheet({super.key, required this.group});

  final TalkamGroup group;

  @override
  Widget build(BuildContext context) {
    bool isPublic = group.isPublic;
    bool isFollowing = group.isFollowing ?? false;
    String visibilityText = isPublic ? "Public" : "Private";

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
        children: [
          if (!isFollowing)
            _GroupAction(
              title: "Follow Group",
              onTap: () {
                context.pop();
                CustomDialogs.showToast("Coming soon");
              },
            ),
          _GroupAction(
            title: "Share $visibilityText Group",
            onTap: () {
              context.pop();
              CustomDialogs.showToast("Coming soon");
            },
          ),
          _GroupAction(
            title: "Report $visibilityText Group",
            onTap: () {
              context.pop();
              CustomDialogs.showToast("Coming soon");
            },
          ),
          if (isFollowing)
            _GroupAction(
              title: "Leave group",
              color: Pallets.red,
              onTap: () {
                context.pop();
                CustomDialogs.showToast("Coming soon");
              },
            ),
        ],
      ),
    );
  }
}

class _GroupAction extends StatelessWidget {
  const _GroupAction({required this.title, required this.onTap, this.color});

  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SizedBox(
          width: double.infinity,
          child: TextView(
            text: title,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: color ?? context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
