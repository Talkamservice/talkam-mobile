import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/readmore_text.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/presentation/bloc/comments/comments_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/comment_actions.dart';
import 'package:talkam/features/post/presentation/widgets/reply_composer_sheet.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    this.isReply = false,
    this.hasReply = false,
    required this.comment,
    required this.posId,
    this.parentId,
    required this.replyingToName,
    this.isLast = false,
    required this.onDeleted,
  });

  final PostComment comment;
  final bool? isReply;
  final bool? hasReply;
  final int posId;
  final int? parentId;

  /// Who this comment is replying to — the post's author for top-level
  /// comments, or the parent comment's author for nested replies.
  final String replyingToName;
  final bool isLast;
  final VoidCallback onDeleted;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool repliesCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            left: (widget.isReply ?? false) ? 0 : 12,
            right: 12,
            top: 8,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: (widget.isReply ?? false) ? Colors.transparent : context.theme.cardColor,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (widget.isReply == true)
                Positioned(
                  left: avatarSize / 2 - 0.5,
                  top: -12,
                  height: widget.isLast == true ? 44 : null,
                  bottom: widget.isLast == true ? null : 0,
                  child: Container(width: 1, color: Pallets.grey90),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (canShowThreadLine)
                        Positioned(
                          left: avatarSize / 2 - 0.5,
                          top: avatarSize / 2,
                          bottom: 0,
                          child: Container(width: 1, color: Pallets.grey90),
                        ),
                      InkWell(
                        onTap: commentHasChildren ? _toggleReplies : null,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.comment.isAnonymous.toBool)
                              ImageWidget(
                                  imageUrl: Assets.images.svgs.dummyUser,
                                  size: avatarSize)
                            else
                              InkWell(
                                onTap: () => viewUserProfile(context),
                                child: IgnorePointer(
                                  child: ClipOval(
                                    child: ImageWidget(
                                      imageUrl: widget.comment.user.avatar ??
                                          Assets.images.svgs.dummyUser,
                                      size: avatarSize,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            8.horizontalSpace,
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (!widget.comment.isAnonymous.toBool) {
                                                        viewUserProfile(context);
                                                      } else {
                                                        CustomDialogs.showToast(
                                                            "User is Anonymous");
                                                      }
                                                    },
                                                    child: TextView(
                                                      text: posterName,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  6.horizontalSpace,
                                                  Text("·",
                                                      style: TextStyle(color: Pallets.grey60)),
                                                  6.horizontalSpace,
                                                  TextView(
                                                    text: TimeUtil.getTimeAgo(
                                                        widget.comment.createdAt.toString()),
                                                    color: Pallets.grey60,
                                                  ),
                                                ],
                                              ),
                                              TextView(
                                                text: "Replying to @${widget.replyingToName}",
                                                color: Pallets.blueBubbleColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                        CommentMenuButton(
                                          comment: widget.comment,
                                          postId: widget.posId.toString(),
                                          onCommentDeleted: widget.onDeleted,
                                        ),
                                      ],
                                    ),
                                    1.verticalSpace,
                                    CustomReadMoreText(
                                      text: widget.comment.comment,
                                      mentionCallback: (mention) {
                                        Helpers.viewMentionedUserProfile(
                                            context, mention);
                                      },
                                    ),
                                    if (widget.comment.attachment != null) ...[
                                      10.verticalSpace,
                                      ImageWidget(
                                        imageUrl: widget.comment.attachment!,
                                        height: 200,
                                        canPreview: true,
                                        borderRadius: BorderRadius.circular(16),
                                        width: 1.sw,
                                      ),
                                    ],
                                    10.verticalSpace,
                                    CommentActions(
                                      likeCount: widget.comment.likes,
                                      onCommentTap: () => _openReplySheet(context),
                                      onLikeTap: () {},
                                      dislikeCount: widget.comment.unlikes,
                                      comment: widget.comment,
                                      postId: widget.posId.toString(),
                                      onCommentDeleted: widget.onDeleted,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (commentHasChildren)
                    AnimatedCrossFade(
                        firstChild: Column(
                          children: widget.comment.children
                              .asMap()
                              .entries
                              .map((entry) => CommentItem(
                                    isReply: true,
                                    parentId: widget.comment.id,
                                    comment: entry.value,
                                    posId: widget.posId,
                                    replyingToName: posterName,
                                    isLast: entry.key ==
                                        widget.comment.children.length - 1,
                                    onDeleted: widget.onDeleted,
                                  ))
                              .toList(),
                        ),
                        secondChild: 0.verticalSpace,
                        crossFadeState: repliesCrosFadeState,
                        duration: const Duration(milliseconds: 300))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _openReplySheet(BuildContext context) {
    GuestUserHelper.handleGuestUserAction(action: () async {
      final commentsBloc = context.read<CommentsBloc>();
      final payload = await CustomDialogs.showBottomSheet<SaveCommentPayload>(
        context,
        ReplyComposerSheet(
          avatarUrl:
              widget.comment.user.avatar ?? Assets.images.svgs.dummyUser,
          posterName: posterName,
          isVerified: widget.comment.user.isSubscribed,
          timeAgo: TimeUtil.getTimeAgo(widget.comment.createdAt.toString()),
          body: widget.comment.comment,
          replyingToUsername: posterName,
          postId: widget.posId,
          parentId: widget.parentId ?? widget.comment.id,
          replyComment: widget.comment.id,
        ),
      );
      if (payload != null) {
        commentsBloc.add(CommentsEvent.saveAComment(payload));
      }
    });
  }

  void viewUserProfile(BuildContext context) {
    GuestUserHelper.handleGuestUserAction(
      action: () {
        var me = injector.get<ProfileBloc>().appUser;
        if (me?.id == widget.comment.user.id) {
          context.pushNamed(
            PageUrl.profileScreen,
          );
        } else {
          context.pushNamed(PageUrl.userProfileScreen,
              extra: widget.comment.user.id.toString());
        }
      },
    );
  }

  void _toggleReplies() {
    if (commentHasChildren) {
      setState(() {
        repliesCollapsed = !repliesCollapsed;
      });
    }
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

  double get avatarSize => 36;

  bool get commentHasChildren => widget.comment.children.isNotEmpty;

  bool get canShowThreadLine => commentHasChildren && !repliesCollapsed;

  bool get commentIsFromLoggedInUser =>
      widget.comment.user.id == injector.get<ProfileBloc>().appUser?.id;

  CrossFadeState get repliesCrosFadeState {
    return !repliesCollapsed
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond;
  }

  bool get canShowReplies => widget.hasReply! && !repliesCollapsed;
}
