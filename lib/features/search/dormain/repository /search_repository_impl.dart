import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/search/data/models/talkam_search_result.dart';
import 'package:talkam/features/search/data/repository%20/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final NetworkService _networkService;

  SearchRepositoryImpl(this._networkService);

  @override
  Future<dynamic> fetchRecentSearches(int userId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchRecentSearches, RequestMethod.get,
          queryParams: {"user_id": userId.toString()});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SearchResult> search(String query,
      {SearchSort sort = SearchSort.post}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.search, RequestMethod.get,
          queryParams: {"sort": sort.name, "search": query});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fetchTrendingSearches() async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchTrendingSearches, RequestMethod.get);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteSearch(int searchId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.deleteSearch}/$searchId/delete', RequestMethod.delete);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fetchSearchSuggestions() async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchSearchSuggestions, RequestMethod.get);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
