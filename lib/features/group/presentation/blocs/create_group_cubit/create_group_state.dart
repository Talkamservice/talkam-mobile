part of 'create_group_cubit.dart';


@freezed
class CreateGroupState with _$CreateGroupState {
  const factory CreateGroupState.initial() = _Initial;


  // Create Group States
  const factory CreateGroupState.createGroupLoading() = _CreateGroupLoading;
  const factory CreateGroupState.createGroupSuccess(TalkamGroup response) = _CreateGroupSuccess;
  const factory CreateGroupState.createGroupFailure(String error) = _CreateGroupFailure;

  // Update Group States
  const factory CreateGroupState.updateGroupLoading() = _UpdateGroupLoading;
  const factory CreateGroupState.updateGroupSuccess(TalkamGroup response) = _UpdateGroupSuccess;
  const factory CreateGroupState.updateGroupFailure(String error) = _UpdateGroupFailure;
}
