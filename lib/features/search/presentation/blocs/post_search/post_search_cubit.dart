import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/search/data/models/talkam_search_result.dart';
import 'package:talkam/features/search/data/repository/search_repository.dart';

part 'post_search_state.dart';

part 'post_search_cubit.freezed.dart';

class PostSearchCubit extends Cubit<PostSearchState> {
  PostSearchCubit(this.searchRepository)
      : super(const PostSearchState.initial());
  final SearchRepository searchRepository;


  Future<void> searchPosts(String query) async {
    emit(const PostSearchState.getPostSearchLoading());

    try {
      final SearchResult<GetPostsResponse> response =
          await searchRepository.search(
        query,
      );

      emit(PostSearchState.postSearchLoaded(
        postResults: response.result.data.data,
        paginationData: response.result.data.paginationMeta,
      ));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(PostSearchState.getPostSearchFailed(e.toString()));
    }
  }

  Future<void> fetchNextPage(String query) async {
    if (state is! _PostSearcLoaded) return;

    final currentState = state as _PostSearcLoaded;
    if (!currentState.paginationData.canLoadMore) return;

    try {
      final SearchResult<GetPostsResponse> response =
          await searchRepository.search(query,
              sort: SearchSort.post,
              page: currentState.paginationData.currentPage + 1);

      emit(currentState.copyWith(
        postResults: [
          ...currentState.postResults,
          ...response.result.data.data
        ],
        paginationData: response.result.data.paginationMeta,
      ));
    } catch (e) {
      emit(PostSearchState.getPostSearchFailed(e.toString()));
    }
  }
}
