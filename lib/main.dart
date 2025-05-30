import 'package:talkam/app_config.dart';

import 'core/services/network/url_config.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();

  AppConfig.run('Talkam', Environment.development);

}
