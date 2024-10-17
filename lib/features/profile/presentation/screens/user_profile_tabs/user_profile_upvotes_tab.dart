import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_upvotes_cubit/user_profile_upvotes_cubit.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/presentation/widgets/refresh_post_listener.dart';

class UserProfileUpvotesTab extends StatefulWidget {
  const UserProfileUpvotesTab({super.key, required this.userId});

  final String userId;

  @override
  State<UserProfileUpvotesTab> createState() => _UserProfileUpvotesTabState();
}

class _UserProfileUpvotesTabState extends State<UserProfileUpvotesTab>
    with AutomaticKeepAliveClientMixin {
  final UserProfileUpvotesCubit _cubit = injector.get();
  List<TalkamPost> _posts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit.fetchUserPosts(widget.userId);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _cubit.loadMorePosts(_posts);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshPostListener(
      onRefresh: () {
        _cubit.fetchUserPosts(widget.userId,reload: false);


      },
      child: BlocConsumer<UserProfileUpvotesCubit, UserProfileUpvotesState>(
        bloc: _cubit,
        listener: (context, state) {
          state.maybeWhen(
            loaded: (List<TalkamPost> posts) {
              _posts = posts;
              setState(() {});
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: PostLoadingShimmer(),
            ),
            error: () => const SizedBox.shrink(),
            orElse: () {
              if(_posts.isEmpty){

                return RefreshIndicator(
                  onRefresh: () async {
                    _cubit.fetchUserPosts(widget.userId);
                  },
                  child: ListView(
                    children: [
                      60.verticalSpace,
                      const EmptyState(
                        title: 'No upvote yet',
                        subtitle: "Upvotes  will appear here ",

                      ),
                    ],
                  ),
                );


              }
              return RefreshIndicator(
                onRefresh: () async {
                  _cubit.fetchUserPosts(widget.userId);
                },
                child: ListView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  // padding: EdgeInsets.only(top: 2),
                  children: [
                    for (int i = 0; i < _posts.length; i++) ...[
                      PostItem(post: _posts[i]),
                      4.verticalSpace,
                    ],
                    if (state is UserProfileUpvotesTabLoadingMoreState)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(child: CustomDialogs.getLoading(size: 50)),
                      )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
