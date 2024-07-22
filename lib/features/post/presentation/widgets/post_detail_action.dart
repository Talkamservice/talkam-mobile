import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_reaction_button.dart';
import 'package:talkam/gen/assets.gen.dart';


class PostDetailActions extends StatefulWidget {
  final int commentCount;
  final int likeCount;
  final TalkamPost post;
  final int dislikeCount;
  final VoidCallback onCommentTap;
  final VoidCallback onLikeTap;
  final VoidCallback onShareTap;

  const PostDetailActions({
    required this.commentCount,
    required this.likeCount,
    required this.onCommentTap,
    required this.onLikeTap,
    required this.onShareTap,
    required this.dislikeCount,
    required this.post,
  });

  @override
  State<PostDetailActions> createState() => _PostDetailActionsState();
}

class _PostDetailActionsState extends State<PostDetailActions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(imageUrl: Assets.images.svgs.comment),
            10.horizontalSpace,
            TextView(
              text: "${widget.commentCount} Comments",
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        5.horizontalSpace,
        TextButton(
            style: outlinedBorderStyle,
            onPressed: widget.onLikeTap,
            child: Row(
              children: [
                PostReactionButton(
                  reactionType: ReactionType.like,
                  id: widget.post.id.toString(),
                  reaction: widget.post.reaction,
                  onLikeAdded: () {
                    widget.post.reaction = PostReaction.like();
                    widget.post.likesCount += 1;
                    setState(() {});
                  },
                  onCountReduced: () {
                    widget.post.likesCount -= 1;
                    setState(() {});
                  },
                  onDisliked: () {},
                  onReactionRemoved: () {
                    widget.post.reaction = null;
                  },
                ),
                16.horizontalSpace,
                TextView(
                  text: widget.post.likesCount.toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                16.horizontalSpace,
                PostReactionButton(
                  reactionType: ReactionType.dislike,
                  id: widget.post.id.toString(),
                  reaction: widget.post.reaction,
                  onLikeAdded: () {},
                  onCountReduced: () {},
                  onDisliked: () {
                    widget.post.reaction = PostReaction.dislike();
                    if (widget.post.likesCount > 1) {
                      widget.post.likesCount -= 1;
                    }
                    setState(() {});
                  },
                  onReactionRemoved: () {
                    widget.post.reaction = null;
                    setState(() {});
                  },
                ),
              ],
            )),
        5.horizontalSpace,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(imageUrl: Assets.images.svgs.share03),
            16.horizontalSpace,
            TextView(
              text: "Share",
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ButtonStyle get outlinedBorderStyle {
    return TextButton.styleFrom(
        elevation: 0,
        foregroundColor: Pallets.grey,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        shape:
        const StadiumBorder(side: BorderSide(color: Pallets.borderGrey)));
  }
}