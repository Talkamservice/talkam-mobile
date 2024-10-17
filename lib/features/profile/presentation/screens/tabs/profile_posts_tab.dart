import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:talkam/features/profile/presentation/widgets/refresh_post_listener.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_posts_tab_cubit/profile_posts_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_post_item_tile.dart';

class ProfilePostTab extends StatefulWidget {
  const ProfilePostTab({super.key});

  @override
  State<ProfilePostTab> createState() => _ProfilePostTabState();
}

class _ProfilePostTabState extends State<ProfilePostTab> with AutomaticKeepAliveClientMixin {
  final ProfilePostsTabCubit _cubit = injector.get();
  List<TalkamPost> _posts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    injector.get<ProfilePostsTabCubit>().fetchUserPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        injector.get<ProfilePostsTabCubit>().loadMorePosts(_posts);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshPostListener(
      onRefresh: () {
        injector.get<ProfilePostsTabCubit>().fetchUserPosts(reload: false);
      },
      child: BlocConsumer<ProfilePostsTabCubit, ProfilePostsTabState>(
        bloc: injector.get<ProfilePostsTabCubit>(),
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
              if (_posts.isEmpty) {
                return const Center(
                  child: TextView(
                    text: "No posts yet",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  injector.get<ProfilePostsTabCubit>().fetchUserPosts();
                },
                child: ListView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.0.h),
                  children: [
                    for (int i = 0; i < _posts.length; i++) ...[
                      PostItem(post: _posts[i],showScheduledPost: true,),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 12.w),
                      //   child: ProfilePostItemTile(
                      //     postId: _posts[i].id,
                      //     categoryIconImageUrl: _posts[i].category.postCategoryImage,
                      //     categoryName: _posts[i].category.name,
                      //     username: _posts[i].user.username ?? _posts[i].user.name,
                      //     formattedPostTime: timeago.format(_posts[i].createdAt),
                      //     postContent: _posts[i].body ?? '',
                      //     postTitle: _posts[i].title ?? '',
                      //     categories: _posts[i].tags.isNotEmpty ? _posts[i].tags : [_posts[i].category.name],
                      //
                      //     isScheduledPost: _posts[i].isSchedulePost && (_posts[i].publishAt as DateTime).isAfter(DateTime.now()),
                      //     scheduledDate: _posts[i].isSchedulePost ? _posts[i].publishAt : null,
                      //     userId: _posts[i].user.id,
                      //     post: _posts[i],
                      //   ),
                      // ),
                      6.verticalSpace,
                    ],
                    if (state is ProfilePostsTabLoadingMoreState)
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
