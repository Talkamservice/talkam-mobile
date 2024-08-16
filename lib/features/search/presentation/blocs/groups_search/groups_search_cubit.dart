import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/search/data/models/talkam_search_result.dart';
import 'package:talkam/features/search/data/repository/search_repository.dart';

part 'groups_search_state.dart';

part 'groups_search_cubit.freezed.dart';

class GroupsSearchCubit extends Cubit<GroupsSearchState> {
  GroupsSearchCubit(this.searchRepository)
      : super(const GroupsSearchState.initial());

  final SearchRepository searchRepository;

  Future<void> searchGroup(String query) async {
    emit(const GroupsSearchState.getGroupSearchLoading());

    try {
      final SearchResult<GetGroupsResponse> response =
          await searchRepository.search(query,sort: SearchSort.group);

      emit(GroupsSearchState.groupSearchLoaded(
        groupResults: response.result.groups ?? [],
        paginationData: response.result.paginationMeta!,
      ));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupsSearchState.getGroupSearchFailed(e.toString()));
    }
  }

  Future<void> fetchNextPage(String query) async {
    if (state is! _GroupSearchLoaded) return;

    final currentState = state as _GroupSearchLoaded;
    if (!(currentState.paginationData.canLoadMore ?? false)) return;

    try {
      final SearchResult<GetGroupsResponse> response =
          await searchRepository.search(
        query,
        page: currentState.paginationData.currentPage ?? 0 + 1,
      );

      emit(currentState.copyWith(
        groupResults: [
          ...currentState.groupResults,
          ...response.result.groups ?? []
        ],
        paginationData: response.result.paginationMeta!,
      ));
    } catch (e) {
      emit(GroupsSearchState.getGroupSearchFailed(e.toString()));
    }
  }
}
