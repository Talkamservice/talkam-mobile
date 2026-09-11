import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/features/group/presentation/blocs/create_group_cubit/create_group_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/featured_groups/featured_groups_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_data_cubit.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/blocs/messaging/messaging_cubit.dart';
import 'package:talkam/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:talkam/features/notifications/presentation/bloc/push_notifications_navigator_bloc/deep_link_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:talkam/features/post/presentation/bloc/recent_post/recent_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/connections_summary_cubit/connections_summary_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_posts_tab_cubit/profile_posts_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_screen_cubit/profile_screen_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_upvotes_cubit/profile_upvotes_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_comments_cubit/user_profile_comments_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_cubit/user_profile_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_media_tab/user_profile_media_tab_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_posts_cubit/user_profile_posts_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/user_profile_upvotes_cubit/user_profile_upvotes_cubit.dart';
import 'package:talkam/features/search/presentation/blocs/search/search_cubit.dart';
import 'package:talkam/features/subscription/presentation/blocs/subscriptions_bloc/subscriptions_bloc_cubit.dart';

/// Every GetIt-registered singleton bloc/cubit (`lib/core/di/bloc_module.dart`)
/// that implements [ResettableOnLogout]. `SessionManager.logOut()` calls
/// `resetForLogout()` on each of these so a second account signing in on the
/// same device never sees the previous account's cached data.
///
/// Adding a new singleton to `bloc_module.dart` means implementing
/// [ResettableOnLogout] on it and adding it here too — nothing enforces the
/// link automatically.
List<ResettableOnLogout> resettableSingletons() => [
      injector.get<ProfileBloc>(),
      injector.get<DrawerCubit>(),
      injector.get<DrawerDataCubit>(),
      injector.get<CreatePostCubit>(),
      injector.get<FeaturedPostCubit>(),
      injector.get<RecentPostCubit>(),
      injector.get<TrendingPostCubit>(),
      injector.get<SubscriptionsCubit>(),
      injector.get<PostBloc>(),
      injector.get<PushNotificationNavigatorBloc>(),
      injector.get<ProfileScreenCubit>(),
      injector.get<ProfileUpvotesCubit>(),
      injector.get<ProfilePostsTabCubit>(),
      injector.get<ConnectionsSummaryCubit>(),
      injector.get<UserProfileCubit>(),
      injector.get<UserProfileUpvotesCubit>(),
      injector.get<UserProfilePostsCubit>(),
      injector.get<UserProfileCommentsCubit>(),
      injector.get<UserProfileMediaTabCubit>(),
      injector.get<SearchCubit>(),
      injector.get<GroupsCubit>(),
      injector.get<CreateGroupCubit>(),
      injector.get<ConversationsCubit>(),
      injector.get<MessagingCubit>(),
      injector.get<NotificationsBloc>(),
      injector.get<FeaturedGroupsCubit>(),
    ];
