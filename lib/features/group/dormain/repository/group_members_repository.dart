import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/data/models/get_pending_requests_response.dart';

abstract class GroupMembersRepository {
  Future<GetGroupMembersResponse> getGroupMembers(String groupId);

  Future<dynamic> addGroupMember(
      {required String groupId, required String userId});

  Future<dynamic> updateMemberRole(String memberId, String role);

  Future<GroupMemberDetails> getMember(String memberId);

  Future<dynamic> acceptOrDeclineRequest(
      {required String memberId, required String action, required groupId});

  Future<dynamic> cancelRequestOrDeleteMember({
    required String memberId,
  });

  Future<dynamic> sendJoinRequest({
    required String groupId,
  });

  Future<dynamic> suspendOrCancelSuspension(
      {required String memberId,
      required String reason,
      required DateTime endDate});

  Future<GetPendingRequestsResponse> getPendingRequests(
      {required String groupId});

  Future<dynamic> deleteMember(String memberId, String groupId);
}
