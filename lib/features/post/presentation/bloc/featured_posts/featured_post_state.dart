part of 'featured_post_cubit.dart';

@freezed
class FeaturedPostState with _$FeaturedPostState {
  const factory FeaturedPostState.initial() = _Initial;

  const factory FeaturedPostState.getFeaturedPostsSuccess(GetPostsResponse respone) =
      _GetFeaturedPostsSuccess;

  const factory FeaturedPostState.getFeaturedPostsLoading() =
      _GetFeaturedPostsLoading;

  const factory FeaturedPostState.getFeaturedPostsFailed(String error) =
      _GetFeaturedPostsFailed;

  const factory FeaturedPostState.loadingMore() = _LoadingMore;

  const factory FeaturedPostState.moreLoaded() = _MoreLoaded;

  const factory FeaturedPostState.moreFailed() = _MoreFailed;
}
