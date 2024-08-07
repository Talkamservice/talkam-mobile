part of 'user_profile_upvotes_cubit.dart';

@freezed
class UserProfileUpvotesState with _$UserProfileUpvotesState {
  const factory UserProfileUpvotesState.initial() = _Initial;

  // const factory ProfileUpvotesTabState.initial() = _Initial;

  const factory UserProfileUpvotesState.loading() = _Loading;

  const factory UserProfileUpvotesState.loaded(List<TalkamPost> posts) =
      _Loaded;

  const factory UserProfileUpvotesState.loadingMore() =
      UserProfileUpvotesTabLoadingMoreState;

  const factory UserProfileUpvotesState.error() = _Error;
}
