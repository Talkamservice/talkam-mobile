import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/search/data/models/get_search_response.dart';
import 'package:talkam/features/search/data/models/search_user_response.dart';

import '../../../data/repository/search_repository.dart';

part 'search_state.dart';

part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchState.initial());

  Future<void> fetchRecentSearches({bool? reload = true}) async {
    if (reload!) {
      emit(const SearchState.fetchRecentSearchesLoading());
    }
    try {
      final response = await _searchRepository.fetchRecentSearches(injector.get<ProfileBloc>().appUser!.id);
      emit(SearchState.fetchRecentSearchesSuccess(response));
    } catch (e) {
      emit(SearchState.fetchRecentSearchesFailure(e.toString()));
    }
  }

  Future<void> search(String query, {SearchSort sort = SearchSort.post, bool? reload = true}) async {
    emit(const SearchState.searchLoading());
    try {
      final response = await _searchRepository.search(query, sort: sort);
      emit(SearchState.searchSuccess(response));
    } catch (e) {
      emit(SearchState.searchFailure(e.toString()));
    }
  }

  Future<void> fetchTrendingSearches({bool? reload = true}) async {
    if (reload!) {
      emit(const SearchState.fetchTrendingSearchesLoading());
    }
    try {
      final response = await _searchRepository.fetchTrendingSearches();
      emit(SearchState.fetchTrendingSearchesSuccess(response));
    } catch (e) {
      emit(SearchState.fetchTrendingSearchesFailure(e.toString()));
    }
  }

  Future<void> deleteSearch(int searchId) async {
    emit(const SearchState.deleteSearchLoading());
    try {
      final response = await _searchRepository.deleteSearch(searchId);
      emit(SearchState.deleteSearchSuccess(response));
    } catch (e) {
      emit(SearchState.deleteSearchFailure(e.toString()));
    }
  }

  Future<void> searchForUser(
    String search,
  ) async {
    emit(const SearchState.searchUserLoading());
    try {
      final result = await _searchRepository.searUserByName(search);
      emit(SearchState.searchUserSuccess(searchResults: result));
    } catch (exception, stackTrace) {
      logger.e("performSearch error is ${exception.toString()}", stackTrace: stackTrace);
      emit(const SearchState.searchUserError(errorMessage: "Something went wrong please try again"));
    }
  }

  Future<void> fetchSearchSuggestions(String search) async {
    emit(const SearchState.fetchSearchSuggestionsLoading());
    try {
      final response = await _searchRepository.fetchSearchSuggestions(search);
      emit(SearchState.fetchSearchSuggestionsSuccess(response));
    } catch (e) {
      emit(SearchState.fetchSearchSuggestionsFailure(e.toString()));
    }
  }

  void clearSearchHistory() async {
    emit(const SearchState.deleteSearchLoading());
    var user = injector.get<ProfileBloc>().appUser;
    try {
      final response = await _searchRepository.clearSearchHistory(int.parse(user?.id.toString() ?? '1'));
      emit(SearchState.deleteSearchSuccess(response));
    } catch (e) {
      emit(SearchState.deleteSearchFailure(e.toString()));
    }
  }

  void loadSearchScreen() {
    Future.delayed(
      Duration.zero,
      () {
        fetchTrendingSearches();
        fetchRecentSearches();
        // fetchSearchSuggestions();
      },
    );
  }
}
