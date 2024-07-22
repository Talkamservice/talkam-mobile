import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/presentation/bloc/recent_post/recent_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    injector
        .get<RecentPostCubit>()
        .getRecentPosts(PostFilterModel.recentPost());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<RecentPostCubit, RecentPostState>(
            bloc: injector.get(),
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getRecentPostsLoading: () => Center(
                  child: CustomDialogs.getLoading(size: 50),
                ),
                getRecentPostsFailed: (error) => AppPromptWidget(
                  message: error,
                  onTap: () {
                    injector
                        .get<RecentPostCubit>()
                        .getRecentPosts(PostFilterModel.recentPost());
                  },
                ),
                getRecentPostsSuccess: (response) {
                  if (response.data.data.isEmpty) {
                    return const Center(
                      child: TextView(text: "No post yet"),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      injector
                          .get<RecentPostCubit>()
                          .getRecentPosts(PostFilterModel.recentPost());
                    },
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
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
