part of 'recent_post_cubit.dart';

@freezed
class RecentPostState with _$RecentPostState {
  const factory RecentPostState.initial() = _Initial;

  const factory RecentPostState.getRecentPostsLoading() =
      _GetRecentPostsLoading;

  const factory RecentPostState.getRecentPostsSuccess(
      GetPostsResponse response) = _GetRecentPostsSuccess;

  const factory RecentPostState.getRecentPostsFailed(String error) =
      _GetRecentPostsFailed;

  const factory RecentPostState.loadingMore() = _LoadingMore;
}
