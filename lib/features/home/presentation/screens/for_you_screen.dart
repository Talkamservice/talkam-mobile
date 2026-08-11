import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/widgets/category_filter_chips.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/post/presentation/widgets/post_loading_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen>
    with AutomaticKeepAliveClientMixin, RefreshPostsMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    injector
        .get<FeaturedPostCubit>()
        .getFeaturedPosts(PostFilterModel.featuredPost());

    // The cubit itself no-ops if a fetch is already running or there's no
    // next page — this listener only has to signal "we're near the bottom".
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        injector.get<FeaturedPostCubit>().loadMore();
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
    super.build(context);
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Column(
        children: [
          CategoryFilterChips(
            categories: injector.get<PostBloc>().categories.isEmpty
                ? MockHomeData.feedCategories
                : injector.get<PostBloc>().categories,
            onSelected: (categoryId) {
              injector.get<FeaturedPostCubit>().getFeaturedPosts(
                    PostFilterModel.featuredPost(category: categoryId),
                  );
            },
          ),
          8.verticalSpace,
          Expanded(
            child: BlocBuilder<FeaturedPostCubit, FeaturedPostState>(
              bloc: injector.get(),
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const Center(child: PostLoadingShimmer()),
                  getFeaturedPostsLoading: () =>
                      const Center(child: PostLoadingShimmer()),
                  getFeaturedPostsFailed: (error) => AppErrorWidget(
                    message: error,
                    onTap: () => injector
                        .get<FeaturedPostCubit>()
                        .getFeaturedPosts(PostFilterModel.featuredPost()),
                  ),
                  getFeaturedPostsSuccess: (response) {
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
