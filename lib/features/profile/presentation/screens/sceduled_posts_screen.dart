import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/profile/presentation/widgets/refresh_post_listener.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_posts_tab_cubit/profile_posts_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_post_item_tile.dart';

class ScheduledPostsScreen extends StatefulWidget {
  const ScheduledPostsScreen({super.key});

  @override
  State<ScheduledPostsScreen> createState() => _ScheduledPostsScreenState();
}

class _ScheduledPostsScreenState extends State<ScheduledPostsScreen> with AutomaticKeepAliveClientMixin {
  final ProfilePostsTabCubit _cubit = ProfilePostsTabCubit(injector.get());
  List<TalkamPost> _posts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit.fetchUserPosts(isScheduled: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
       _cubit.loadMorePosts(_posts);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const CustomAppBar(
        tittleText: "My Scheduled posts",
        centerTile: false,
        showDivider: true,

      ),
      body: RefreshPostListener(
        onRefresh: () {
          _cubit.fetchUserPosts(reload: false, isScheduled: true);
        },
        child: BlocConsumer<ProfilePostsTabCubit, ProfilePostsTabState>(
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
              loading: () => Center(
                child: CustomDialogs.getLoading(size: 50),
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
                    _cubit.fetchUserPosts(isScheduled: true);
                  },
                  child: ListView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 20.0.h),
                    children: [
                      for (int i = 0; i < _posts.length; i++) ...[
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: ProfilePostItemTile(
                            postId: _posts[i].id,
                            categoryIconImageUrl: _posts[i].category.postCategoryImage,
                            categoryName: _posts[i].category.name,
                            username: _posts[i].user?.username ?? _posts[i].user?.name??'',
                            formattedPostTime: timeago.format(_posts[i].createdAt),
                            postContent: _posts[i].body ?? '',
                            postTitle: _posts[i].title ?? '',
                            categories: _posts[i].tags.isNotEmpty ? _posts[i].tags : [_posts[i].category.name],
                            isScheduledPost: _posts[i].isSchedulePost && (_posts[i].publishAt as DateTime).isAfter(DateTime.now()),
                            scheduledDate: _posts[i].isSchedulePost ? _posts[i].publishAt : null,
                            userId: _posts[i].user?.id??1,
                            post: _posts[i],
                          ),
                        ),
                        24.verticalSpace,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
