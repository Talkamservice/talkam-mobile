import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/search/presentation/blocs/post_search/post_search_cubit.dart';

class PostSearchResultTab extends StatefulWidget {
  const PostSearchResultTab({super.key, required this.query});

  final String query;

  @override
  State<PostSearchResultTab> createState() => _PostSearchResultTabState();
}

class _PostSearchResultTabState extends State<PostSearchResultTab>
    with AutomaticKeepAliveClientMixin {
  final bloc = PostSearchCubit(injector.get());

  @override
  void initState() {
    super.initState();
    bloc.searchPosts(widget.query);
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<PostSearchCubit, PostSearchState>(
            bloc: bloc,
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getPostSearchLoading: () => Center(
                  child: CustomDialogs.getLoading(size: 50),
                ),
                postSearchLoaded: (posts, paginationMeta) {
                  if (posts.isEmpty) {
                    return const Center(
                      child: TextView(text: "No Results Found"),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      bloc.searchPosts(widget.query);
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: paginationMeta.canLoadMore
                          ? posts.length + 1
                          : posts.length,
                      itemBuilder: (context, index) {
                        if (index >= posts.length) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return PostItem(post: posts[index]);
                      },
                    ),
                  );
                },
                getPostSearchFailed: (error) => AppErrorWidget(
                  onTap: () {
                    bloc.searchPosts(widget.query);
                  },
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      bloc.fetchNextPage(widget.query);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
