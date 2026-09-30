import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/post_reaction_override_store.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'featured_post_state.dart';

part 'featured_post_cubit.freezed.dart';

class FeaturedPostCubit extends Cubit<FeaturedPostState>
    implements ResettableOnLogout {
  final PostRepository postRepository;

  bool _isLoadingMore = false;

  FeaturedPostCubit(this.postRepository)
      : super(const FeaturedPostState.initial());

  @override
  void resetForLogout() => emit(const FeaturedPostState.initial());

  /// Backs the "For You" tab — v2's `tab=for_you` feed. Promoted posts are
  /// already interleaved server-side (each post carries its own `promotion`
  /// flag), unlike the old v1 flow which fetched and merged them separately.
  void getFeaturedPosts(PostFilterModel filter, {bool? reload}) async {
    if (reload ?? true) {
      emit(const FeaturedPostState.getFeaturedPostsLoading());
    }
    try {
      final response = await postRepository.getFeed(
        tab: "for_you",
        categoryId: filter.category,
        page: filter.page,
      );
      await _applyReactionOverrides(response.data.data);

      emit(FeaturedPostState.getFeaturedPostsSuccess(response));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(FeaturedPostState.getFeaturedPostsFailed(error.toString()));
    }
  }

  /// The feed endpoint never returns the current user's own `reaction`
  /// per post (same gap confirmed on post details and comments,
  /// 2026-09-30) — only `likes_count`. Without this, a post you'd
  /// already liked would render unliked on a cold fetch.
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
  /// currently appears in the loaded list (any page), and re-emits so
  /// `BlocBuilder`s rebuild — without refetching. [getFeaturedPosts] always
  /// fetches page 1 (`PostFilterModel.featuredPost()` never sets `page`),
  /// so calling it to sync a single post's like count after returning from
  /// its detail screen silently replaced the whole list and dropped
  /// anything loaded past page 1 via [loadMore].
  void patchPost(String postId,
      {required PostReaction? reaction,
      required dynamic likesCount,
      dynamic commentsCount}) {
    final current =
        state.whenOrNull(getFeaturedPostsSuccess: (response) => response);
    if (current == null) return;
    for (final post in current.data.data) {
      if (post.id.toString() != postId) continue;
      post.reaction = reaction;
      post.likesCount = likesCount;
      if (commentsCount != null) post.commentsCount = commentsCount;
      break;
    }
    emit(FeaturedPostState.getFeaturedPostsSuccess(current.copyWith()));
  }

  /// Fetches the next page and appends it to whatever's currently shown.
  /// No-ops if nothing's loaded yet, a fetch is already in flight, or the
  /// current page is already the last one.
  Future<void> loadMore() async {
    final previous =
        state.whenOrNull(getFeaturedPostsSuccess: (response) => response);
    if (_isLoadingMore || previous == null) return;
    if (previous.data.paginationMeta.canLoadMore != true) return;

    _isLoadingMore = true;
    try {
      final response = await postRepository.getFeed(
        tab: "for_you",
        page: previous.data.paginationMeta.currentPage + 1,
      );
      await _applyReactionOverrides(response.data.data);

      final mergedResponse = response.copyWith(
        data: response.data.copyWith(
          data: [...previous.data.data, ...response.data.data],
        ),
      );

      emit(FeaturedPostState.getFeaturedPostsSuccess(mergedResponse));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      // Keep showing what's already loaded — a failed "load more" shouldn't
      // wipe the list or replace it with a full error screen.
    } finally {
      _isLoadingMore = false;
    }
  }
}
