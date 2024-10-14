part of 'search_cubit.dart';



@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;

  // Loading States
  const factory SearchState.fetchRecentSearchesLoading() = _FetchRecentSearchesLoading;
  const factory SearchState.searchLoading() = _SearchLoading;
  const factory SearchState.fetchTrendingSearchesLoading() = _FetchTrendingSearchesLoading;
  const factory SearchState.deleteSearchLoading() = _DeleteSearchLoading;
  const factory SearchState.fetchSearchSuggestionsLoading() = _FetchSearchSuggestionsLoading;

  // Success States
  const factory SearchState.fetchRecentSearchesSuccess(GetSearchResponse response) = _FetchRecentSearchesSuccess;
  const factory SearchState.searchSuccess(GetSearchResponse response) = _SearchSuccess;
  const factory SearchState.fetchTrendingSearchesSuccess(GetSearchResponse response) = _FetchTrendingSearchesSuccess;
  const factory SearchState.deleteSearchSuccess(dynamic response) = _DeleteSearchSuccess;
  const factory SearchState.fetchSearchSuggestionsSuccess(GetSearchResponse response) = _FetchSearchSuggestionsSuccess;

  // Failure States
  const factory SearchState.fetchRecentSearchesFailure(String error) = _FetchRecentSearchesFailure;
  const factory SearchState.searchFailure(String error) = _SearchFailure;
  const factory SearchState.fetchTrendingSearchesFailure(String error) = _FetchTrendingSearchesFailure;
  const factory SearchState.deleteSearchFailure(String error) = _DeleteSearchFailure;
  const factory SearchState.fetchSearchSuggestionsFailure(String error) = _FetchSearchSuggestionsFailure;

  const factory SearchState.searchUserLoading() = _searchUserLoading;
  const factory SearchState.searchUserSuccess({required List<SearchedUser> searchResults}) = _searchUserSuccess;
  const factory SearchState.searchUserError({required String errorMessage}) = _searchUserError;

}
