import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/core/di/injector.dart' as di;
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

enum ReactionType { like, dislike }

class PostReactionButton extends StatefulWidget {
  PostReactionButton(
      {super.key,
      this.reaction,
      required this.reactionType,
      required this.id,
      required this.onLikeAdded,
      required this.onCountReduced,
      required this.onDisliked,
      required this.onReactionRemoved});

  PostReaction? reaction;
  final ReactionType reactionType;
  final String id;
  final Function() onLikeAdded;
  final Function() onDisliked;
  final Function() onCountReduced;
  final Function() onReactionRemoved;

  @override
  State<PostReactionButton> createState() => _PostReactionButtonState();
}

class _PostReactionButtonState extends State<PostReactionButton> {
  final PostBloc bloc = PostBloc(di.injector.get());

  bool isActive = false;

  @override
  void initState() {
    setIsActive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    di.logger.i(
        'PostReactionButton.build: type=${widget.reactionType}, id=${widget.id}, reaction=${widget.reaction}');
    return BlocConsumer<PostBloc, PostState>(
      bloc: bloc,
      listener: (context, state) {
        di.logger.i('PostReactionButton: state=${state.runtimeType}');
        state.maybeWhen(
          orElse: () => null,
          postReactionFailure: (error) {
            di.logger.e('PostReactionButton: postReactionFailure error=$error');
            changeIsActive();
            setState(() {});
          },
          postReactionSuccess: () {
            di.logger.i('PostReactionButton: postReactionSuccess');
          },
        );
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            di.logger.i(
                'PostReactionButton.onTap: type=${widget.reactionType}, id=${widget.id}');
            GuestUserHelper.handleGuestUserAction(
              action: () {
                di.logger.i(
                    'PostReactionButton: action called, handling ${widget.reactionType}');
                if (widget.reactionType == ReactionType.like) {
                  handleLikeClicked();
                } else {
                  handleDislikeClicked();
                }

                setState(() {});
              },
            );
          },
          child: switch (widget.reactionType) {
            ReactionType.like => ImageWidget(
                imageUrl: Assets.images.svgV2.likeIcon,
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

  void handleLikeClicked() {
    di.logger.i(
        'handleLikeClicked: id=${widget.id}, currentReaction=${widget.reaction}');
    bloc.add(PostEvent.postReaction(widget.id, "Like"));
    di.logger.i('handleLikeClicked: event added to bloc');

    if (widget.reaction?.isLike ?? false) {
      di.logger
          .i('handleLikeClicked: calling onCountReduced and onReactionRemoved');
      widget.onCountReduced();
      widget.onReactionRemoved();
    } else {
      di.logger.i('handleLikeClicked: calling onLikeAdded');
      widget.onLikeAdded();
    }
  }

  void handleDislikeClicked() {
    bloc.add(PostEvent.postReaction(widget.id, "Dislike"));

    if (widget.reaction?.isDisLike ?? false) {
      widget.onReactionRemoved();
      // widget.onCountReduced();
    } else {
      if (widget.reaction?.isLike ?? false) {
        widget.onCountReduced();
      }
      widget.onDisliked();
    }
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
