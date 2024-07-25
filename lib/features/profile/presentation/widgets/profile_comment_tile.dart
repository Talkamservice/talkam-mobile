import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileCommentTile extends StatelessWidget {
  final TalkAmComment talkAmComment;

  const ProfileCommentTile({super.key, required this.talkAmComment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "“@${talkAmComment.commentReplyTo} ",
                    style: GoogleFonts.nunito(
                      color: Pallets.boldBlackV2,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextSpan(
                    text: talkAmComment.comment,
                    style: GoogleFonts.nunito(
                      color: Pallets.boldBlackV2,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: TextView(
                  text: timeago.format(talkAmComment.createdAt),
                  color: const Color(0xFF444444),
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
        ),
        if (talkAmComment.isReplyingToComment)...[
          ImageWidget(
            imageUrl: talkAmComment.replyTo!.avatar,
            width: 64.w,
            height: 58.h,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ]
      ],
    );
  }
}
