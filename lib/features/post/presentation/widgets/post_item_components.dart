import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/widgets/post_reaction_button.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/subscription/presentation/widgets/subscription_plan_card.dart';
import 'package:talkam/features/subscription/utils/subscription_helper.dart';
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
  final TalkamPost post;
  final bool? showGroupAndCategory;
  final bool? enablePromoteAddPill;

  const PostHeader({
    required this.userName,
    required this.category,
    required this.onMenuTap,
    required this.post,
    this.showGroupAndCategory = true,
    this.enablePromoteAddPill = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (post.isAnonymous.toBool)
          ImageWidget(
            imageUrl: Assets.images.svgs.dummyUser,
            size: 32,
          ),
        if (!post.isAnonymous.toBool)
          InkWell(
            onTap: () {
              viewUsersProfile(context);
            },
            child: IgnorePointer(
              child: AvatarImage(imageUrl: post.user.avatar ?? Assets.images.svgs.dummyUser, size: 32),
            ),
          ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  TextView(
                    text: category.name,
                    maxLines: 1,
                    maxLength: 14,
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                  ),
                  4.horizontalSpace,
                  ImageWidget(imageUrl: Assets.images.svgs.grid03),
                  4.horizontalSpace,
                  TextView(
                    text: TimeUtil.getTimeAgo(post.createdAt.toString()),
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.primary,
                  ),
                  if (enablePromoteAddPill!)
                  12.horizontalSpace,
                  if (enablePromoteAddPill!)
                  TalkamSubscriptionWidget(
                    subscribedUserWidget: 0.verticalSpace,
                    freemiumUserWidget: InkWell(
                      onTap: () {
                        context.pushNamed(PageUrl.subscriptionScreen);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(22), border: Border.all(color: Pallets.lightBlue), gradient: whiteBlueGradient),
                        child: const TextView(fontSize: 8, text: "Promote post"),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (!post.isAnonymous.toBool) {
                        viewUsersProfile(context);
                      } else {
                        CustomDialogs.showToast("User is anonymous");
                      }
                    },
                    child: TextView(
                      text: "Posted by $userName ",
                      color: Pallets.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  if (showGroupAndCategory!)
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (post.group != null) {
                            return InkWell(
                              onTap: () {
                                context.pushNamed(PageUrl.groupsInfoScreen, extra: post.group!.id.toString());

                                // if (!post.isAnonymous.toBool) {
                                //   viewUsersProfile(context);
                                // } else {
                                //   CustomDialogs.showToast("User is anonymous");
                                // }
                              },
                              child: Row(
                                children: [
                                  const TextView(
                                    text: "to",
                                    color: Pallets.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  Expanded(
                                    child: TextView(
                                      text: " ${post.group!.name}",
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      color: Pallets.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              context.pushNamed(PageUrl.categoriesScreen, extra: post.category);

                              // if (!post.isAnonymous.toBool) {
                              //   viewUsersProfile(context);
                              // } else {
                              //   CustomDialogs.showToast("User is anonymous");
                              // }
                            },
                            child: Row(
                              children: [
                                const TextView(
                                  text: "to",
                                  color: Pallets.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                Expanded(
                                  child: TextView(
                                    text: " ${post.category.name}",
                                    color: Pallets.primary,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_vert_rounded, color: context.colorScheme.onSurface),
          onPressed: onMenuTap,
        )
      ],
    );
  }

  void viewUsersProfile(BuildContext context) {
    GuestUserHelper.handleGuestUserAction(
        action: () {
          var me = injector.get<ProfileBloc>().appUser;
          if (me?.id == post.user.id) {
            context.pushNamed(
              PageUrl.profileScreen,
            );
          } else {
            context.pushNamed(PageUrl.userProfileScreen, extra: post.user.id.toString());
          }
        },
        message: "Login to view user profile");
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
        InkWell(
          onTap: widget.onShareTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(
                  width: 1,
                  color: Pallets.borderGrey,
                )),
            child: ImageWidget(imageUrl: Assets.images.svgs.share),
          ),
        )
      ],
    );
  }

  ButtonStyle get outlinedBorderStyle {
    return TextButton.styleFrom(
        elevation: 0,
        foregroundColor: Pallets.grey,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        shape: const StadiumBorder(side: BorderSide(color: Pallets.borderGrey)));
  }
}
