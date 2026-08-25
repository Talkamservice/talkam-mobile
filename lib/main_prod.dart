import 'package:talkam/app_config.dart';

import 'core/services/network/url_config.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Production entrypoint. Build/run with:
///   flutter build appbundle --target=lib/main_prod.dart --dart-define-from-file=prod_config.json
///   flutter run --target=lib/main_prod.dart --dart-define-from-file=prod_config.json
///
/// lib/main.dart (Environment.development) stays the entrypoint for local
/// dev/staging work — this is the only difference between the two files.
Future<void> main() async {
  await Hive.initFlutter();

  AppConfig.run('Talkam', Environment.production);
}
