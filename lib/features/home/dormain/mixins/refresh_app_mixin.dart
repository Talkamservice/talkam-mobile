import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/recent_post/recent_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

mixin RefreshAppMixin{
  void refreshApp({bool? reload}) {
    injector
        .get<FeaturedPostCubit>()
        .getFeaturedPosts(PostFilterModel.featuredPost(), reload: reload);
    injector
        .get<RecentPostCubit>()
        .getRecentPosts(PostFilterModel.recentPost(), reload: reload);
    injector
        .get<TrendingPostCubit>()
        .getTrendingPosts(PostFilterModel.trendingPost(), reload: reload);
    
    injector.get<ProfileBloc>().add(const GetRemoteUser());
  }
}