import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/core/utils/guest_user_helper.dart';
import 'package:talkam/features/ads/data/models/update_stat_payload.dart';
import 'package:talkam/features/ads/presentation/blocs/ads/ads_cubit.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/comments/comments_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/comment_input_widget.dart';
import 'package:talkam/features/post/presentation/widgets/comment_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_detail_card.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer_customized.dart';
import 'package:talkam/features/post/presentation/widgets/rules_sheet.dart';
import 'package:talkam/gen/assets.gen.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key, required this.postId});

  String? postId;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> with RefreshPostsMixin {
  TalkamPost? _post;

  late DateTime _startTime;
  Duration _timeSpent = Duration.zero;

  final adBloc = AdsCubit(injector.get());

  @override
  void dispose() {
    // Calculate the time spent in the widget
    DateTime _endTime = DateTime.now();
    _timeSpent = _endTime.difference(_startTime);
    print('Time spent in the widget: ${_timeSpent.inSeconds} seconds');

    if (_post != null) {

      adBloc.updateStats(UpdateStatPayLoad(postId: _post!.id, timeSpent: _timeSpent.inSeconds));
    }
    super.dispose();
  }

  @override
  void initState() {
    _startTime = DateTime.now();
    // _post = widget.post;
    commentBloc.add(CommentsEvent.getComments(widget.postId.toString() ?? '0'));
    postBloc.add(PostEvent.getPostDetails(widget.postId.toString()));
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
      child: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            getPostDetailsSuccess: (response) {
              // widget.post = response.data;
              _post = response.data;

              refreshPost(reload: false);

              setState(() {});
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              foregroundColor: context.colorScheme.onSurface,
              iconTheme: IconThemeData(
                color: context.colorScheme.onSurface,
              ),
              elevation: 0,
              title: const TextView(
                text: "Post",
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            body: Builder(builder: (context) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getPostDetailsLoading: () => const PostLoadingShimmerCustomized(numberOfShimmers: 1),
                getPostDetailsSuccess: (response) {
                  return NestedScrollView(
                    floatHeaderSlivers: false,
                    clipBehavior: Clip.none,
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              PostDetailCard(
                                post: _post!,
                              ),
                              3.verticalSpace,
                              InkWell(
                                onTap: () {
                                  CustomDialogs.showBottomSheet(context, const RulesSheet());
                                },
                                child: Container(
                                  width: 1.sw,
                                  decoration: BoxDecoration(color: context.theme.cardColor),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                  child: RichText(


                                      text:  TextSpan(children: [
                                    TextSpan(
                                      text: "Please be respectful and follow the ",
                                      style: GoogleFonts.nunito(
                                        color: context.colorScheme.onSurface,
                                        fontSize: 13,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Community Guidelines",
                                      style: GoogleFonts.nunito(
                                        color: context.colorScheme.primary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,

                                      ),
                                    ),
                                  ])),
                                  // child: Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     const TextView(fontSize: 13, text: "Please be respectful and follow the"),
                                  //     Expanded(
                                  //       child: TextView(
                                  //         text: "  Community Guidelines lhd",
                                  //         fontSize: 13,
                                  //         fontWeight: FontWeight.w700,
                                  //         color: context.colorScheme.primary,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ),
                              ),
                              3.verticalSpace,
                              GuestUserHelper.guestUserWidget(
                                  widget: CommentInputWidget(
                                    onCommentSubmitted: (comment) {
                                      commentToPost(comment);
                                    },
                                    postId: _post!.id,
                                  ),
                                  guestWidget: 0.verticalSpace),
                              3.verticalSpace,
                            ],
                          ),
                        )
                      ];
                    },
                    body: Column(
                      children: [
                        Expanded(
                          child: BlocConsumer<CommentsBloc, CommentsState>(
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
                                  // postBloc.comments.insert(0, )''

                                  postBloc.add(PostEvent.getPostDetails(_post!.id.toString(), refresh: false));

                                  commentBloc.add(
                                    CommentsEvent.getComments(_post!.id.toString(), reload: false),
                                  );

                                  // CustomDialogs.success("");
                                },
                              );
                            },
                            buildWhen: _buildWhen,
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => 0.verticalSpace,
                                getCommentsFailure: (error) => AppErrorWidget(
                                  onTap: () {
                                    commentBloc.add(CommentsEvent.getComments(_post!.id.toString()));
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
                                    // physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                                      child: CommentItem(
                                        isReply: false,
                                        comment: commentBloc.comments[index],
                                        posId: _post!.id,
                                        onDeleted: () {
                                          refresh();
                                        },

                                        // onTap: () {
                                        //   // context.read<DrawerCubit>().switchView(
                                        //   //     DrawerView.subCategory,
                                        //   //     subCategory: response.data[index]);
                                        // },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
                getPostDetailsFailure: (error) {
                  return AppErrorWidget(
                    onTap: () {
                      postBloc.add(PostEvent.getPostDetails(widget.postId.toString()));
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

  void refresh() {
    postBloc.add(PostEvent.getPostDetails(widget.postId.toString()));
    refreshPost(reload: false);
    commentBloc.add(CommentsEvent.getComments(widget.postId.toString(), reload: false));
  }

  void commentToPost(SaveCommentPayload payload) {
    commentBloc.add(CommentsEvent.saveAComment(payload));
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
        crossFadeState: widget.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 400), // Adjust animation duration as needed
        // onChanged: (state) =>,
      ),
    );
  }
}
