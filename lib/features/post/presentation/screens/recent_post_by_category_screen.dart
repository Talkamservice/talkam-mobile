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
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class RecentPostByCategoryScreen extends StatefulWidget {
  const RecentPostByCategoryScreen({super.key});

  @override
  State<RecentPostByCategoryScreen> createState() =>
      _RecentPostByCategoryScreenState();
}

class _RecentPostByCategoryScreenState extends State<RecentPostByCategoryScreen>
    with AutomaticKeepAliveClientMixin {
  final bloc = RecentPostCubit(injector.get());

  @override
  void initState() {
    bloc.getRecentPosts(PostFilterModel.recentPost(category: "1"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<RecentPostCubit, RecentPostState>(
            bloc: bloc,
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
                    bloc.getRecentPosts(
                        PostFilterModel.recentPost(category: "1"));
                  },
                ),
                getRecentPostsSuccess: (respone) {
                  if (respone.data.data.isEmpty) {
                    return const Center(
                      child: TextView(text: "No post yet"),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      bloc.getRecentPosts(
                          PostFilterModel.recentPost(category: "1"));
                    },
                    child: ListView.builder(
                      itemCount: respone.data.data.length,
                      addAutomaticKeepAlives: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
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
