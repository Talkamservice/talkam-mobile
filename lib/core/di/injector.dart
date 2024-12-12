import 'package:logger/logger.dart';
import 'package:talkam/core/di/bloc_module.dart' as blocModule;
import 'package:talkam/core/di/network.dart' as networkModule;
import 'package:talkam/core/di/service_module.dart' as serviceModule;
import 'package:talkam/core/di/repository.dart' as repositoryModule;
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

final logger = Logger(level: Level.debug,);

Future<void> init() async {
  // mesiboModule.setup(injector);
  networkModule.setup(injector);
  repositoryModule.setup(injector);
  blocModule.setup(injector);
  serviceModule.setup(injector);
}
