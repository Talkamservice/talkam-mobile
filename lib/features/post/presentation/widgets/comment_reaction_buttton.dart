import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/bloc/comments/comments_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

enum ReactionType { like, dislike }

class CommentReactionButton extends StatefulWidget {
  CommentReactionButton(
      {super.key,
      this.reaction,
      required this.reactionType,
      required this.id,
      required this.onLikeAdded,
      required this.onLikeCountReduced,
      required this.onDisliked,
      required this.onReactionRemoved});

  PostReaction? reaction;
  final ReactionType reactionType;
  final String id;
  final Function() onLikeAdded;
  final Function() onDisliked;
  final Function() onLikeCountReduced;
  final Function() onReactionRemoved;

  @override
  State<CommentReactionButton> createState() => _CommentReactionButtonState();
}

class _CommentReactionButtonState extends State<CommentReactionButton> {
  final CommentsBloc bloc = CommentsBloc(injector.get());

  bool isActive = false;

  @override
  void initState() {
    setIsActive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsBloc, CommentsState>(
      bloc: bloc,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          commentReactionFailure: (error) {
            changeIsActive();
            setState(() {});
          },
          commentReactionSuccess: () {},
        );
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            // changeIsActive();

            GuestUserHelper.handleGuestUserAction(action: () {
              if (widget.reactionType == ReactionType.like) {

                bloc.add(CommentsEvent.commentReaction(widget.id, "Like"));

                if (widget.reaction?.isLike ?? false) {

                  widget.onLikeCountReduced();
                  widget.onReactionRemoved();

                } else {
                  widget.onLikeAdded();
                }
              } else {

                bloc.add(CommentsEvent.commentReaction(widget.id, "Dislike"));

                if (widget.reaction?.isDisLike ?? false) {


                  if (widget.reaction?.isLike ?? false) {
                    widget.onLikeCountReduced();
                  }
                  widget.onReactionRemoved();


                } else {

                  if (widget.reaction?.isLike ?? false) {
                    widget.onLikeCountReduced();
                  }

                  widget.onDisliked();


                }
              }

              setState(() {});
            },);


          },

          child: switch (widget.reactionType) {
            ReactionType.like => ImageWidget(
                imageUrl: Assets.images.svgs.thumbsUp,
                color:
                    widget.reaction?.isLike ?? false ? Pallets.primary : null,
              ),
            ReactionType.dislike => ImageWidget(
                imageUrl: Assets.images.svgs.thumbsDownSvg_,
                color: widget.reaction?.isDisLike ?? false ? Pallets.red : null,
              )
          },
        );
      },
    );
  }

  String get nextAction =>
      (widget.reaction?.isLike ?? false) ? "Dislike" : "Like";

  PostReaction get nextReaction => (widget.reaction?.isLike ?? false)
      ? PostReaction.dislike()
      : PostReaction.like();

  void setIsActive() {
    if (widget.reactionType == ReactionType.like) {
      if (widget.reaction?.isLike ?? false) {
        isActive = true;
      } else {
        isActive = false;
      }
    } else {
      if (widget.reaction?.isDisLike ?? false) {
        isActive = true;
      } else {
        isActive = false;
      }
    }
  }

  void changeIsActive() {
    switch (widget.reactionType) {
      case ReactionType.like:
        if (widget.reaction?.isLike ?? false) {}

        isActive = !isActive;
      case ReactionType.dislike:
      // TODO: Handle this case.
    }
  }
}
