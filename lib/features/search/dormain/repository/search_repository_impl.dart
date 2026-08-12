import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/search/data/models/get_search_response.dart';
import 'package:talkam/features/search/data/models/people_search_response.dart';
import 'package:talkam/features/search/data/models/search_user_response.dart';
import 'package:talkam/features/search/data/models/talkam_search_result.dart';
import 'package:talkam/features/search/data/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final NetworkService _networkService;

  /// Unified search, recent/trending searches, and delete-search have
  /// migrated to /api/v2 — search suggestions, username search, and
  /// clear-history stay on v1 until they migrate too.
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  SearchRepositoryImpl(this._networkService);

  @override
  Future<GetSearchResponse> fetchRecentSearches() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.recentSearches, RequestMethod.get);
      return GetSearchResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future search(String query,
      {SearchSort sort = SearchSort.post, int? page}) async {
    try {
      final response = await _v2.call(UrlConfigV2.search, RequestMethod.get,
          queryParams: {
            "sort": sort.name,
            "search": query,
            "page": (page ?? 1).toString()
          });

      return switch (sort) {
        SearchSort.post => SearchResult<GetPostsResponse>(
            GetPostsResponse.fromJson(response.data)),
        SearchSort.groups => SearchResult<GetGroupsResponse>(
            GetGroupsResponse.fromJson(response.data)),
        SearchSort.media => SearchResult<GetPostsResponse>(
            GetPostsResponse.fromJson(response.data)),
        SearchSort.people => SearchResult<PeopleSearchResponse>(
            PeopleSearchResponse.fromJson(response.data)),
      };
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetSearchResponse> fetchTrendingSearches() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.trendingSearches, RequestMethod.get);
      return GetSearchResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteSearch(String searchId) async {
    try {
      final response = await _v2.call(
          UrlConfigV2.deleteSearch(searchId), RequestMethod.delete);
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

  @override
  Future<List<SearchedUser>> searUserByName(String name) async {
    final response = await _networkService.call(
        "/user/search/username?search=${name.isEmpty ? " " : name}",
        RequestMethod.get,
        data: {"id": name});
    return List.from(response.data['data'])
        .map((e) => SearchedUser.fromJson(e))
        .toList();
  }

  @override
  Future clearSearchHistory(int userId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.deleteSearch}/$userId/delete-all', RequestMethod.delete);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
