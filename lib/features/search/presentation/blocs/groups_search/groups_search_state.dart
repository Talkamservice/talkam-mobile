part of 'groups_search_cubit.dart';



@freezed
class GroupsSearchState with _$GroupsSearchState {
  const factory GroupsSearchState.initial() = _Initial;
  const factory GroupsSearchState.getGroupSearchLoading() = _GroupSearchLoading;
  const factory GroupsSearchState.groupSearchLoaded({
    required List<TalkamGroup> groupResults,
    required PaginationMeta paginationData,
  }) = _GroupSearchLoaded;
  const factory GroupsSearchState.getGroupSearchFailed(String message) = _GroupSearchFailed;
}
