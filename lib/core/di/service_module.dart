
import 'package:get_it/get_it.dart';
import 'package:talkam/core/services/biometric/biometric_service.dart';
import 'package:talkam/core/services/biometric/local_auth_biometric_service.dart';
import 'package:talkam/core/services/data/comment_reaction_override_store.dart';
import 'package:talkam/core/services/data/post_reaction_override_store.dart';
import 'package:talkam/core/services/location_service/location_service.dart';


void setup(GetIt getIt) {
  //
  // getIt.registerLazySingleton<NetworkService>(
  //         () => NetworkService(baseUrl: UrlConfig.coreBaseUrl));
  getIt.registerLazySingleton<LocationService>(() => LocationService());
  getIt.registerLazySingleton<BiometricService>(() => LocalAuthBiometricService());
  getIt.registerLazySingleton<CommentReactionOverrideStore>(
      () => CommentReactionOverrideStore());
  getIt.registerLazySingleton<PostReactionOverrideStore>(
      () => PostReactionOverrideStore());
}
