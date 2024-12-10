import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'recent_post_state.dart';

part 'recent_post_cubit.freezed.dart';

class RecentPostCubit extends Cubit<RecentPostState> {
  final PostRepository postRepository;

  List<TalkamPost> _promotedPosts = []; // Track promoted posts
  int _promotedIndex = 0; // Current index of promoted posts

  RecentPostCubit(this.postRepository) : super(const RecentPostState.initial());

  void getRecentPosts(PostFilterModel filter, {bool? reload}) async {
    if (reload ?? true) {
      emit(const RecentPostState.getRecentPostsLoading());
    }

    try {
      // Fetch normal and promoted posts
      var response;
      var promotedResponse;
      var allResponse = await Future.wait([postRepository.getPosts(filter), postRepository.getPromotedPosts()]);
      // Save promoted posts and reset index
      response = allResponse.first;
      promotedResponse = allResponse.last;
      _promotedPosts = promotedResponse.data.data;
      _promotedIndex = 0;

      // Merge posts
      final mergedPosts = _mergePosts(response.data.data, _promotedPosts);

      // Emit success state with merged posts
      final mergedResponse = response.copyWith(
        data: response.data.copyWith(data: mergedPosts),
      );

      emit(RecentPostState.getRecentPostsSuccess(mergedResponse));
    } catch (error) {
      emit(RecentPostState.getRecentPostsFailed(error.toString()));
    }
  }

  void loadMore(GetPostsResponse previousPosts) async {
    try {
      // Fetch more normal posts
      final normalPostsResponse = await postRepository.getPosts(
        PostFilterModel(page: previousPosts.data.paginationMeta.currentPage + 1, tab: "latest"),
      );

      // Check if promoted posts are exhausted
      if (_promotedIndex >= _promotedPosts.length) {
        final promotedResponse = await postRepository.getPromotedPosts();
        _promotedPosts = promotedResponse.data.data;
        _promotedIndex = 0;
      }

      // Merge new normal posts with remaining promoted posts
      final mergedPosts = _mergePosts(
        [...previousPosts.data.data, ...normalPostsResponse.data.data],
        _promotedPosts,
      );

      // Emit success state with updated posts
      final updatedResponse = normalPostsResponse.copyWith(
        data: normalPostsResponse.data.copyWith(data: mergedPosts),
      );

      emit(RecentPostState.getRecentPostsSuccess(updatedResponse));
    } catch (error) {
      emit(RecentPostState.getRecentPostsFailed(error.toString()));
    }
  }

  List<TalkamPost> _mergePosts(List<TalkamPost> normalPosts, List<TalkamPost> promotedPosts) {
    final List<TalkamPost> mergedPosts = [];
    int normalIndex = 0;
    int count = 0;

    // Merge normal and promoted posts
    while (normalIndex < normalPosts.length) {
      mergedPosts.add(normalPosts[normalIndex]);
      normalIndex++;
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
