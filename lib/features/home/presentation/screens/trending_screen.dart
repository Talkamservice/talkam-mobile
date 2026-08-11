import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';

import '../../../../core/utils/extensions/context_extension.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with AutomaticKeepAliveClientMixin, RefreshPostsMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    injector
        .get<TrendingPostCubit>()
        .getTrendingPosts(PostFilterModel.trendingPost());

    // The cubit itself no-ops if a fetch is already running or there's no
    // next page — this listener only has to signal "we're near the bottom".
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        injector.get<TrendingPostCubit>().loadMore();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TrendingPostCubit, TrendingPostState>(
              bloc: injector.get(),
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const Center(child: PostLoadingShimmer()),
                  getTrendingPostsLoading: () =>
                      const Center(child: PostLoadingShimmer()),
                  getTrendingPostsFailed: (error) => AppErrorWidget(
                    message: error,
                    onTap: () => injector
                        .get<TrendingPostCubit>()
                        .getTrendingPosts(PostFilterModel.trendingPost()),
                  ),
                  getTrendingPostsSuccess: (response) {
                    final posts = response.data.data;
                    if (posts.isEmpty) {
                      return const Center(
                        child: TextView(text: "No posts yet"),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async => refreshPost(reload: true),
                      child: ListView.builder(
                        controller: _scrollController,
                        addAutomaticKeepAlives: true,
                        itemCount: posts.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: PostItem(post: posts[index]),
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
  }

  @override
  bool get wantKeepAlive => true;
}
