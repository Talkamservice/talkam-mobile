import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen>
    with AutomaticKeepAliveClientMixin {
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
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<FeaturedPostCubit, FeaturedPostState>(
            bloc: injector.get(),
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getFeaturedPostsLoading: () => Center(
                  child: CustomDialogs.getLoading(size: 50),
                ),
                getFeaturedPostsFailed: (error) => AppPromptWidget(
                  message: error,
                  onTap: () {
                    injector
                        .get<FeaturedPostCubit>()
                        .getFeaturedPosts(PostFilterModel.featuredPost());
                  },
                ),
                getFeaturedPostsSuccess: (respone) {
                  if (respone.data.data.isEmpty) {
                    return const Center(
                      child: TextView(text: "No post yet"),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      injector
                          .get<FeaturedPostCubit>()
                          .getFeaturedPosts(PostFilterModel.featuredPost());
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
