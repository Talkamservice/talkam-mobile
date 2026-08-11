import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'trending_post_state.dart';

part 'trending_post_cubit.freezed.dart';

class TrendingPostCubit extends Cubit<TrendingPostState> {
  final PostRepository postRepository;

  bool _isLoadingMore = false;

  TrendingPostCubit(this.postRepository)
      : super(const TrendingPostState.initial());

  /// Backs the "Trending" tab — v2's `tab=trending` feed. Promoted posts are
  /// already interleaved server-side (each post carries its own `promotion`
  /// flag), unlike the old v1 flow which fetched and merged them separately.
  void getTrendingPosts(PostFilterModel filter, {bool? reload}) async {
    if (reload ?? true) {
      emit(const TrendingPostState.getTrendingPostsLoading());
    }
    try {
      final response = await postRepository.getFeed(
        tab: "trending",
        categoryId: filter.category,
        page: filter.page,
      );

      emit(TrendingPostState.getTrendingPostsSuccess(response));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(TrendingPostState.getTrendingPostsFailed(error.toString()));
    }
  }

  /// Fetches the next page and appends it to whatever's currently shown.
  /// No-ops if nothing's loaded yet, a fetch is already in flight, or the
  /// current page is already the last one.
  Future<void> loadMore() async {
    final previous =
        state.whenOrNull(getTrendingPostsSuccess: (response) => response);
    if (_isLoadingMore || previous == null) return;
    if (previous.data.paginationMeta.canLoadMore != true) return;

    _isLoadingMore = true;
    try {
      final response = await postRepository.getFeed(
        tab: "trending",
        page: previous.data.paginationMeta.currentPage + 1,
      );

      final mergedResponse = response.copyWith(
        data: response.data.copyWith(
          data: [...previous.data.data, ...response.data.data],
        ),
      );

      emit(TrendingPostState.getTrendingPostsSuccess(mergedResponse));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      // Keep showing what's already loaded — a failed "load more" shouldn't
      // wipe the list or replace it with a full error screen.
    } finally {
      _isLoadingMore = false;
    }
  }
}
