import 'package:flutter/material.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/mixins/refresh_posts_mixin.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

import '../../../../core/utils/extensions/context_extension.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with AutomaticKeepAliveClientMixin, RefreshPostsMixin {
  @override
  void initState() {
    injector
        .get<TrendingPostCubit>()
        .getTrendingPosts(PostFilterModel.trendingPost());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            // Always renders MockHomeData.posts regardless of the real
            // TrendingPostCubit state — staging has no seed data yet.
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
  bool get wantKeepAlive => true;
}
