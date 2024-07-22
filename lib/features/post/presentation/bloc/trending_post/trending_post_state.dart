part of 'trending_post_cubit.dart';

@freezed
class TrendingPostState with _$TrendingPostState {
  const factory TrendingPostState.initial() = _Initial;
  const factory TrendingPostState.getTrendingPostsLoading() = _GetTrendingPostsLoading;
  const factory TrendingPostState.getTrendingPostsSuccess(GetPostsResponse response) = _GetTrendingPostsSuccess;
  const factory TrendingPostState.getTrendingPostsFailed(String error) = _GetTrendingPostsFailed;
  const factory TrendingPostState.loadingMore() = _LoadingMore;

}
