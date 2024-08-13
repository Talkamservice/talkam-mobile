import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupsRepositoryImpl extends GroupsRepository {
  final NetworkService _networkService;

  GroupsRepositoryImpl(this._networkService);

  @override
  Future<GetGroupsResponse> getGroups(
      {required int? page, GroupsFilterModel? filter}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getGroups, RequestMethod.get, queryParams: {
        "page": (page ?? 1).toString(),
        ...(filter ?? GroupsFilterModel.all()).toJson()
      });
      return GetGroupsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getFollowingGroupMembers() async {
    try {
      final response = await _networkService.call(
          UrlConfig.getFollowingGroupMembers, RequestMethod.get);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> updateGroup(
      String groupId, Map<String, dynamic> groupData) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.updateGroup}$groupId', RequestMethod.put,
          data: groupData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getGroup(String groupId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.getGroup}$groupId', RequestMethod.get);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteGroup(String groupId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.deleteGroup}$groupId', RequestMethod.delete);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
