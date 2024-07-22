import 'package:get_it/get_it.dart';
import 'package:talkam/core/services/network/network_service.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
}
