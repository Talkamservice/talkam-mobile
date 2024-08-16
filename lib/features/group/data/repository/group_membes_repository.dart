import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/dormain/repository/group_members_repository.dart';

class GroupMembersRepositoryImpl extends GroupMembersRepository {
  final NetworkService _networkService;

  GroupMembersRepositoryImpl(this._networkService);

  @override
  Future<GetGroupMembersResponse> getGroupMembers(String groupId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.getGroupMembers}?group_id=$groupId', RequestMethod.get);
      return GetGroupMembersResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addGroupMember(Map<String, dynamic> memberData) async {
    try {
      final response = await _networkService
          .call(UrlConfig.addGroupMember, RequestMethod.post, data: memberData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> updateMemberRole(
      String memberId, Map<String, dynamic> roleData) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.updateMemberRole}$memberId', RequestMethod.put,
          data: roleData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupMemberDetails> getMember(String memberId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.getMember}$memberId', RequestMethod.get);
      return GroupMemberDetails.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteMember(String memberId) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.deleteMember}$memberId', RequestMethod.delete);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
