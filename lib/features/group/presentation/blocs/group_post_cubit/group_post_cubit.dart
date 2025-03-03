import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'group_post_state.dart';

part 'group_post_cubit.freezed.dart';

class GroupPostCubit extends Cubit<GroupPostState> {
  GroupPostCubit(this.groupRepository) : super(const GroupPostState.initial());

  final PostRepository groupRepository;

  // Fetch group posts
  Future<void> getGroupPosts(String groupId) async {
    emit(const GroupPostState.postsLoading());

    try {
      final GetPostsResponse response = await groupRepository.getPosts(
        PostFilterModel.groupPost(groupId: groupId, page: 1),
      );

      emit(GroupPostState.postsLoaded(
        posts: response.data.data,
        paginationData: response.data.paginationMeta,
      ));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupPostState.postsFailed(e.toString()));
    }
  }

  // Fetch next page of group posts
  Future<void> fetchNextPostsPage({
    required List<TalkamPost> previousPosts,
    required PostsPaginationData paginationData,
    required String groupId,
  }) async {
    if (!paginationData.canLoadMore) return;

    try {
      final GetPostsResponse response = await groupRepository.getPosts(
        PostFilterModel.groupPost(groupId: groupId, page: paginationData.currentPage + 1),
      );

      emit(GroupPostState.postsLoaded(
        posts: [
          ...previousPosts,
          ...response.data.data,
        ],
        paginationData: response.data.paginationMeta,
      ));
    } catch (e, stack) {
      emit(GroupPostState.postsFailed(e.toString()));
    }
  }

  // Fetch group media
  Future<void> getGroupMedia(String groupId) async {
    emit(const GroupPostState.mediaLoading());

    try {
      final GetPostsResponse response = await groupRepository.getPosts(
        PostFilterModel.groupPost(groupId: groupId, page: 1, isMedia: true),
      );

      emit(GroupPostState.mediaLoaded(
        media: response.data.data,
        paginationData: response.data.paginationMeta,
      ));
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      emit(GroupPostState.mediaFailed(e.toString()));
    }
  }

  // Fetch next page of group media
  Future<void> fetchNextMediaPage({
    required List<TalkamPost> previousMedia,
    required PostsPaginationData paginationData,
    required String groupId,
  }) async {
    if (!paginationData.canLoadMore) return;

    try {
      final GetPostsResponse response = await groupRepository.getPosts(
        PostFilterModel.groupPost(groupId: groupId, page: paginationData.currentPage + 1, isMedia: true),
      );

      emit(GroupPostState.mediaLoaded(
        media: [
          ...previousMedia,
          ...response.data.data,
        ],
        paginationData: response.data.paginationMeta,
      ));
    } catch (e, stack) {
      emit(GroupPostState.mediaFailed(e.toString()));
    }
  }
}
