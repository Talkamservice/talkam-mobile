import 'package:talkam/features/search/data/models/get_search_response.dart';

enum SearchSort { post, group, media }

abstract class SearchRepository {
  Future<GetSearchResponse> fetchRecentSearches(int userId);

  Future<dynamic> search(String query,
      {SearchSort sort = SearchSort.post, int? page});

  Future<GetSearchResponse> fetchTrendingSearches();

  Future<dynamic> deleteSearch(int searchId);

  Future<GetSearchResponse> fetchSearchSuggestions(String search);
}
