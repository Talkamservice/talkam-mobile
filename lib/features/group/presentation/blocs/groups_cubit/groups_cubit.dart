import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

part 'groups_state.dart';

part 'groups_cubit.freezed.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(this.groupRepository) : super(const GroupsState.initial());

  final GroupsRepository groupRepository;

  Future<void> getGroups({GroupsFilterModel? filter}) async {
    emit(const GroupsState.getGroupsLoading());

    try {
      final GetGroupsResponse response =
          await groupRepository.getGroups(page: 1,filter: filter);

      emit(GroupsState.getGroupsSuccess(
        groups: response.groups!,
        paginationData: response.paginationMeta!,
      ));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupsState.getGroupsFailure(e.toString()));
    }
  }

  Future<void> getRecommendedGroups() async {
    emit(const GroupsState.getRecommendedLoading());

    try {
      final GetGroupsResponse response = await groupRepository.getGroups(
          page: 1, filter: GroupsFilterModel.recommended());

      emit(GroupsState.getRecommendedSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupsState.getRecommendedFailure(e.toString()));
    }
  }

  Future<void> fetchNextPage(
      List<TalkamGroup> groups, GroupPaginationMeta paginationData) async {
    if (!paginationData.canLoadMore!) return;

    try {
      final GetGroupsResponse response = await groupRepository.getGroups(
        page: paginationData.currentPage! + 1,
      );

      emit(GroupsState.getGroupsSuccess(
        groups: [
          ...groups,
          ...response.groups!,
        ],
        paginationData: response.paginationMeta!,
      ));
    } catch (e) {
      emit(GroupsState.getGroupsFailure(e.toString()));
    }
  }

  Future<void> getFollowingGroupMembers() async {
    emit(const GroupsState.getFollowingGroupMembersLoading());

    try {
      final response = await groupRepository.getFollowingGroupMembers();

      emit(GroupsState.getFollowingGroupMembersSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupsState.getFollowingGroupMembersFailure(e.toString()));
    }
  }

  Future<void> updateGroup(
      String groupId, Map<String, dynamic> groupData) async {
    emit(const GroupsState.updateGroupLoading());

    try {
      final response = await groupRepository.updateGroup(groupId, groupData);

      emit(GroupsState.updateGroupSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupsState.updateGroupFailure(e.toString()));
    }
  }

  Future<void> getGroup(String groupId) async {
    emit(const GroupsState.getGroupLoading());

    try {
      final response = await groupRepository.getGroup(groupId);

      emit(GroupsState.getGroupSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupsState.getGroupFailure(e.toString()));
    }
  }

  Future<void> deleteGroup(String groupId) async {
    emit(const GroupsState.deleteGroupLoading());

    try {
      final response = await groupRepository.deleteGroup(groupId);

      emit(GroupsState.deleteGroupSuccess(response));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupsState.deleteGroupFailure(e.toString()));
    }
  }
}
