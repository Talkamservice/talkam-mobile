import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/bloc/comments/comments_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/comment_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/comment_reaction_buttton.dart';

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
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GuestUserHelper.guestUserWidget(widget:  InkWell(
          onTap: () {
            context
                .read<CommentsBloc>()
                .add(CommentsEvent.selectCommentForReply(widget.comment));
          },
          child: TextView(
            text: "Reply",
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),  guestWidget: 0.verticalSpace),

        39.horizontalSpace,
        Row(
          children: [
            TextView(
              text: widget.comment.likes.toString(),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            16.horizontalSpace,
            CommentReactionButton(
              reactionType: ReactionType.like,
              id: widget.comment.id.toString(),
              reaction: widget.comment.reaction,
              onLikeAdded: () {
                if (widget.comment.reaction?.isDisLike ?? false) {
                  widget.comment.unlikes -= 1;
                }else{

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
            16.horizontalSpace,
            TextView(
              text: widget.comment.unlikes.toString(),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            16.horizontalSpace,
            CommentReactionButton(
              reactionType: ReactionType.dislike,
              id: widget.comment.id.toString(),
              reaction: widget.comment.reaction,
              onLikeAdded: () {},
              onLikeCountReduced: () {
                widget.comment.likes -= 1;
                setState(() {});
              },
              onDisliked: () {
                widget.comment.reaction = PostReaction.dislike();
                widget.comment.unlikes += 1;
                setState(() {});
              },
              onReactionRemoved: () {
                if (widget.comment.unlikes >= 1) {
                  widget.comment.unlikes -= 1;
                }
                widget.comment.reaction = null;
                setState(() {});
              },
            ),
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              CustomDialogs.showBottomSheet(
                  context,
                  CommentActionSheet(
                    comment: widget.comment,
                    postId: widget.postId,
                    onDeleted: widget.onCommentDeleted,
                  ));
            },
            icon: const Icon(Icons.more_vert))
      ],
    );
  }
}

ButtonStyle get outlinedBorderStyle {
  return TextButton.styleFrom(
      elevation: 0,
      foregroundColor: Pallets.grey,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      shape: const StadiumBorder(side: BorderSide(color: Pallets.borderGrey)));
}
