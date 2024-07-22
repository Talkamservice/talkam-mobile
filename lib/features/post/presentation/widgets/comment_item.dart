import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/readmore_text.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/presentation/bloc/comments/comments_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/comment_actions.dart';
import 'package:talkam/features/post/presentation/widgets/comment_input_widget.dart';
import 'package:talkam/gen/assets.gen.dart';

class CommentItem extends StatefulWidget {
  const CommentItem(
      {super.key,
      this.isReply = false,
      this.hasReply = false,
      required this.comment,
      required this.posId,
      this.parentId});

  final PostComment comment;
  final bool? isReply;
  final bool? hasReply;
  final int posId;
  final int? parentId;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool repliesCollapsed = true;
  bool reply = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: context.theme.cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageWidget(
                    imageUrl: widget.comment.user.avatar ??
                        Assets.images.png.appIcon.path,
                    size: widget.isReply! ? 24 : 36,
                    fit: BoxFit.contain,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextView(
                              text: posterName,
                              fontWeight: FontWeight.w700,
                            ),
                            4.horizontalSpace,
                            ImageWidget(imageUrl: Assets.images.svgs.grid03),
                            4.horizontalSpace,
                            TextView(
                              text: TimeUtil.getTimeAgo(widget.comment.createdAt
                                  .toLocal()
                                  .toIso8601String()),
                              fontWeight: FontWeight.w700,
                              color: context.colorScheme.primary,
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        ReadMoreText(text: widget.comment.comment),
                        // TextView(
                        //   text: widget.comment.comment,
                        //   fontSize: 16,
                        // ),
                        10.verticalSpace,
                        if (widget.comment.attachment != null)
                          ImageWidget(
                            imageUrl: widget.comment.attachment!,
                            height: 150,
                            width: 1.sw,
                          ),
                        16.verticalSpace,
                        CommentActions(
                          likeCount: 2,
                          onCommentTap: () {},
                          onLikeTap: () {},
                          dislikeCount: 3,
                          comment: widget.comment,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if (commentHasChildren)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        repliesCollapsed = !repliesCollapsed;
                        setState(() {});
                      },
                      child: TextView(
                        text: collapsText,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              if (isReplying(context))
                CommentInputWidget(
                    parentComment: widget.parentId ?? widget.comment.id,
                    replyComment: widget.comment.id,
                    onCommentSubmitted: (comment) {
                      context
                          .read<CommentsBloc>()
                          .add(const CommentsEvent.selectCommentForReply(null));

                      context
                          .read<CommentsBloc>()
                          .add(CommentsEvent.saveAComment(comment));
                    },
                    postId: widget.posId),
              if (commentHasChildren)
                AnimatedCrossFade(
                    firstChild: Column(
                      children: widget.comment.children
                          .map((e) => CommentItem(
                                isReply: true,
                                parentId: widget.comment.id,
                                comment: e,
                                posId: widget.posId,
                              ))
                          .toList(),
                    ),
                    secondChild: 0.verticalSpace,
                    crossFadeState: repliesCrosFadeState,
                    duration: const Duration(milliseconds: 300))
            ],
          ),
        );
      },
    );
  }

  String get posterName {
    return widget.comment.isAnonymous.toBool
        ? "Anonymous"
        : widget.comment.user.usersName;
  }

  String get collapsText {
    return repliesCollapsed
        ? "View ${widget.comment.children.length} replies"
        : "Collapse";
  }

  bool get commentHasChildren => widget.comment.children.isNotEmpty;

  bool isReplying(BuildContext context) {
    return widget.comment.id ==
            context.read<CommentsBloc>().stagedComment?.id &&
        context.read<CommentsBloc>().stagedComment != null;
  }

  CrossFadeState get repliesCrosFadeState {
    return !repliesCollapsed
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond;
  }

  bool get canShowReplies => widget.hasReply! && !repliesCollapsed;
}
