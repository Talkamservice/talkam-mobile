part of 'user_search_cubit.dart';

@freezed
class UserSearchState with _$UserSearchState {
  const factory UserSearchState.initial() = _Initial;

  const factory UserSearchState.userSearchLoaded(
      {required List<PostCreator> postResults,
      required PostsPaginationData paginationData}) = _UserSearcLoaded;

  const factory UserSearchState.getUserSearchLoading() = _UserSearchLoading;

  const factory UserSearchState.getUserSearchFailed(String error) =
      _UserSearchFailed;
}
