import 'package:flutter/material.dart';
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

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen>
    with AutomaticKeepAliveClientMixin, RefreshPostsMixin {
  @override
  void initState() {
    injector
        .get<FeaturedPostCubit>()
        .getFeaturedPosts(PostFilterModel.featuredPost());

    super.initState();
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
            // Always renders MockHomeData.posts regardless of the real
            // FeaturedPostCubit state — staging has no seed data yet.
            child: RefreshIndicator(
              onRefresh: () async => refreshPost(reload: true),
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: MockHomeData.posts.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: PostItem(post: MockHomeData.posts[index]),
                ),
              ),
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
