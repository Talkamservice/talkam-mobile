import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/search/data/models/talkam_search_result.dart';
import 'package:talkam/features/search/data/repository%20/search_repository.dart';

part 'media_serach_state.dart';

part 'media_serach_cubit.freezed.dart';

class MediaSearchCubit extends Cubit<MediaSearchState> {
  MediaSearchCubit(this.searchRepository)
      : super(const MediaSearchState.initial());
  final SearchRepository searchRepository;

  Future<void> getMediaPosts(String query) async {
    emit(const MediaSearchState.getMediaSearchLoading());

    try {
      final SearchResult<GetPostsResponse> response =
          await searchRepository.search(query, sort: SearchSort.media);


      emit(MediaSearchState.mediaSearchLoaded(
        postResults: response.result.data.data,
        paginationData: response.result.data.paginationMeta,
      ));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(MediaSearchState.getMediaSearchFailed(e.toString()));
    }
  }

  Future<void> fetchNextPage(String query) async {
    if (state is! _MediaSearcLoaded) return;

    final currentState = state as _MediaSearcLoaded;
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
      emit(MediaSearchState.getMediaSearchFailed(e.toString()));
    }
  }
}
