import 'package:talkam/app_config.dart';

import 'core/services/network/url_config.dart';

Future<void> main() async {
  AppConfig.run('Talkam', Environment.development);
  // await initializeService();
}
