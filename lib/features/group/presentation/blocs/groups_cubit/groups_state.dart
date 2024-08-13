part of 'groups_cubit.dart';



@freezed
class GroupsState with _$GroupsState {
  const factory GroupsState.initial() = _Initial;

  // Get Groups States
  const factory GroupsState.getGroupsLoading() = _GetGroupsLoading;
  const factory GroupsState.getGroupsSuccess({
    required List<TalkamGroup> groups,
    required GroupPaginationMeta paginationData,
  }) = _GetGroupsSuccess;
  const factory GroupsState.getGroupsFailure(String error) = _GetGroupsFailure;

  // Fetch Next Page States
  const factory GroupsState.getFollowingGroupMembersLoading() = _GetFollowingGroupMembersLoading;
  const factory GroupsState.getFollowingGroupMembersSuccess(dynamic response) = _GetFollowingGroupMembersSuccess;
  const factory GroupsState.getFollowingGroupMembersFailure(String error) = _GetFollowingGroupMembersFailure;

  // Update Group States
  const factory GroupsState.updateGroupLoading() = _UpdateGroupLoading;
  const factory GroupsState.updateGroupSuccess(dynamic response) = _UpdateGroupSuccess;
  const factory GroupsState.updateGroupFailure(String error) = _UpdateGroupFailure;

  // Get Group States
  const factory GroupsState.getGroupLoading() = _GetGroupLoading;
  const factory GroupsState.getGroupSuccess(dynamic response) = _GetGroupSuccess;
  const factory GroupsState.getGroupFailure(String error) = _GetGroupFailure;

  // Delete Group States
  const factory GroupsState.deleteGroupLoading() = _DeleteGroupLoading;
  const factory GroupsState.deleteGroupSuccess(dynamic response) = _DeleteGroupSuccess;
  const factory GroupsState.deleteGroupFailure(String error) = _DeleteGroupFailure;




  const factory GroupsState.getRecommendedLoading() = _GetRecommendedLoading;
  const factory GroupsState.getRecommendedSuccess(GetGroupsResponse response) = _GetRecommendedSuccess;
  const factory GroupsState.getRecommendedFailure(String error) = _GetRecommendedFailure;
}
