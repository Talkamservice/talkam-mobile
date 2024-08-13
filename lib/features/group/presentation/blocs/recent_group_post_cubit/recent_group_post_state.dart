part of 'recent_group_post_cubit.dart';

@freezed
class RecentGroupPostState with _$RecentGroupPostState {
  const factory RecentGroupPostState.initial() = _Initial;

  const factory RecentGroupPostState.getRecentPostsLoading() =
      _GetRecentPostsLoading;

  const factory RecentGroupPostState.getRecentPostsSuccess(
      GetPostsResponse response) = _GetRecentPostsSuccess;

  const factory RecentGroupPostState.getRecentPostsFailed(String error) =
      _GetRecentPostsFailed;

  const factory RecentGroupPostState.loadingMore() = _LoadingMore;
}
