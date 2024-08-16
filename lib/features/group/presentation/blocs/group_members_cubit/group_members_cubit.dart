import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/dormain/repository/group_members_repository.dart';

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
      emit(GroupMembersState.getGroupMembersFailure(e.toString()));
    }
  }

  Future<void> addGroupMember(Map<String, dynamic> memberData) async {
    emit(const GroupMembersState.addGroupMemberLoading());

    try {
      final response = await groupMembersRepository.addGroupMember(memberData);

      emit(GroupMembersState.addGroupMemberSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.addGroupMemberFailure(e.toString()));
    }
  }

  Future<void> updateMemberRole(
      String memberId, Map<String, dynamic> roleData) async {
    emit(const GroupMembersState.updateMemberRoleLoading());

    try {
      final response =
          await groupMembersRepository.updateMemberRole(memberId, roleData);

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

  Future<void> deleteMember(String memberId) async {
    emit(const GroupMembersState.deleteMemberLoading());

    try {
      final response = await groupMembersRepository.deleteMember(memberId);

      emit(GroupMembersState.deleteMemberSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupMembersState.deleteMemberFailure(e.toString()));
    }
  }
}
