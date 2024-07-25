part of 'profile_comment_tab_cubit.dart';

@freezed
class ProfileCommentTabState with _$ProfileCommentTabState {
  const factory ProfileCommentTabState.initial() = _Initial;

  const factory ProfileCommentTabState.loading() = _Loading;

  const factory ProfileCommentTabState.loaded(List<TalkAmComment> comments) = _Loaded;

  const factory ProfileCommentTabState.loadingMore() = ProfileCommentLoadingMoreTabState;

  const factory ProfileCommentTabState.error() = _Error;
}
