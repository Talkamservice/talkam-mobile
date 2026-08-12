import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/search/data/models/people_search_response.dart';
import 'package:talkam/features/search/data/models/talkam_search_result.dart';
import 'package:talkam/features/search/data/repository/search_repository.dart';

part 'user_search_state.dart';
part 'user_search_cubit.freezed.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  UserSearchCubit(this.searchRepository)
      : super(const UserSearchState.initial());
  final SearchRepository searchRepository;

  Future<void> searchUser(String query) async {
    emit(const UserSearchState.getUserSearchLoading());

    try {
      final SearchResult<PeopleSearchResponse> response =
          await searchRepository.search(
        query,
        sort: SearchSort.people,
      );

      emit(UserSearchState.userSearchLoaded(
        postResults: response.result.data,
        paginationData: response.result.paginationMeta,
      ));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(UserSearchState.getUserSearchFailed(e.toString()));
    }
  }

  Future<void> fetchNextPage(String query) async {
    if (state is! _UserSearcLoaded) return;

    final currentState = state as _UserSearcLoaded;
    if (currentState.paginationData.canLoadMore != true) return;

    try {
      final SearchResult<PeopleSearchResponse> response =
          await searchRepository.search(query,
              sort: SearchSort.people,
              page: (currentState.paginationData.currentPage ?? 0) + 1);

      emit(currentState.copyWith(
        postResults: [...currentState.postResults, ...response.result.data],
        paginationData: response.result.paginationMeta,
      ));
    } catch (e) {
      emit(UserSearchState.getUserSearchFailed(e.toString()));
    }
  }
}
