import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'featured_post_state.dart';

part 'featured_post_cubit.freezed.dart';

class FeaturedPostCubit extends Cubit<FeaturedPostState> {
  final PostRepository postRepository;

  List<TalkamPost> _promotedPosts = []; // Track promoted posts
  int _promotedIndex = 0; // Current index of promoted posts

  FeaturedPostCubit(this.postRepository) : super(const FeaturedPostState.initial());

  void getFeaturedPosts(PostFilterModel filter, {bool? reload}) async {
    if (reload ?? true) {
      emit(const FeaturedPostState.getFeaturedPostsLoading());
    }
    try {
      // Fetch featured and promoted posts simultaneously
      var response;
      var promotedResponse;
      var allResponse = await Future.wait([postRepository.getPosts(filter), postRepository.getPromotedPosts()]);

      response = allResponse.first;
      promotedResponse = allResponse.last;

      // Save promoted posts and reset index
      _promotedPosts = promotedResponse.data.data;
      _promotedIndex = 0;

      // Merge posts
      final mergedPosts = response.data.data.isEmpty ? <TalkamPost>[]: _mergePosts(response.data.data, _promotedPosts);

      // Emit success state with merged posts
      final mergedResponse = response.copyWith(
        data: response.data.copyWith(data: mergedPosts),
      );

      emit(FeaturedPostState.getFeaturedPostsSuccess(mergedResponse));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(FeaturedPostState.getFeaturedPostsFailed(error.toString()));
    }
  }

  void loadMore(GetPostsResponse previousPosts) async {
    try {
      // Fetch more featured posts
      final featuredPostsResponse = await postRepository.getPosts(
        PostFilterModel(
          page: previousPosts.data.paginationMeta.currentPage + 1,
          tab: "featured",
        ),
      );

      // Check if promoted posts are exhausted
      if (_promotedIndex >= _promotedPosts.length) {
        final promotedResponse = await postRepository.getPromotedPosts();
        _promotedPosts = promotedResponse.data.data;
        _promotedIndex = 0;
      }

      // Merge new featured posts with remaining/promoted posts
      final mergedPosts = featuredPostsResponse.data.data.isEmpty ? <TalkamPost>[]: _mergePosts(
        [...previousPosts.data.data, ...featuredPostsResponse.data.data],
        _promotedPosts,
      );

      // Emit success state with updated posts
      final updatedResponse = featuredPostsResponse.copyWith(
        data: featuredPostsResponse.data.copyWith(data: mergedPosts),
      );

      emit(FeaturedPostState.getFeaturedPostsSuccess(updatedResponse));
    } catch (error) {
      emit(FeaturedPostState.getFeaturedPostsFailed(error.toString()));
    }
  }

  List<TalkamPost> _mergePosts(List<TalkamPost> featuredPosts, List<TalkamPost> promotedPosts) {
    final List<TalkamPost> mergedPosts = [];
    int featuredIndex = 0;
    int count = 0;

    // Merge featured and promoted posts
    while (featuredIndex < featuredPosts.length) {
      mergedPosts.add(featuredPosts[featuredIndex]);
      featuredIndex++;
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
