import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talkam/app.dart';
import 'package:talkam/core/constants/pay_configurations.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/services/time_zone/time_zone_service.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/di/injector.dart' as di;
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:talkam/features/subscription/presentation/blocs/subscriptions_bloc/subscriptions_bloc_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:tiktok_login_flutter/tiktok_login_flutter.dart';
import 'core/services/firebase/notifiactions.dart';
import 'core/services/firebase/remote_config_service.dart';
import 'core/services/pay/pay_service.dart';
import 'core/services/pusher/pusher_channel_service.dart';
import 'firebase_options.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class AppConfig {
  final String appName;
  final Environment enviroment;

  AppConfig(this.appName, this.enviroment);

  static Future<void> run(String appName, Environment enviroment) async {
    WidgetsFlutterBinding.ensureInitialized();

    final appConfig = AppConfig(appName, enviroment);
    await appConfig._setup();

    runZonedGuarded(() => runApp(const TalkAmApp()), (error, stack) {
      logger.e(error.toString());
      logger.e(stack.toString());
    });
  }

  Future<void> _setup() async {
    await di.init();
    await _initializeServices();
    await initializeDB();
  }

  Future<void> _initializeServices() async {
    await TiktokLoginFlutter.initializeTiktokLogin("sbawv08gbmy7ntisfh");
    // await  TikTokSDK.instance.setup(clientKey: "sbawv08gbmy7ntisfh");
    await initFirebaseServices();

    await SessionManager().init();
    _checkForUpdates();

    await TimezoneService().init();
    await _getLoggedInUser();
    var pusherService = await PusherChannelService.getInstance;
    await pusherService.initialize();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> initializeDB() async {
    // Implement your DB initialization logic here
  }

  Future<void> _checkForUpdates() async {
    final updater = ShorebirdUpdater();
    // Check whether a new update is available.
    final status = await updater.checkForUpdate();

    if (status == UpdateStatus.outdated) {
      try {
        // Perform the update
        await updater.update();
      } on UpdateException catch (error) {
        // Handle any errors that occur while updating.
      }
    }
  }

  Future<void> initFirebaseServices() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await RemoteConfigsService.create();


    await notificationService.initializeNotification();
  }

  Future _getLoggedInUser() async {
    // logger.w(SessionManager.instance.isLoggedIn);

    if (SessionManager.instance.isLoggedIn) {
      injector.get<ProfileBloc>().add(GetCachedUserEvent());
      injector.get<SubscriptionsCubit>().getPlans();
    }
  }
}
