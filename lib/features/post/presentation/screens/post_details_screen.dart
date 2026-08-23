import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/extensions/int_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/ads/data/models/update_stat_payload.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/comments/comments_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/comment_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_detail_card.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer_customized.dart';
import 'package:talkam/features/post/presentation/widgets/reply_composer_sheet.dart';
import 'package:talkam/features/post/presentation/widgets/rules_sheet.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/gen/assets.gen.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key, this.postId, this.post})
      : assert(postId != null || post != null,
            'Either postId or post must be provided');

  String? postId;

  /// When set, this is a locally-known post (e.g. mock feed data) that
  /// doesn't exist on the real backend — the screen renders it directly
  /// instead of fetching it, and comments are kept purely local.
  final TalkamPost? post;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen>
    with RefreshPostsMixin {
  TalkamPost? _post;
  final List<PostComment> _localComments = [];

  late DateTime _startTime;
  Duration _timeSpent = Duration.zero;
  final adBloc = AdsCubit(injector.get());

  bool get _isLocalPost => widget.post != null;

  @override
  void dispose() {
    // Calculate the time spent in the widget
    DateTime endTime = DateTime.now();
    _timeSpent = endTime.difference(_startTime);

    if (_post != null && !_isLocalPost) {
      adBloc.updateStats(UpdateStatPayLoad(
          postId: _post!.id, timeSpent: _timeSpent.inSeconds));
    }
    super.dispose();
  }

  @override
  void initState() {
    _startTime = DateTime.now();
    if (_isLocalPost) {
      _post = widget.post;
      _localComments.addAll(MockHomeData.commentsForPost(widget.post!.id));
    } else {
      commentBloc.add(CommentsEvent.getComments(widget.postId.toString()));
      postBloc.add(PostEvent.getPostDetails(widget.postId.toString()));
    }
    super.initState();
  }

  var isAnonymous = false;
  final commentBloc = CommentsBloc(injector.get());
  final postBloc = PostBloc(injector.get());
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => commentBloc,
      child: _isLocalPost
          ? _buildScaffold(context, body: _buildPostBody(context, _post!))
          : BlocConsumer<PostBloc, PostState>(
              bloc: postBloc,
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () => null,
                  getPostDetailsSuccess: (response) {
                    _post = response.data;
                    setState(() {});
                  },
                );
              },
              builder: (context, state) {
                return _buildScaffold(
                  context,
                  body: Builder(builder: (context) {
                    return state.maybeWhen(
                      orElse: () => 0.verticalSpace,
                      getPostDetailsLoading: () =>
                          const PostLoadingShimmerCustomized(
                              numberOfShimmers: 1),
                      getPostDetailsSuccess: (response) =>
                          _buildPostBody(context, _post!),
                      getPostDetailsFailure: (error) {
                        return AppErrorWidget(
                          onTap: () {
                            postBloc.add(PostEvent.getPostDetails(
                                widget.postId.toString()));
                          },
                          message: error,
                        );
                      },
                    );
                  }),
                );
              },
            ),
    );
  }

  Widget _buildScaffold(BuildContext context, {required Widget body}) {
    return Scaffold(
      appBar: CustomAppBar(
        tittleText: "Post",
        centerTile: false,
        titleAlign: TextAlign.left,
        bgColor: context.colorScheme.surface,
      ),
      backgroundColor: context.colorScheme.surface,
      body: body,
    );
  }

  /// Single continuous scroll region — the post card, guidelines banner and
  /// comments all scroll together so comments sit directly under the post
  /// rather than in a separate nested scrollable.
  Widget _buildPostBody(BuildContext context, TalkamPost post) {
    return CustomScrollView(
      clipBehavior: Clip.none,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              PostDetailCard(
                post: post,
                onCommentTap: () => _openReplyToPost(context),
              ),
              const Divider(thickness: 1),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: _isLocalPost
              ? _buildLocalComments(post)
              : _buildRemoteComments(post),
        ),
      ],
    );
  }

  Widget _buildLocalComments(TalkamPost post) {
    if (_localComments.isEmpty) {
      return const Center(
        child: TextView(text: "Be the first to comment."),
      );
    }

    return ListView.builder(
      itemCount: _localComments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: CommentItem(
          isReply: false,
          comment: _localComments[index],
          posId: post.id,
          replyingToName:
              post.isAnonymous.toBool ? "Anonymous" : post.user.usersName,
          isLast: index == _localComments.length - 1,
          onDeleted: () => setState(() {}),
        ),
      ),
    );
  }

  Widget _buildRemoteComments(TalkamPost post) {
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          saveACommentLoading: () {
            CustomDialogs.showLoading(context);
          },
          saveACommentFailure: (error) {
            context.pop();
            CustomDialogs.error(error);
          },
          saveACommentSuccess: () {
            context.pop();

            postBloc.add(
                PostEvent.getPostDetails(post.id.toString(), refresh: false));

            commentBloc.add(
              CommentsEvent.getComments(post.id.toString(), reload: false),
            );
          },
        );
      },
      buildWhen: _buildWhen,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => 0.verticalSpace,
          getCommentsFailure: (error) => AppErrorWidget(
            onTap: () {
              commentBloc.add(CommentsEvent.getComments(post.id.toString()));
            },
          ),
          getCommentsLoading: () => CustomDialogs.getLoading(size: 50),
          getCommentsSuccess: (response) {
            if (response.data.isEmpty) {
              return const Center(
                child: TextView(text: "Be the first to comment."),
              );
            }

            return ListView.builder(
              itemCount: commentBloc.comments.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: CommentItem(
                  isReply: false,
                  comment: commentBloc.comments[index],
                  posId: post.id,
                  replyingToName: post.isAnonymous.toBool
                      ? "Anonymous"
                      : post.user.usersName,
                  isLast: index == commentBloc.comments.length - 1,
                  onDeleted: () {
                    refresh();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void refresh() {
    if (_isLocalPost) {
      setState(() {});
      return;
    }
    postBloc.add(PostEvent.getPostDetails(widget.postId.toString()));
    refreshPost(reload: false);
    commentBloc.add(
        CommentsEvent.getComments(widget.postId.toString(), reload: false));
  }

  void commentToPost(SaveCommentPayload payload) {
    if (_isLocalPost) {
      final me = injector.get<ProfileBloc>().appUser;
      final now = DateTime.now();
      _localComments.insert(
        0,
        PostComment(
          id: now.millisecondsSinceEpoch,
          user: PostCreator(
            id: me?.id ?? 0,
            avatar: me?.avatar,
            name: me?.name ?? "You",
            username: me?.username ?? "you",
            email: me?.email ?? "",
          ),
          comment: payload.comment,
          isAnonymous: payload.isAnonymous ?? 0,
          likes: 0,
          unlikes: 0,
          replyTo: null,
          attachment: payload.attachment,
          reaction: null,
          children: const [],
          createdAt: now,
          updatedAt: now,
        ),
      );
      setState(() {});
      return;
    }
    commentBloc.add(CommentsEvent.saveAComment(payload));
  }

  void _openReplyToPost(BuildContext context) {
    GuestUserHelper.handleGuestUserAction(
      action: () async {
        final userName =
            _post!.isAnonymous.toBool ? "Anonymous" : _post!.user.usersName;
        final payload = await CustomDialogs.showBottomSheet<SaveCommentPayload>(
          context,
          ReplyComposerSheet(
            avatarUrl: _post!.user.avatar ?? Assets.images.svgs.dummyUser,
            posterName: userName,
            isVerified: _post!.user.isSubscribed,
            timeAgo: TimeUtil.getTimeAgo(_post!.createdAt.toString()),
            title: _post!.title,
            body: _post!.body ?? '',
            replyingToUsername: userName,
            postId: _post!.id,
          ),
        );
        if (payload != null) commentToPost(payload);
      },
    );
  }

  bool _buildWhen(CommentsState previous, CommentsState current) {
    return current.maybeWhen(
      orElse: () => false,
      getCommentsSuccess: (response) => true,
      getCommentsFailure: (error) => true,
      getCommentsLoading: () => true,
    );
  }
}

class AnonymousSwitcher extends StatefulWidget {
  final bool value; // Current state of the switcher (active or inactive)
  final Function(bool) onChanged; // Callback called when the state changes
  final double? height;
  final double? width;

  const AnonymousSwitcher({
    super.key,
    required this.value,
    required this.onChanged,
    this.height,
    this.width,
  });

  @override
  State<AnonymousSwitcher> createState() => _AnonymousSwitcherState();
}

class _AnonymousSwitcherState extends State<AnonymousSwitcher> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedCrossFade(
        firstChild: ImageWidget(
          height: widget.height ?? 28,
          width: widget.width ?? 55,
          fit: BoxFit.cover,
          imageUrl: Assets.images.svgs.anonymousInactive,
        ),
        secondChild: ImageWidget(
          height: widget.height ?? 28,
          width: widget.width ?? 55,
          fit: BoxFit.cover,
          imageUrl: Assets.images.svgs.anonymousActive,
        ),
        crossFadeState:
            widget.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(
            milliseconds: 400), // Adjust animation duration as needed
      ),
    );
  }
}
