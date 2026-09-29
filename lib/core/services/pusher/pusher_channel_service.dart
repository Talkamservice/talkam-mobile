import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';

class PusherChannelService {
  PusherChannelService._();

  static PusherChannelsFlutter? pusher;

  // / [PusherService] factory constructor.
  static Future<PusherChannelService> get getInstance async {
    final PusherChannelService pusherService = PusherChannelService._();
    return pusherService;
  }

  Future<void> initialize() async {
    var connections = await Connectivity().checkConnectivity();

    if (!connections.contains(ConnectivityResult.none)) {
      try {
        pusher = PusherChannelsFlutter.getInstance();

        await pusher?.init(
          // apiKey: '86bddfa4606d2c40e7a5',
          apiKey: '1934aa1e05c3acfdfd3f',
          cluster: "mt1",

          maxReconnectGapInSeconds: 1,
          onEvent: (event) {
            // logger.w(event.data);
            // AppUtils.showCustomToast(event.data.toString());
          },
          onSubscriptionError: (d, a) {
            log("onSubscriptionError: $d Exception: $a");
            // AppUtils.showCustomToast("onSubscriptionError: $d Exception: $a");
          },
          onAuthorizer: authorize,
        );

        await pusher?.connect();

        // pusher?.onConnectionStateChange = (currentState, previousState) async {
        //   var connections = await Connectivity().checkConnectivity();
        //
        //   debugPrint(
        //       "Pusher connection previousState: $previousState, currentState: $currentState");
        //   if (currentState == "DISCONNECTED") {
        //     //
        //
        //     if (!connections.contains(ConnectivityResult.none)) {
        //       pusher?.connect();
        //     }
        //
        //     // initialize();
        //   }
        // };

        pusher?.onError = (message, code, error) {
          debugPrint("Pusher Error: ${error?.message}");
        };
      } catch (e, stackTrace) {
        logger.e(e, stackTrace: stackTrace);
        // SentryService.captureException(e, stackTrace: stackTrace);
      }
    }
  }

  Future<PusherChannelsFlutter?> get getClient async {
    if (pusher == null) {
      await initialize();
    }
    return pusher;
  }

  /// Unsubscribe from a channel
  Future<void> unsubscribe(String channelName) async {
    try {
      (await getClient)?.unsubscribe(channelName: channelName);
    } catch (exception, stackTrace) {
      // SentryService.captureException(exception, stackTrace: stackTrace);
    }
  }

  /// Tears down the socket on logout/delete-account so the old session's
  /// private channels (e.g. conversation subscriptions) aren't left live
  /// under the now-signed-out user. `pusher` is nulled after so the next
  /// [getClient] call re-initializes from scratch for whoever logs in next.
  static Future<void> disconnect() async {
    try {
      await pusher?.disconnect();
    } catch (exception, stackTrace) {
      // SentryService.captureException(exception, stackTrace: stackTrace);
    } finally {
      pusher = null;
    }
  }

  /// Real per-channel authorization via the backend's `POST /broadcasting/auth`
  /// (Laravel's standard broadcasting auth route, Sanctum-gated) — replaces
  /// the previous local HMAC signing (a Pusher app secret compiled into the
  /// binary, extractable from the APK; anyone could sign auth for any
  /// channel). `NetworkService`'s auth interceptor attaches the bearer token
  /// automatically. Shared by both the app-wide default (`initialize()`
  /// below) and per-conversation subscriptions (`MessagingCubit`), so there's
  /// one real implementation instead of two divergent local ones.
  static Future<dynamic> authorize(
      String channelName, String socketId, dynamic options) async {
    try {
      final response =
          await NetworkService(baseUrl: UrlConfig.rootBaseUrl).call(
        '/broadcasting/auth',
        RequestMethod.post,
        formData: FormData.fromMap({
          'channel_name': channelName,
          'socket_id': socketId,
        }),
        options: Options(headers: {"Accept": "application/json"}),
      );
      logger.i(
          'PUSHER AUTH OK -> channel: $channelName, socketId: $socketId, response: ${response.data}');
      return response.data;
    } catch (e) {
      // A failed auth here fails the Pusher subscription *silently* on the
      // native side otherwise — log it loudly while verifying this.
      logger.e(
          'PUSHER AUTH FAILED -> channel: $channelName, socketId: $socketId, error: $e');
      rethrow;
    }
  }
}
