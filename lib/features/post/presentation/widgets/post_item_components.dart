import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/readmore_text.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_image.dart';
import 'package:talkam/features/post/presentation/widgets/post_reaction_button.dart';
import 'package:talkam/gen/assets.gen.dart';

class AvatarImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  const AvatarImage({required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    return ImageWidget(imageUrl: imageUrl, size: size);
  }
}

class PostHeader extends StatelessWidget {
  final String userName;
  final PostCategory category;
  final VoidCallback onMenuTap;

  const PostHeader({
    required this.userName,
    required this.category,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarImage(
            imageUrl: category.iconImage ?? Assets.images.png.dating.path,
            size: 32),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: category.name,
                fontWeight: FontWeight.w500,
              ),
              TextView(
                text: "Posted by $userName",
                color: Pallets.grey,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_vert_rounded,
              color: context.colorScheme.onSurface),
          onPressed: onMenuTap,
        )
      ],
    );
  }
}

class PostActions extends StatefulWidget {
  final TalkamPost post;
  final VoidCallback onCommentTap;
  final VoidCallback onLikeTap;
  final VoidCallback onShareTap;

  const PostActions({
    required this.onCommentTap,
    required this.onLikeTap,
    required this.onShareTap,
    required this.post,
  });

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IgnorePointer(
          child: TextButton(
              style: outlinedBorderStyle,
              onPressed: widget.onCommentTap,
              child: Row(
                children: [
                  ImageWidget(imageUrl: Assets.images.svgs.comment),
                  10.horizontalSpace,
                  TextView(
                    text: "${widget.post.commentsCount} Comments",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )
                ],
              )),
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
                  onCountReduced: () {
                    if (widget.post.likesCount >= 1) {
                      widget.post.likesCount -= 1;
                    }

                    setState(() {});
                  },
                  onDisliked: () {
                    widget.post.reaction = PostReaction.dislike();
                    if (widget.post.likesCount >= 1) {
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
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                width: 1,
                color: Pallets.borderGrey,
              )),
          child: ImageWidget(imageUrl: Assets.images.svgs.share),
        )
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
