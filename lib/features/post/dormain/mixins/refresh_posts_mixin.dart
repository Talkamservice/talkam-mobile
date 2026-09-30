import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/recent_post/recent_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';

mixin RefreshPostsMixin {
  void refreshPost({bool? reload}) {
    injector
        .get<FeaturedPostCubit>()
        .getFeaturedPosts(PostFilterModel.featuredPost(), reload: reload);
    injector
        .get<RecentPostCubit>()
        .getRecentPosts(PostFilterModel.recentPost(), reload: reload);
    injector
        .get<TrendingPostCubit>()
        .getTrendingPosts(PostFilterModel.trendingPost(), reload: reload);

    injector.get<NotificationsBloc>().add(const GetAnnouncementsEvent());

  }

  /// Patches one post's reaction/likes/comments across all three feed
  /// cubits' currently-loaded lists (whichever page it happens to be on),
  /// instead of [refreshPost]'s full refetch — which always re-fetches
  /// page 1 and would silently replace the whole feed, discarding
  /// anything the user had scrolled to via `loadMore()`. Use this to
  /// reflect a change made on a post's own detail screen back onto the
  /// feed lists.
  void syncPostAcrossFeeds(String postId,
      {required PostReaction? reaction,
      required dynamic likesCount,
      dynamic commentsCount}) {
    injector.get<FeaturedPostCubit>().patchPost(postId,
        reaction: reaction, likesCount: likesCount, commentsCount: commentsCount);
    injector.get<RecentPostCubit>().patchPost(postId,
        reaction: reaction, likesCount: likesCount, commentsCount: commentsCount);
    injector.get<TrendingPostCubit>().patchPost(postId,
        reaction: reaction, likesCount: likesCount, commentsCount: commentsCount);
  }
}
