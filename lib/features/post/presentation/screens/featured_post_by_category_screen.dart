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

class FeaturedPostByCategoryScreen extends StatefulWidget {
  const FeaturedPostByCategoryScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<FeaturedPostByCategoryScreen> createState() =>
      _FeaturedPostByCategoryScreenState();
}

class _FeaturedPostByCategoryScreenState
    extends State<FeaturedPostByCategoryScreen>
    with AutomaticKeepAliveClientMixin {
  final bloc = FeaturedPostCubit(injector.get());

  @override
  void initState() {
    bloc.getFeaturedPosts(PostFilterModel.featuredPost(category: widget.categoryId));
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
            bloc: bloc,
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getFeaturedPostsLoading: () => Center(
                  child: CustomDialogs.getLoading(size: 50),
                ),
                getFeaturedPostsFailed: (error) => AppErrorWidget(
                  message: error,
                  onTap: () {
                    bloc.getFeaturedPosts(PostFilterModel.featuredPost(category: widget.categoryId));

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
                      bloc.getFeaturedPosts(PostFilterModel.featuredPost(
                          category: widget.categoryId));
                    },
                    child: ListView.builder(
                      itemCount: respone.data.data.length,
                      addAutomaticKeepAlives: true,

                      padding: EdgeInsets.zero,
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
