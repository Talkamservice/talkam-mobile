import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with AutomaticKeepAliveClientMixin {
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
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<TrendingPostCubit, TrendingPostState>(
            bloc: injector.get(),
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
                    injector
                        .get<TrendingPostCubit>()
                        .getTrendingPosts(PostFilterModel.trendingPost());
                  },
                ),
                getTrendingPostsSuccess: (response) {
                  if (response.data.data.isEmpty) {
                    return const Center(
                      child: TextView(text: "No post yet"),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      injector
                          .get<TrendingPostCubit>()
                          .getTrendingPosts(PostFilterModel.trendingPost());
                    },
                    child: ListView.builder(
                      itemCount: response.data.data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: PostItem(
                          post: response.data.data[index],
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
