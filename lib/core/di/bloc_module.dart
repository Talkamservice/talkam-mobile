import 'package:get_it/get_it.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/home/presentation/bloc/drawer/drawer_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/featured_posts/featured_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/recent_post/recent_post_cubit.dart';
import 'package:talkam/features/post/presentation/bloc/trending_post/trending_post_cubit.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

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
}
