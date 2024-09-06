import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/data/models/get_pending_requests_response.dart';
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
  Future<dynamic> addGroupMember(
      {required String groupId, required String userId}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.groupMembers, RequestMethod.post,
          data: {"group_id": groupId, "user_id": userId});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> updateMemberRole(String memberId, String role) async {
    try {
      final response = await _networkService.call(
          '${UrlConfig.updateMemberRole}$memberId', RequestMethod.put,
          data: {"role": role});
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
  Future<dynamic> deleteMember(String memberId, String groupId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.deleteMember, RequestMethod.post,
          data: {"group_id": groupId, "user_id": memberId});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> acceptOrDeclineRequest(
      {required String memberId,
      required String action,
      required groupId}) async {
    try {
      final response = await _networkService
          .call(UrlConfig.acceptOrDecline(groupId), RequestMethod.post, data: {
        "member_id": memberId,
        "action": action // Approved or Declined
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> cancelRequest({
    required String memberId,
  }) async {
    try {
      final response = await _networkService.call(
        UrlConfig.deleteRequest(memberId),
        RequestMethod.delete,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetPendingRequestsResponse> getPendingRequests(
      {required String groupId}) async {
    try {
      final response = await _networkService.call(
          "${UrlConfig.getPendingGroupMembers}?group_id=$groupId&status=Pending",
          RequestMethod.get,
          queryParams: {"group_id": groupId, "status": "Pending"});
      return GetPendingRequestsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future sendJoinRequest({required String groupId}) async {
    try {
      final response = await _networkService.call(
        UrlConfig.sendJoinRequest(groupId),
        RequestMethod.post,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future suspendOrCancelSuspension({required String memberId}) async{

    try {
      final response = await _networkService.call(
        UrlConfig.suspendOrCancelSuspension,
        RequestMethod.post,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }


  }
}
