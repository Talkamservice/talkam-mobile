import 'package:get_it/get_it.dart';
import 'package:talkam/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/post/data/repository/post_repository_impl.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';
import 'package:talkam/features/profile/data/repository/profile_repository_impl.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt.get()),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt.get()),
  );
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(getIt.get()),
  );
}
