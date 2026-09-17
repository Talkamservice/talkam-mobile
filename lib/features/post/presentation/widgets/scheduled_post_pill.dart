import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
class ScheduledPostPill extends StatelessWidget {
  const ScheduledPostPill({super.key, required this.showScheduledPost, required this.post});
  final bool showScheduledPost;
  final TalkamPost post;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (showScheduledPost)
        Padding(
          // Horizontal placement (and matching the post card's own
          // padding) is left to the caller — this only owns its own
          // vertical spacing and internal text inset.
          padding: EdgeInsets.only(top: 10.h),
          child: Container(
            width: double.infinity,
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: Pallets.tabBarBlue,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextView(
                text:
                    "Scheduled for ${DateFormat("dd MMMM, yyyy - hh:mm a").format(post.publishAt!)}",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
        )
    ],);
  }
}
