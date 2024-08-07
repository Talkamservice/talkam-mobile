part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;

  const factory SearchState.searchPostsLoading() = _SearchPostLoading;

  const factory SearchState.searchPostsFailed(String error) = _SearchPostFailed;

  const factory SearchState.searchPostsSuccessState(String error) =
      _SearchPostSuccessState;
}
