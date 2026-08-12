import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/data/models/get_pending_requests_response.dart';
import 'package:talkam/features/group/dormain/repository/group_members_repository.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/core/mock/mock_home_data.dart';

part 'group_members_state.dart';

part 'group_members_cubit.freezed.dart';

class GroupMembersCubit extends Cubit<GroupMembersState> {
  GroupMembersCubit(this.groupMembersRepository)
      : super(const GroupMembersState.initial());

  final GroupMembersRepository groupMembersRepository;

  Future<void> getGroupMembers(String groupId) async {
    emit(const GroupMembersState.getGroupMembersLoading());

    try {
      final GetGroupMembersResponse response =
          await groupMembersRepository.getGroupMembers(groupId);

      emit(GroupMembersState.getGroupMembersSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      // Fallback to mock data
      emit(GroupMembersState.getGroupMembersSuccess(
          MockHomeData.mockGroupMembersResponse));
    }
  }

  Future<void> addGroupMember(
      {required String groupId, required String userId}) async {
    emit(const GroupMembersState.addGroupMemberLoading());

    try {
      final response = await groupMembersRepository.addGroupMember(
          groupId: groupId, userId: userId);

      emit(GroupMembersState.addGroupMemberSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.addGroupMemberFailure(e.toString()));
    }
  }

  Future<void> updateMemberRole(String memberId, String role) async {
    emit(const GroupMembersState.updateMemberRoleLoading());

    try {
      final response =
          await groupMembersRepository.updateMemberRole(memberId, role);

      emit(GroupMembersState.updateMemberRoleSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.updateMemberRoleFailure(e.toString()));
    }
  }

  Future<void> getMember(String memberId) async {
    emit(const GroupMembersState.getMemberLoading());

    try {
      final GroupMemberDetails memberDetails =
          await groupMembersRepository.getMember(memberId);

      emit(GroupMembersState.getMemberSuccess(memberDetails));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.getMemberFailure(e.toString()));
    }
  }

  Future<void> unfollowGroup(String memberId, String groupId) async {
    emit(const GroupMembersState.deleteMemberLoading());

    try {
      final response =
          await groupMembersRepository.deleteMember(memberId, groupId);

      emit(GroupMembersState.deleteMemberSuccess(response));
      // Keep the shared GroupsCubit singleton (the sidebar's "Groups" list)
      // in sync now that this group has been left.
      injector
          .get<GroupsCubit>()
          .getGroups(isFollowing: true, shouldRefresh: false);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.deleteMemberFailure(e.toString()));
    }
  }

  Future<void> cancelRequest(String memberId) async {
    emit(const GroupMembersState.cancelRequestLoading());

    try {
      final response = await groupMembersRepository.cancelRequestOrDeleteMember(
          memberId: memberId);

      emit(GroupMembersState.cancelRequestSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.cancelRequestFailure(e.toString()));
    }
  }

  Future<void> getPendingRequests(String groupId,
      {bool? refresh = true}) async {
    if (refresh!) {
      emit(const GroupMembersState.pendingRequestsLoading());
    }

    try {
      final response =
          await groupMembersRepository.getPendingRequests(groupId: groupId);

      emit(GroupMembersState.pendingRequestsSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.pendingRequestsFailure(e.toString()));
    }
  }

  Future<void> sendGroupRequest(String groupId) async {
    emit(const GroupMembersState.sendRequestLoading());
    try {
      final response =
          await groupMembersRepository.sendJoinRequest(groupId: groupId);

      emit(GroupMembersState.sendRequestSyccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.sendRequestFailure(e.toString()));
    }
  }

  Future<void> suspendMember(
      {required String memberId,
      required String reason,
      required DateTime endDate}) async {
    emit(const GroupMembersState.suspensionLoading());

    try {
      final response = await groupMembersRepository.suspendOrCancelSuspension(
          memberId: memberId, reason: reason, endDate: endDate);

      emit(GroupMembersState.suspensionSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.suspensionFailure(e.toString()));
    }
  }

  Future<void> acceptOrDeclineRequest({
    required String memberId,
    required String action,
    required dynamic groupId,
  }) async {
    emit(const GroupMembersState.requestActionLoading());
    try {
      final response = await groupMembersRepository.acceptOrDeclineRequest(
          groupId: groupId, memberId: memberId, action: action);

      emit(GroupMembersState.requestActionSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.requestActionFailure(e.toString()));
    }
  }
}
