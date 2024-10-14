import 'dart:io';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talkam/common/models/success_response.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/firebase/notifiactions.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tiktok_login_flutter/tiktok_login_flutter.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkService _networkService;

  AuthRepositoryImpl(this._networkService);

  GoogleSignIn googleAuthService = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],

    // serverClientId: ,serverClientId
    // clientId:
    //     '469691765994-mpvuctgp9epjihb9gs0bj138alged9jg.apps.googleusercontent.com',

    clientId: Platform.isAndroid
        ? '478885302787-1gaden2q9a6320jk2ajjpqoa7borgj7n.apps.googleusercontent.com'
        : "478885302787-46tgclrpaf3vqnti7g95ud418uvjla9b.apps.googleusercontent.com",
  );

  @override
  Future sendOtp(String email, String type) async {
    final response = await _networkService.call(UrlConfig.sendOtp, RequestMethod.post, data: {
      "email": email,
      "type": type,
    });

    return response.data;
  }

  @override
  Future<SuccessResponse> verifyOtp({required String email, required String code, required String type}) async {

    final response = await _networkService.call(UrlConfig.verifyOtp, RequestMethod.post, data: {"email": email, "code": code, "type": type});

    return SuccessResponse.fromJson(response.data);
  }

  @override
  Future<GoogleSignInAuthentication?> googleAuth() async {
    try {
      await googleAuthService.signOut();
      final response = await googleAuthService.signIn();

      final res = await response?.authentication;
      logger.i(res?.idToken.toString());
      logger.i(res?.accessToken.toString());
      // logger.i(res?..toString());
      //
      return res;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<AuthorizationCredentialAppleID?> appleAuth() async {
    try {
      final response = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthSuccessResponse> oauthSignIn(OauthReqDto data) async {
    var token = await NotificationService().deviceToken;
    logger.w("FCM TOKEN$token");
    logger.w("BODY RESPONSE ${data.copyWith(
          fcmToken: token,
        ).toJson()}");

    try {
      final response = await _networkService(
        UrlConfig.oauthLogin,
        RequestMethod.post,
        data: data
            .copyWith(
              fcmToken: token,
            )
            .toJson(),
      );

      return AuthSuccessResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<String> tikTokAuth() async {
    try {
      logger.w("gg");
      final result = await TiktokLoginFlutter.authorize(
        "user.info.basic",
      );

      logger.i(result.toString().toString());

      return result;
    } catch (e, stack) {
      logger.i(e.toString());
      logger.i(stack.toString());
      rethrow;
    }
  }

  @override
  Future<AccessToken?> facebookAuth() async {
    try {
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email', 'public_profile']); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        logger.i(accessToken);
        return accessToken;
      } else {
        logger.i(result.status);
        logger.i(result.message);
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthSuccessResponse> login(String email, String password) async {
    final response = await _networkService.call(UrlConfig.login, RequestMethod.post, data: {
      "input": email,
      "password": password,
      "fcm_token": await NotificationService().deviceToken,
    });

    return AuthSuccessResponse.fromJson(response.data);
  }

  @override
  Future<AuthSuccessResponse> register(String email, String password) async {
    try {
      final response = await _networkService.call(UrlConfig.register, RequestMethod.post, data: {
        "email": email,
        "password": password,
        "fcm_token": await NotificationService().deviceToken,
      });

      return AuthSuccessResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);

      rethrow;
    }
  }

  @override
  Future<dynamic> forgotPassword(String email) async {
    try {
      final response = await _networkService.call(UrlConfig.forgotPassword, RequestMethod.post, data: {"email": email});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> passwordReset(String code, String password) async {
    try {
      final response = await _networkService.call(UrlConfig.passwordReset, RequestMethod.post, data: {"code": code, "password": password});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
