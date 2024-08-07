import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/recent_post/recent_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class TrendingPostByCategoryScreen extends StatefulWidget {
  const TrendingPostByCategoryScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<TrendingPostByCategoryScreen> createState() =>
      _TrendingPostByCategoryScreenState();
}

class _TrendingPostByCategoryScreenState
    extends State<TrendingPostByCategoryScreen>
    with AutomaticKeepAliveClientMixin {
  final bloc = TrendingPostCubit(injector.get());

  @override
  void initState() {
    bloc.getTrendingPosts(
        PostFilterModel.trendingPost(category: widget.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<TrendingPostCubit, TrendingPostState>(
            bloc: bloc,
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getTrendingPostsLoading: () => Center(
                  child: CustomDialogs.getLoading(size: 50),
                ),
                getTrendingPostsFailed: (error) => AppPromptWidget(
                  message: error,
                  onTap: () {
                    bloc.getTrendingPosts(PostFilterModel.trendingPost(
                        category: widget.categoryId));
                  },
                ),
                getTrendingPostsSuccess: (respone) {
                  if (respone.data.data.isEmpty) {
                    return const Center(
                      child: TextView(text: "No post here"),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      bloc.getTrendingPosts(PostFilterModel.trendingPost(
                          category: widget.categoryId));
                    },
                    child: ListView.builder(
                      itemCount: respone.data.data.length,
                      addAutomaticKeepAlives: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: PostItem(
                          post: respone.data.data[index],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
