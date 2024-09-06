import 'package:get_it/get_it.dart';
import 'package:talkam/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/group/data/repository/group_members_access_repository_impl.dart';
import 'package:talkam/features/group/data/repository/group_membes_repository.dart';
import 'package:talkam/features/group/data/repository/group_repository_impl.dart';
import 'package:talkam/features/group/dormain/repository/group_members_access.dart';
import 'package:talkam/features/group/dormain/repository/group_members_repository.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/messaging/data/repository/messaging_repository_impl.dart';
import 'package:talkam/features/messaging/dormain/repository/messaging_repository.dart';
import 'package:talkam/features/notifications/data/repository/notifications_repository_impl.dart';
import 'package:talkam/features/notifications/dormain/repository/notifications_repository.dart';
import 'package:talkam/features/post/data/repository/post_repository_impl.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';
import 'package:talkam/features/profile/data/repository/profile_repository_impl.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';
import 'package:talkam/features/search/data/repository/search_repository.dart';
import 'package:talkam/features/search/dormain/repository/search_repository_impl.dart';
import 'package:talkam/features/settings/data/repository/settings_repository_impl.dart';
import 'package:talkam/features/settings/dormain/repository/settings_repoitory.dart';

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
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt.get()),
  );
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(getIt.get()),
  );
  getIt.registerLazySingleton<GroupsRepository>(
    () => GroupsRepositoryImpl(getIt.get()),
  );
  getIt.registerLazySingleton<GroupMembersRepository>(
    () => GroupMembersRepositoryImpl(getIt.get()),
  );
  getIt.registerLazySingleton<MessagingRepository>(
    () => MessagingRepositoryImpl(getIt.get()),
  );
  getIt.registerLazySingleton<NotificationsRepository>(
    () => NotificationRepositoryImpl(getIt.get()),
  );
}
