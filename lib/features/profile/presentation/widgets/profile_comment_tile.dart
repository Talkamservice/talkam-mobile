import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Same card language as [PostItem] (card background, rounded corners,
/// avatar+name header, divider before a footer line) so the Comments tab
/// reads as the same family of list as the Posts tab.
class ProfileCommentTile extends StatelessWidget {
  final TalkAmComment talkAmComment;

  const ProfileCommentTile({super.key, required this.talkAmComment});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.postDetailsScreen,
            extra: talkAmComment.post?.id.toString());
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(
                  imageUrl:
                      talkAmComment.user.avatar ?? Assets.images.svgs.user,
                  size: 32,
                  shape: BoxShape.circle,
                ),
                10.horizontalSpace,
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      TextView(
                        text: "@${talkAmComment.user.username ?? 'unknown'}",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      4.horizontalSpace,
                      Text("•", style: TextStyle(color: Pallets.grey60)),
                      4.horizontalSpace,
                      TextView(
                        text: timeago.format(talkAmComment.createdAt),
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey60,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                if (talkAmComment.isReplyingToComment) ...[
                  8.horizontalSpace,
                  ImageWidget(
                    imageUrl: talkAmComment.replyTo?.avatar ?? "",
                    width: 40.w,
                    height: 40.h,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ],
            ),
            10.verticalSpace,
            RichText(
              text: TextSpan(
                children: [
                  ...Helpers.mentionSpans(
                    talkAmComment.comment,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Pallets.black, fontSize: 13),
                    mentionCallback: (p0) {
                      Helpers.viewMentionedUserProfile(context, p0);
                    },
                  ),
                ],
              ),
            ),
            if (talkAmComment.post?.title != null &&
                talkAmComment.post!.title.toString().isNotEmpty) ...[
              10.verticalSpace,
              const Divider(thickness: 1),
              6.verticalSpace,
              TextView(
                text: "on “${talkAmComment.post!.title}”",
                fontSize: 12,
                color: Pallets.grey60,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
