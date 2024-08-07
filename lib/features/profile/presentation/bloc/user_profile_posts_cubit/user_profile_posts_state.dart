part of 'user_profile_posts_cubit.dart';

@freezed
class UserProfilePostsState with _$UserProfilePostsState {
  const factory UserProfilePostsState.initial() = _Initial;

  const factory UserProfilePostsState.loading() = _Loading;

  const factory UserProfilePostsState.loaded(List<TalkamPost> posts) = _Loaded;

  const factory UserProfilePostsState.loadingMore() = UserProfilePostsTabLoadingMoreState;

  const factory UserProfilePostsState.error() = _Error;
}
