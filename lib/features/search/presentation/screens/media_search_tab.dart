import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/presentation/widgets/post_item.dart';
import 'package:talkam/features/search/presentation/blocs/media_search/media_serach_cubit.dart';

import '../../../post/presentation/widgets/post_loading_shimmer.dart';

class MediaSearchResultTab extends StatefulWidget {
  const MediaSearchResultTab({super.key, required this.query});

  final String query;

  @override
  State<MediaSearchResultTab> createState() => _MediaSearchResultTabState();
}

class _MediaSearchResultTabState extends State<MediaSearchResultTab>
    with AutomaticKeepAliveClientMixin {
  final bloc = MediaSearchCubit(injector.get());

  @override
  void initState() {
    super.initState();
    bloc.getMediaPosts(widget.query);
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<MediaSearchCubit, MediaSearchState>(
            bloc: bloc,
            listener: (context, state) {},
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => 0.verticalSpace,
                getMediaSearchLoading: () => const Center(
                  child: PostLoadingShimmer(),
                ),
                mediaSearchLoaded: (posts, paginationMeta) {
                  if (posts.isEmpty) {
                    return const Center(
                      child: TextView(text: "No Results Found"),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      bloc.getMediaPosts(widget.query);
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
                getMediaSearchFailed: (error) => AppErrorWidget(
                  onTap: () {
                    bloc.getMediaPosts(widget.query);
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
