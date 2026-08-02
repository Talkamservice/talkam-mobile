import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/comment_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/comment_reaction_buttton.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Plain heart/comment/share icon row shown under a comment's body — no
/// inline counts, matching the post-detail icon row's style.
class CommentActions extends StatefulWidget {
  final int likeCount;
  final int dislikeCount;
  final String postId;
  final VoidCallback onCommentTap;
  final VoidCallback onCommentDeleted;
  final VoidCallback onLikeTap;
  final PostComment comment;

  const CommentActions({
    required this.likeCount,
    required this.onCommentTap,
    required this.postId,
    required this.onLikeTap,
    required this.dislikeCount,
    required this.onCommentDeleted,
    required this.comment,
  });

  @override
  State<CommentActions> createState() => _CommentActionsState();
}

class _CommentActionsState extends State<CommentActions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CommentReactionButton(
              reactionType: ReactionType.like,
              id: widget.comment.id.toString(),
              reaction: widget.comment.reaction,
              onLikeAdded: () {
                if (widget.comment.reaction?.isDisLike ?? false) {
                  widget.comment.unlikes -= 1;
                }
                widget.comment.reaction = PostReaction.like();
                widget.comment.likes += 1;
                setState(() {});
              },
              onLikeCountReduced: () {
                widget.comment.likes -= 1;
                setState(() {});
              },
              onDisliked: () {},
              onReactionRemoved: () {
                widget.comment.reaction = null;
              },
            ),
            4.horizontalSpace,
            TextView(
              text: widget.comment.likes.toString(),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        18.horizontalSpace,
        InkWell(
          onTap: widget.onCommentTap,
          child: Row(
            children: [
              ImageWidget(imageUrl: Assets.images.svgV2.commentIcon, size: 20),
              4.horizontalSpace,
              TextView(
                text: "${widget.comment.children.length}",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        18.horizontalSpace,
        InkWell(
          onTap: () =>
              Helpers.share("${UrlConfig.webUrl}comment/${widget.comment.id}"),
          child: ImageWidget(imageUrl: Assets.images.svgV2.shareIcon, size: 20),
        ),
      ],
    );
  }
}

/// The comment's own "⋮" menu — separate from the icon row, sits beside the
/// name/timestamp per the mockup.
class CommentMenuButton extends StatelessWidget {
  const CommentMenuButton({
    super.key,
    required this.comment,
    required this.postId,
    required this.onCommentDeleted,
  });

  final PostComment comment;
  final String postId;
  final VoidCallback onCommentDeleted;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        CustomDialogs.showCustomDialog(
          CommentActionSheet(
            comment: comment,
            postId: postId,
            onDeleted: onCommentDeleted,
          ),
          context,
        );
      },
      icon: const Icon(Icons.more_vert, size: 20),
    );
  }
}
