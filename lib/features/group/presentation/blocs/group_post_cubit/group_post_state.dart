part of 'group_post_cubit.dart';



@freezed
class GroupPostState with _$GroupPostState {
  const factory GroupPostState.initial() = _Initial;

  // States for Group Posts
  const factory GroupPostState.postsLoading() = _PostsLoading;
  const factory GroupPostState.postsLoaded({
    required List<TalkamPost> posts,
    required PostsPaginationData paginationData,
  }) = _PostsLoaded;
  const factory GroupPostState.postsFailed(String message) = _PostsFailed;

  // States for Group Media
  const factory GroupPostState.mediaLoading() = _MediaLoading;
  const factory GroupPostState.mediaLoaded({
    required List<TalkamPost> media,
    required PostsPaginationData paginationData,
  }) = _MediaLoaded;
  const factory GroupPostState.mediaFailed(String message) = _MediaFailed;
}

