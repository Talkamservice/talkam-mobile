part of 'follow_cubit.dart';

@freezed
class FollowState with _$FollowState {
  const factory FollowState.initial() = _FollowInitial;

  const factory FollowState.loading() = FollowLoading;

  const factory FollowState.success(bool following) = FollowSuccess;

  const factory FollowState.failure(String error) = FollowFailure;
}
