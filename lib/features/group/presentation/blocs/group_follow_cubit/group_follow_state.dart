part of 'group_follow_cubit.dart';

@freezed
class GroupFollowState with _$GroupFollowState {
  const factory GroupFollowState.initial() = _GroupFollowInitial;

  const factory GroupFollowState.loading() = GroupFollowLoading;

  const factory GroupFollowState.success(bool following) = GroupFollowSuccess;

  const factory GroupFollowState.failure(String error) = GroupFollowFailure;
}
