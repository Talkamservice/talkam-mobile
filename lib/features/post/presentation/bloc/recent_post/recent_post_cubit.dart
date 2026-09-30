import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/post_reaction_override_store.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'recent_post_state.dart';

part 'recent_post_cubit.freezed.dart';

class RecentPostCubit extends Cubit<RecentPostState>
    implements ResettableOnLogout {
  final PostRepository postRepository;

  List<TalkamPost> _promotedPosts = []; // Track promoted posts
  int _promotedIndex = 0; // Current index of promoted posts

  RecentPostCubit(this.postRepository) : super(const RecentPostState.initial());

  @override
  void resetForLogout() => emit(const RecentPostState.initial());

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
      final mergedPosts = response.data.data.isEmpty ? <TalkamPost>[]: _mergePosts(response.data.data, _promotedPosts);

      await _applyReactionOverrides(mergedPosts);

      // Emit success state with merged posts
      final mergedResponse = response.copyWith(
        data: response.data.copyWith(data: mergedPosts),
      );

      emit(RecentPostState.getRecentPostsSuccess(mergedResponse));
    } catch (error) {
      emit(RecentPostState.getRecentPostsFailed(error.toString()));
    }
  }

  /// The posts/promoted-posts endpoints never return the current user's
  /// own `reaction` per post (same gap confirmed on post details and
  /// comments, 2026-09-30) — only `likes_count`. Without this, a post
  /// you'd already liked would render unliked on a cold fetch.
  Future<void> _applyReactionOverrides(List<TalkamPost> posts) async {
    final store = injector.get<PostReactionOverrideStore>();
    await store.ready;
    for (final post in posts) {
      final action = store.reactionFor(post.id.toString());
      if (action == "Like") {
        post.reaction = PostReaction.like();
      } else if (action == "Dislike") {
        post.reaction = PostReaction.dislike();
      }
    }
  }

  /// Patches a single post's reaction/likes/comments in place, wherever it
  /// currently appears in the loaded (and merged-with-promoted) list, and
  /// re-emits so `BlocBuilder`s rebuild — without refetching, which would
  /// replace the whole merged list back to page 1 and drop anything loaded
  /// past it via [loadMore].
  void patchPost(String postId,
      {required PostReaction? reaction,
      required dynamic likesCount,
      dynamic commentsCount}) {
    final current =
        state.whenOrNull(getRecentPostsSuccess: (response) => response);
    if (current == null) return;
    for (final post in current.data.data) {
      if (post.id.toString() != postId) continue;
      post.reaction = reaction;
      post.likesCount = likesCount;
      if (commentsCount != null) post.commentsCount = commentsCount;
      break;
    }
    emit(RecentPostState.getRecentPostsSuccess(current.copyWith()));
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
      final mergedPosts = normalPostsResponse.data.data.isEmpty ? <TalkamPost>[]:_mergePosts(
        [...previousPosts.data.data, ...normalPostsResponse.data.data],
        _promotedPosts,
      );

      await _applyReactionOverrides(mergedPosts);

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
