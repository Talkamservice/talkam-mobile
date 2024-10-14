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
          padding: EdgeInsets.only(right: 12.w, top: 10.h),
          child: Container(
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
              color: Pallets.tabBarBlue,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextView(
                  text: "Scheduled post",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
                TextView(
                  text: DateFormat("dd MMMM, yyyy - hh:mm a")
                      .format(post.publishAt!),
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ],
            ),
          ),
        )
    ],);
  }
}
