enum SearchSort { post, group, media }

abstract class SearchRepository {
  Future<dynamic> fetchRecentSearches(int userId);

  Future<dynamic> search(String query, {SearchSort sort = SearchSort.post});

  Future<dynamic> fetchTrendingSearches();

  Future<dynamic> deleteSearch(int searchId);

  Future<dynamic> fetchSearchSuggestions();
}
