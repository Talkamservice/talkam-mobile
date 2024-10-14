import 'package:get_it/get_it.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/features/authentication/data/repository/auth_repository_impl.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
}
