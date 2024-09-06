part of 'group_members_cubit.dart';



@freezed
class GroupMembersState with _$GroupMembersState {
  const factory GroupMembersState.initial() = _Initial;

  // Get Group Members States
  const factory GroupMembersState.getGroupMembersLoading() = _GetGroupMembersLoading;
  const factory GroupMembersState.getGroupMembersSuccess(GetGroupMembersResponse response) = _GetGroupMembersSuccess;
  const factory GroupMembersState.getGroupMembersFailure(String error) = _GetGroupMembersFailure;


  // Add Group Member States
  const factory GroupMembersState.addGroupMemberLoading() = _AddGroupMemberLoading;
  const factory GroupMembersState.addGroupMemberSuccess(dynamic response) = _AddGroupMemberSuccess;
  const factory GroupMembersState.addGroupMemberFailure(String error) = _AddGroupMemberFailure;


  // Update Member Role States
  const factory GroupMembersState.updateMemberRoleLoading() = _UpdateMemberRoleLoading;
  const factory GroupMembersState.updateMemberRoleSuccess(dynamic response) = _UpdateMemberRoleSuccess;
  const factory GroupMembersState.updateMemberRoleFailure(String error) = _UpdateMemberRoleFailure;

  // Get Member States
  const factory GroupMembersState.getMemberLoading() = _GetMemberLoading;
  const factory GroupMembersState.getMemberSuccess(GroupMemberDetails memberDetails) = _GetMemberSuccess;
  const factory GroupMembersState.getMemberFailure(String error) = _GetMemberFailure;

  // Delete Member States
  const factory GroupMembersState.deleteMemberLoading() = _DeleteMemberLoading;
  const factory GroupMembersState.deleteMemberSuccess(dynamic response) = _DeleteMemberSuccess;
  const factory GroupMembersState.deleteMemberFailure(String error) = _DeleteMemberFailure;




  // Cancel Request
  const factory GroupMembersState.cancelRequestLoading() = _CancelRequestLoading;
  const factory GroupMembersState.cancelRequestSuccess(dynamic response) = _CancelRequestSuccess;
  const factory GroupMembersState.cancelRequestFailure(String error) = _CancelRequestFailure;


  
  // Get Pending Requests
  const factory GroupMembersState.pendingRequestsLoading() = _PendingRequestLoading;
  const factory GroupMembersState.pendingRequestsSuccess(GetPendingRequestsResponse response) = _PendingRequestSuccess;
  const factory GroupMembersState.pendingRequestsFailure(String error) = _PendingRequestFailure;



  // Send Requests
  const factory GroupMembersState.sendRequestLoading() = _SendRequestLoading;
  const factory GroupMembersState.sendRequestSyccess(dynamic response) = _SendRequestSuccess;
  const factory GroupMembersState.sendRequestFailure(String error) = _SendRequestFailure;



  // Accept or decline Requests
  const factory GroupMembersState.requestActionLoading() = _RequestActionLoading;
  const factory GroupMembersState.requestActionSuccess(dynamic response) = _RequestActionSuccess;
  const factory GroupMembersState.requestActionFailure(String error) = _RequestActionFailure;



  // Suspend or Cancel Suspension
  const factory GroupMembersState.suspensionLoading() = _SuspensionLoading;
  const factory GroupMembersState.suspensionSuccess(dynamic response) = _SuspensionSuccess;
  const factory GroupMembersState.suspensionFailure(String error) = _SuspensionFailure;




}

