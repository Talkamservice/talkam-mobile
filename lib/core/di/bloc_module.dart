import 'package:get_it/get_it.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/presentation/blocs/create_group_cubit/create_group_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/blocs/messaging/messaging_cubit.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/recent_post/recent_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_comment_tab_cubit/profile_comment_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_posts_tab_cubit/profile_posts_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_screen_cubit/profile_screen_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_comments_cubit/user_profile_comments_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_cubit/user_profile_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_media_tab/user_profile_media_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_posts_cubit/user_profile_posts_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_upvotes_cubit/user_profile_upvotes_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/search/search_cubit.dart';
import '../../features/profile/presentation/bloc/profile_upvotes_cubit/profile_upvotes_cubit.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(getIt.get()),
  );

  getIt.registerLazySingleton<DrawerCubit>(
    () => DrawerCubit(),
  );

  getIt.registerLazySingleton<CreatePostCubit>(
    () => CreatePostCubit(injector.get()),
  );

  getIt.registerLazySingleton<FeaturedPostCubit>(
    () => FeaturedPostCubit(injector.get()),
  );

  getIt.registerLazySingleton<RecentPostCubit>(
    () => RecentPostCubit(injector.get()),
  );

  getIt.registerLazySingleton<TrendingPostCubit>(
    () => TrendingPostCubit(injector.get()),
  );

  getIt.registerLazySingleton<PostBloc>(
    () => PostBloc(injector.get()),
  );

  getIt.registerLazySingleton<ProfileScreenCubit>(() => ProfileScreenCubit(injector.get()));
  getIt.registerLazySingleton<ProfileUpvotesCubit>(() => ProfileUpvotesCubit(injector.get()));

  getIt.registerLazySingleton<ProfilePostsTabCubit>(() => ProfilePostsTabCubit(injector.get()));

  getIt.registerFactory<ProfileCommentTabCubit>(() => ProfileCommentTabCubit(injector.get()));

  getIt.registerLazySingleton<UserProfileCubit>(() => UserProfileCubit(injector.get()));
  getIt.registerLazySingleton<UserProfileUpvotesCubit>(() => UserProfileUpvotesCubit(injector.get()));

  getIt.registerLazySingleton<UserProfilePostsCubit>(() => UserProfilePostsCubit(injector.get()));

  getIt.registerLazySingleton<UserProfileCommentsCubit>(() => UserProfileCommentsCubit(injector.get()));
  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(injector.get()));
  getIt.registerLazySingleton<GroupsCubit>(() => GroupsCubit(injector.get()));

  getIt.registerLazySingleton<CreateGroupCubit>(() => CreateGroupCubit(injector.get()));

  getIt.registerLazySingleton<ConversationsCubit>(() => ConversationsCubit(injector.get()));
  getIt.registerLazySingleton<MessagingCubit>(() => MessagingCubit(injector.get()));
  getIt.registerLazySingleton<NotificationsBloc>(() => NotificationsBloc(injector.get(), injector.get()));

  getIt.registerLazySingleton<UserProfileMediaTabCubit>(() => UserProfileMediaTabCubit(
        injector.get(),
      ));
}
