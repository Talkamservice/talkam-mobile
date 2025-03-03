import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'trending_post_state.dart';

part 'trending_post_cubit.freezed.dart';

class TrendingPostCubit extends Cubit<TrendingPostState> {
  final PostRepository postRepository;

  List<TalkamPost> _promotedPosts = []; // Track promoted posts
  int _promotedIndex = 0; // Current index of promoted posts

  TrendingPostCubit(this.postRepository) : super(const TrendingPostState.initial());

  void getTrendingPosts(PostFilterModel filter, {bool? reload}) async {
    if (reload ?? true) {
      emit(const TrendingPostState.getTrendingPostsLoading());
    }
    try {
      // Fetch trending and promoted posts simultaneously
      var response;
      var promotedResponse;
      var allResponse = await Future.wait([postRepository.getPosts(filter), postRepository.getPromotedPosts()]);

      response = allResponse.first;
      promotedResponse = allResponse.last;

      // Save promoted posts and reset index
      _promotedPosts = promotedResponse.data.data;
      _promotedIndex = 0;

      // Merge posts
      final mergedPosts = response.data.data.isEmpty ? <TalkamPost>[] : _mergePosts(response.data.data, _promotedPosts);

      // Emit success state with merged posts
      final mergedResponse = response.copyWith(
        data: response.data.copyWith(data: mergedPosts),
      );

      emit(TrendingPostState.getTrendingPostsSuccess(mergedResponse));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(TrendingPostState.getTrendingPostsFailed(error.toString()));
    }
  }

  void loadMore(GetPostsResponse previousPosts) async {
    try {
      // Fetch more trending posts
      final trendingPostsResponse = await postRepository.getPosts(
        PostFilterModel(
          page: previousPosts.data.paginationMeta.currentPage + 1,
          tab: "trending",
        ),
      );

      // Check if promoted posts are exhausted
      if (_promotedIndex >= _promotedPosts.length) {
        final promotedResponse = await postRepository.getPromotedPosts();
        _promotedPosts = promotedResponse.data.data;
        _promotedIndex = 0;
      }

      // Merge new trending posts with remaining/promoted posts
      final mergedPosts = trendingPostsResponse.data.data.isEmpty
          ? <TalkamPost>[]
          : _mergePosts(
              [...previousPosts.data.data, ...trendingPostsResponse.data.data],
              _promotedPosts,
            );

      // Emit success state with updated posts
      final updatedResponse = trendingPostsResponse.copyWith(
        data: trendingPostsResponse.data.copyWith(data: mergedPosts),
      );

      emit(TrendingPostState.getTrendingPostsSuccess(updatedResponse));
    } catch (error) {
      emit(TrendingPostState.getTrendingPostsFailed(error.toString()));
    }
  }

  List<TalkamPost> _mergePosts(List<TalkamPost> trendingPosts, List<TalkamPost> promotedPosts) {
    final List<TalkamPost> mergedPosts = [];
    int trendingIndex = 0;
    int count = 0;

    // Merge trending and promoted posts
    while (trendingIndex < trendingPosts.length) {
      mergedPosts.add(trendingPosts[trendingIndex]);
      trendingIndex++;
      count++;

      if (count == 5 && _promotedIndex < promotedPosts.length) {
        mergedPosts.add(promotedPosts[_promotedIndex]);
        _promotedIndex++;
        count = 0;
      }
    }

    // Add remaining promoted posts if any
    while (_promotedIndex < promotedPosts.length) {
      mergedPosts.add(promotedPosts[_promotedIndex]);
      _promotedIndex++;
    }

    return mergedPosts;
  }
}
