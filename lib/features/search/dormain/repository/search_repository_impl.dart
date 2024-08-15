import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/search/data/models/get_search_response.dart';
import 'package:talkam/features/search/data/models/talkam_search_result.dart';
import 'package:talkam/features/search/data/repository%20/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final NetworkService _networkService;

  SearchRepositoryImpl(this._networkService);

  @override
  Future<GetSearchResponse> fetchRecentSearches(int userId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchRecentSearches, RequestMethod.get,
          queryParams: {"user_id": userId.toString()});
      return GetSearchResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future search(String query,
      {SearchSort sort = SearchSort.post, int? page}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.search, RequestMethod.get, queryParams: {
        "sort": sort.name,
        "search": query,
        "page": (page ?? 1).toString()
      });

      return switch (sort) {
        SearchSort.post => SearchResult<GetPostsResponse>(
            GetPostsResponse.fromJson(response.data)),
        SearchSort.group => SearchResult<GetGroupsResponse>(
            GetGroupsResponse.fromJson(response.data)),
        SearchSort.media => SearchResult<GetPostsResponse>(
            GetPostsResponse.fromJson(response.data)),
      };
      // return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetSearchResponse> fetchTrendingSearches() async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchTrendingSearches, RequestMethod.get);
      return GetSearchResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
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
  Future<GetSearchResponse> fetchSearchSuggestions(String search) async {
    try {
      final response = await _networkService.call(
          UrlConfig.fetchSearchSuggestions, RequestMethod.get,
          queryParams: {"search": search});
      return GetSearchResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
