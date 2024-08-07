import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_posts_cubit/user_profile_posts_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_posts_tab_cubit/profile_posts_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/widgets/profile_post_item_tile.dart';

class UserProfilePostTab extends StatefulWidget {
  const UserProfilePostTab({super.key, required this.userId});

  final String userId;

  @override
  State<UserProfilePostTab> createState() => _UserProfilePostTabState();
}

class _UserProfilePostTabState extends State<UserProfilePostTab>
    with AutomaticKeepAliveClientMixin {
  final UserProfilePostsCubit _cubit = injector.get();
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
    return BlocConsumer<UserProfilePostsCubit, UserProfilePostsState>(
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
            return RefreshIndicator(
              onRefresh: () async{
                _cubit.fetchUserPosts(widget.userId);

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
                        isPublicProfile: true,
                        postId: _posts[i].id,
                        categoryIconImageUrl:
                            _posts[i].category.postCategoryImage,
                        categoryName: _posts[i].category.name,
                        username: _posts[i].user.username ?? _posts[i].user.name,
                        formattedPostTime: timeago.format(_posts[i].createdAt),
                        postContent: _posts[i].body ?? '',
                        postTitle: _posts[i].title ?? '',
                        categories: _posts[i].tags.isNotEmpty
                            ? _posts[i].tags
                            : [_posts[i].category.name],
                        isScheduledPost: _posts[i].isSchedulePost,
                        scheduledDate:
                            _posts[i].isSchedulePost ? _posts[i].publishAt : null,
                        userId: _posts[i].user.id,
                        post: _posts[i],
                      ),
                    ),
                    24.verticalSpace,
                  ],
                  if (state is UserProfilePostsTabLoadingMoreState)
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
