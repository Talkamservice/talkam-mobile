import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_action_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/post_content.dart';
import 'package:talkam/features/post/presentation/widgets/post_reaction_button.dart';
import 'package:talkam/gen/assets.gen.dart';

class PostDetailCard extends StatelessWidget {
  const PostDetailCard(
      {super.key, required this.post, required this.onCommentTap});

  final TalkamPost post;
  final VoidCallback onCommentTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PostDetailHeader(post: post, userName: userName),
            10.verticalSpace,
            PostContent(post: post),
            12.verticalSpace,
            TextView(
              text:
                  "${TimeUtil.formatPostMeta(post.createdAt)} · ${post.viewsCount ?? 0} Views",
              fontSize: 12,
              color: Pallets.grey60,
            ),
            10.verticalSpace,
            TextView(
              text: "${post.likesCount ?? 0} Likes",
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            10.verticalSpace,
            const Divider(thickness: 1),
            8.verticalSpace,
            Row(
              children: [
                PostReactionButton(
                  reactionType: ReactionType.like,
                  id: post.id.toString(),
                  reaction: post.reaction,
                  onLikeAdded: () {
                    post.reaction = PostReaction.like();
                    post.likesCount += 1;
                  },
                  onCountReduced: () {
                    post.likesCount -= 1;
                  },
                  onDisliked: () {},
                  onReactionRemoved: () {
                    post.reaction = null;
                  },
                ),
                24.horizontalSpace,
                InkWell(
                  onTap: onCommentTap,
                  child: ImageWidget(
                      imageUrl: Assets.images.svgV2.commentIcon, size: 22),
                ),
                24.horizontalSpace,
                InkWell(
                  onTap: () {
                    Helpers.share("${UrlConfig.webUrl}/comments/${post.id}");
                  },
                  child: ImageWidget(
                      imageUrl: Assets.images.svgV2.shareIcon, size: 22),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String get userName =>
      post.isAnonymous.toBool ? "Anonymous" : post.user.usersName;
}

/// Avatar, poster name, "Posted in {category}", a Subscribe pill (visual
/// only — no subscribe-to-user feature exists yet), and the "⋮" menu.
class _PostDetailHeader extends StatelessWidget {
  const _PostDetailHeader({required this.post, required this.userName});

  final TalkamPost post;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (post.isAnonymous.toBool)
          ImageWidget(
              imageUrl: Assets.images.svgs.dummyUser,
              size: 40,
              shape: BoxShape.circle)
        else
          ClipOval(
            child: ImageWidget(
              imageUrl: post.user.avatar ?? Assets.images.svgs.dummyUser,
              size: 40,
            ),
          ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextView(
                      text: userName,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (post.user.isSubscribed) ...[
                    4.horizontalSpace,
                    ImageWidget(
                        imageUrl: Assets.images.svgs.blueThick, size: 12),
                  ],
                ],
              ),
              TextView(
                text: "Posted in ${post.category.name}",
                fontSize: 13,
                color: Pallets.grey60,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => CustomDialogs.showToast("Coming soon"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Pallets.blueBubbleColor,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: const TextView(
                text: "Subscribe",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13),
          ),
        ),
        GuestUserHelper.guestUserWidget(
          widget: IconButton(
            icon: Icon(Icons.more_vert_rounded,
                color: context.colorScheme.onSurface),
            onPressed: () async {
              var isReported = await CustomDialogs.showCustomDialog(
                  PostActionSheet(
                    post: post,
                    onPostDeleted: () => context.pop(),
                  ),
                  context);
              if (isReported ?? false) {
                post.isReported = true;
              }
            },
          ),
          guestWidget: 0.horizontalSpace,
        ),
      ],
    );
  }
}
