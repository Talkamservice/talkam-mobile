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
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/core/utils/string_extension.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/dormain/comment_thread_flattener.dart';
import 'package:talkam/features/post/presentation/bloc/comments/comments_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/comment_actions.dart';
import 'package:talkam/features/post/presentation/widgets/reply_composer_sheet.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Which visual tier a [CommentItem] renders at. There are only ever two:
/// [root] (the comment itself, cardColor background) and [reply] (every
/// one of its replies, at whatever depth, flattened into one indentation
/// level — see [flattenReplies]). A [reply] instance never recurses into
/// its own children; only [root] does, once, via the flattened list.
enum CommentTier { root, reply }

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    this.tier = CommentTier.root,
    required this.comment,
    required this.posId,
    this.replyingToName,
    this.replyingToUserId,
    this.replyingToIsAnonymous = false,
    this.hasReplyBelow = false,
    required this.onDeleted,
  });

  final PostComment comment;
  final CommentTier tier;
  final int posId;

  /// True when the next reply in the flattened list targets this exact
  /// one — draws a short connector line directly under this reply's own
  /// avatar, inside the same column, so it reads as extending down from
  /// here rather than as a decoration hanging off the reply below it.
  final bool hasReplyBelow;

  /// Who this comment is directed at, shown inline as "▸ [replyingToName]"
  /// next to the name. Null/empty renders no arrow at all — used for a
  /// plain reply to the root, or when the caller has no meaningful target
  /// to show (e.g. the root comment inside its own post-detail thread,
  /// where the post itself is already visible right above it).
  final String? replyingToName;

  /// The target's user id, so tapping [replyingToName] can open their
  /// profile the same way the comment's own name already does. Null when
  /// [replyingToName] is null, or when the target is anonymous.
  final int? replyingToUserId;
  final bool replyingToIsAnonymous;
  final VoidCallback onDeleted;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  // Replies stay hidden until explicitly opened.
  bool repliesCollapsed = true;

  @override
  Widget build(BuildContext context) {
    final replies = widget.tier == CommentTier.root
        ? flattenReplies(widget.comment)
        : const <FlattenedReply>[];

    final avatarWidget = widget.comment.isAnonymous.toBool
        ? ImageWidget(imageUrl: Assets.images.svgs.dummyUser, size: avatarSize)
        : InkWell(
            onTap: () => viewUserProfile(context),
            child: IgnorePointer(
              child: ClipOval(
                child: ImageWidget(
                  imageUrl: Helpers.getAvatar(
                    widget.comment.user.avatar,
                    isAnonymous: widget.comment.isAnonymous.toBool,
                  ),
                  size: avatarSize,
                  fit: BoxFit.cover,
                  errorImage: Assets.images.svgs.dummyUser,
                ),
              ),
            ),
          );

    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            // A reply already renders inside its parent's children-container,
            // which is flush against the same right boundary the root uses
            // (it only reserves space on the left, via margin+padding) — an
            // unconditional right inset here double-insets replies, landing
            // their own menu button further left than the parent's.
            left: _isReply ? 0 : 12.w,
            right: _isReply ? 0 : 12.w,
            top: 0,
            bottom: 4.h,
          ),
          decoration: BoxDecoration(
            color: _isReply ? Colors.transparent : context.theme.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: _isReply ? 8.w : 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: avatarSize, height: avatarSize),
                        8.horizontalSpace,
                    // Column 2: everything but the avatar and the menu
                    // button — name/time, message, attachment, actions,
                    // collapse toggle.
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
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
                                    fontSize: 13.sp,
                                    lineHeight: 0.85,
                                  ),
                                ),
                                // Who this comment is directed at, inline next to
                                // the name (e.g. "Michael ▸ Michael") instead of a
                                // separate "Replying to @X" line below.
                                if ((widget.replyingToName ?? '')
                                    .isNotEmpty) ...[
                                  6.horizontalSpace,
                                  TextView(
                                    text: "▸",
                                    color: Pallets.grey60,
                                    fontSize: 11.sp,
                                    lineHeight: 0.85,
                                  ),
                                  6.horizontalSpace,
                                  InkWell(
                                    onTap: widget.replyingToUserId == null
                                        ? null
                                        : () {
                                            if (widget.replyingToIsAnonymous) {
                                              CustomDialogs.showToast(
                                                  "User is Anonymous");
                                            } else {
                                              viewProfile(context,
                                                  widget.replyingToUserId!);
                                            }
                                          },
                                    child: TextView(
                                      text: widget.replyingToName!,
                                      color: Pallets.blueBubbleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                      lineHeight: 0.85,
                                    ),
                                  ),
                                ],
                                6.horizontalSpace,
                                const TextView(
                                  text: "·",
                                  color: Pallets.grey60,
                                  lineHeight: 0.85,
                                ),
                                6.horizontalSpace,
                                TextView(
                                  text: TimeUtil.getTimeAgo(
                                      widget.comment.createdAt.toString()),
                                  color: Pallets.grey60,
                                  fontSize: 11.sp,
                                  lineHeight: 0.85,
                                ),
                              ],
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => _openReplySheet(context),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                // topSpace/lineHeight: CustomReadMoreText's
                                // defaults are sized for post bodies; here
                                // the message sits right under the name row,
                                // so both the explicit top gap and the
                                // font's own built-in leading are trimmed.
                                child: CustomReadMoreText(
                                  text: widget.comment.comment,
                                  fontSize: 13.sp,
                                  topSpace: 0,
                                  lineHeight: 1.5,
                                  mentionCallback: (mention) {
                                    Helpers.viewMentionedUserProfile(
                                        context, mention);
                                  },
                                ),
                              ),
                            ),
                            if (widget.comment.attachment != null) ...[
                              10.verticalSpace,
                              ImageWidget(
                                imageUrl: widget.comment.attachment!,
                                height: 200.h,
                                canPreview: true,
                                borderRadius: BorderRadius.circular(16.r),
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
                            if (widget.tier == CommentTier.root &&
                                replies.isNotEmpty) ...[
                              6.verticalSpace,
                              InkWell(
                                onTap: _toggleReplies,
                                borderRadius: BorderRadius.circular(4.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 20.w,
                                        height: 1.5,
                                        color: Pallets.grey60,
                                      ),
                                      8.horizontalSpace,
                                      TextView(
                                        text: collapseText(replies.length),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Pallets.blueBubbleColor,
                                      ),
                                      4.horizontalSpace,
                                      Icon(
                                        repliesCollapsed
                                            ? Icons.keyboard_arrow_down_rounded
                                            : Icons.keyboard_arrow_up_rounded,
                                        size: 16.sp,
                                        color: Pallets.blueBubbleColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // Column 3: the menu button, its own sibling column
                    // rather than nested inside the name/time row — keeps
                    // it level with the avatar instead of depending on
                    // matching offsets across several layers of Row/Padding.
                    CommentMenuButton(
                      comment: widget.comment,
                      postId: widget.posId.toString(),
                      onCommentDeleted: widget.onDeleted,
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: avatarSize,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        avatarWidget,
                        // Lives in the same column as the avatar, right
                        // under it — extends down from here rather than
                        // being a decoration hanging off the reply below.
                        if (widget.hasReplyBelow)
                          Expanded(
                            child: Container(
                              width: 1, 
                              color: Pallets.grey90,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
              if (widget.tier == CommentTier.root && replies.isNotEmpty)
                // AnimatedSize (not AnimatedCrossFade) so the reveal is a
                // pure vertical grow/shrink anchored at the top — no
                // opacity-crossfade/stacking, which is what read as a
                // sideways transition.
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.topCenter,
                  curve: Curves.easeInOut,
                  child: repliesCollapsed
                      ? const SizedBox(width: double.infinity)
                      : Container(
                          margin:
                              EdgeInsets.only(left: (avatarSize / 2 - 0.75).w),
                          padding: EdgeInsets.only(left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < replies.length; i++)
                                CommentItem(
                                  key: ValueKey(replies[i].comment.id),
                                  tier: CommentTier.reply,
                                  comment: replies[i].comment,
                                  posId: widget.posId,
                                  replyingToName: replies[i].showReplyArrow
                                      ? replies[i].structuralParent.displayName
                                      : null,
                                  replyingToUserId: replies[i].showReplyArrow
                                      ? replies[i].structuralParent.user.id
                                      : null,
                                  replyingToIsAnonymous:
                                      replies[i].showReplyArrow &&
                                          replies[i]
                                              .structuralParent
                                              .isAnonymous
                                              .toBool,
                                  // The flattener's DFS pre-order guarantees
                                  // that if the next reply targets anything,
                                  // it's always this one — so this is a
                                  // simple adjacency check, not a search.
                                  hasReplyBelow: i + 1 < replies.length &&
                                      replies[i + 1].structuralParent.id ==
                                          replies[i].comment.id,
                                  onDeleted: widget.onDeleted,
                                ),
                            ],
                          ),
                        ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _openReplySheet(BuildContext context) {
    debugPrint('=== [TALKAM LOG] COMMENT REPLY TAPPED ===');
    debugPrint('Comment ID: ${widget.comment.id}, Post ID: ${widget.posId}');
    debugPrint('Author Name: ${widget.comment.user.name}');
    debugPrint('Author Username: ${widget.comment.user.username}');
    debugPrint('Is Anonymous: ${widget.comment.isAnonymous}');
    debugPrint('Avatar Raw: "${widget.comment.user.avatar}"');
    debugPrint(
        'Avatar Resolved: "${Helpers.getAvatar(widget.comment.user.avatar, isAnonymous: widget.comment.isAnonymous.toBool)}"');
    debugPrint('Comment Body: "${widget.comment.comment}"');

    GuestUserHelper.handleGuestUserAction(action: () async {
      final commentsBloc = context.read<CommentsBloc>();
      final payload = await CustomDialogs.showBottomSheet<SaveCommentPayload>(
        context,
        ReplyComposerSheet(
          avatarUrl: Helpers.getAvatar(
            widget.comment.user.avatar,
            isAnonymous: widget.comment.isAnonymous.toBool,
          ),
          posterName: posterName,
          isVerified: widget.comment.user.isSubscribed,
          timeAgo: TimeUtil.getTimeAgo(widget.comment.createdAt.toString()),
          body: widget.comment.comment,
          replyingToUsername: posterName,
          postId: widget.posId,
          parentId: widget.comment.id,
          replyComment: widget.comment.id,
        ),
      );
      if (payload != null) {
        commentsBloc.add(CommentsEvent.saveAComment(payload));
        if (mounted) {
          setState(() {
            repliesCollapsed = false;
          });
        }
      }
    });
  }

  void viewUserProfile(BuildContext context) =>
      viewProfile(context, widget.comment.user.id);

  /// Shared by the comment's own name and the "▸ target" annotation —
  /// same navigation either way, just a different id.
  void viewProfile(BuildContext context, int userId) {
    GuestUserHelper.handleGuestUserAction(
      action: () {
        var me = injector.get<ProfileBloc>().appUser;
        if (me?.id == userId) {
          context.pushNamed(
            PageUrl.profileScreen,
          );
        } else {
          context.pushNamed(PageUrl.userProfileScreen,
              extra: userId.toString());
        }
      },
    );
  }

  void _toggleReplies() {
    setState(() {
      repliesCollapsed = !repliesCollapsed;
    });
  }

  String get posterName => widget.comment.displayName;

  String collapseText(int count) {
    return repliesCollapsed
        ? "View $count ${count == 1 ? 'reply' : 'replies'}"
        : "Hide replies";
  }

  double get avatarSize => _isReply ? 28.r : 36.r;

  bool get _isReply => widget.tier == CommentTier.reply;
}
