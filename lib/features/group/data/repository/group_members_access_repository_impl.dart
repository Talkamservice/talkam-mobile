import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/group/dormain/repository/group_members_access.dart';

class GroupMembersAccessRepositoryImpl extends GroupMembersAccessRepository {
  final NetworkService _networkService;

  GroupMembersAccessRepositoryImpl(this._networkService);

  @override
  Future<dynamic> getPendingGroupMembers(String groupId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.getPendingGroupMembers}?group_id=$groupId&status=Pending',
          RequestMethod.get);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> requestAccess(String groupId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.requestAccess}$groupId/request-access',
          RequestMethod.post);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> updateAccessRequest(
      String groupId, Map<String, dynamic> accessData) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.updateAccessRequest}$groupId/update-access-request',
          RequestMethod.put,
          data: accessData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteGroupMember(String memberId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.deleteGroupMember}$memberId', RequestMethod.delete);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
