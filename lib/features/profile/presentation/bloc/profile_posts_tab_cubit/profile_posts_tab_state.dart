part of 'profile_posts_tab_cubit.dart';

@freezed
class ProfilePostsTabState with _$ProfilePostsTabState {
  const factory ProfilePostsTabState.initial() = _Initial;

  const factory ProfilePostsTabState.loading() = _Loading;

  const factory ProfilePostsTabState.loaded(List<TalkamPost> posts) = _Loaded;

  const factory ProfilePostsTabState.loadingMore() = ProfilePostsTabLoadingMoreState;

  const factory ProfilePostsTabState.error() = _Error;
}
