import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigsService {
  RemoteConfigsService._();

  /// [RemoteConfigsService] factory constructor.
  static Future<RemoteConfigsService?> create() async {
    try {
      final RemoteConfigsService remoteConfigsService = RemoteConfigsService._();
      await remoteConfigsService._init();
      return remoteConfigsService;
    } on Exception catch (_) {
      return null;
    }
  }

  _init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(milliseconds: 300),
      minimumFetchInterval: const Duration(milliseconds: 100),
    ));
    await remoteConfig.fetchAndActivate();
    remoteConfig.onConfigUpdated.asBroadcastStream().listen((event) async {
      await remoteConfig.activate();
    });
  }

  Future<void> retrieveSecrets() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.fetchAndActivate();
      // final Map<String, String> secrets = {
      //   'stripe_publishable_key':
      //       remoteConfig.getString('stripe_publishable_key'),
      //   'stripe_secret_key': remoteConfig.getString('stripe_secret_key'),
      //   'one_signal_key': remoteConfig.getString('one_signal_key'),
      // };

      // return secrets;
    } catch (e) {
      log("Firebase remote exception: $e");
    }
  }

  static String? getString(String key) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      return remoteConfig.getString(key);
    } catch (e) {
      log("Firebase remote exception: $e");
      return null;
    }
  }

  static RemoteConfigValue? getValue(String key) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      return remoteConfig.getValue(key);
    } catch (e) {
      log("Firebase remote exception: $e");
      return null;
    }
  }

  static bool? getBool(String key) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      return remoteConfig.getBool(key);
    } catch (e) {
      log("Firebase remote exception: $e");
      return null;
    }
  }
}

class RemoteConfigKeys {
  static String SUBSCRIPTION_ENABLED = 'SUBSCRIPTION_ENABLED';
  static String locationEnforced = 'location_enforced';
}
