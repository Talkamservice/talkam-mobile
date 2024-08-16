import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_upvotes_cubit/profile_upvotes_cubit.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_posts_tab_cubit/profile_posts_tab_cubit.dart';

class ProfileUpvotesTab extends StatefulWidget {
  const ProfileUpvotesTab({super.key});

  @override
  State<ProfileUpvotesTab> createState() => _ProfileUpvotesTabState();
}

class _ProfileUpvotesTabState extends State<ProfileUpvotesTab>
    with AutomaticKeepAliveClientMixin {
  final ProfileUpvotesCubit _cubit = injector.get();
  List<TalkamPost> _posts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit.fetchUserPosts();
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
    return BlocConsumer<ProfileUpvotesCubit, ProfileUpvotesState>(
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
          error: (e) => AppErrorWidget(
            message: e.toString(),
            onTap: () {},
          ),
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
                _cubit.fetchUserPosts();
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
