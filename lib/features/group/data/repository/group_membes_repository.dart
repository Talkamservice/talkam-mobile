import 'package:dio/dio.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/data/models/get_pending_requests_response.dart';
import 'package:talkam/features/group/dormain/repository/group_members_repository.dart';

class GroupMembersRepositoryImpl extends GroupMembersRepository {
  final NetworkService _networkService;

  /// Join, leave, and request-access have migrated to /api/v2 — the rest of
  /// this repository stays on v1 until it migrates too.
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  /// The Authorization header is automatically injected by [_AuthInterceptor].
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

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
      final response = await _v2.call(
        UrlConfigV2.groupMembers,
        RequestMethod.post,
        formData: FormData.fromMap({"group_id": groupId, "user_id": userId}),
        options: _formOptions,
      );
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
      final response = await _v2.call(
        UrlConfigV2.unfollowGroup,
        RequestMethod.post,
        formData: FormData.fromMap({"group_id": groupId, "user_id": memberId}),
        options: _formOptions,
      );

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
  Future<dynamic> cancelRequestOrDeleteMember({
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
      final response = await _v2.call(
        UrlConfigV2.requestGroupAccess(groupId),
        RequestMethod.post,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future suspendOrCancelSuspension(
      {required String memberId,
      required String reason,
      required DateTime endDate}) async {
    try {
      final response = await _networkService
          .call(UrlConfig.suspendMember(memberId), RequestMethod.post, data: {
        "suspension_reason": reason,
        "suspension_end": TimeUtil.formatDateYYYMMDD(endDate.toString())
      });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
