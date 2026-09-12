import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:talkam/common/models/success_response.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/firebase/notifiactions.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:talkam/core/services/data/session_manager.dart';

class AuthRepositoryImpl extends AuthRepository {
  /// Authentication has migrated to the v2 API — every call in this
  /// repository hits [UrlConfigV2.coreBaseUrl] rather than the v1 base
  /// used by the rest of the app.
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  static Options get _formOptions =>
      Options(headers: {"Accept": "application/json"});

  GoogleSignIn googleAuthService = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
    // Android/iOS client IDs are read automatically from
    // google-services.json / GoogleService-Info.plist — only the web
    // client is passed explicitly, as serverClientId, for backend
    // verification of the ID token.
    serverClientId:
        '631667238707-5ntoga7mlrq8s7v7878lgj97pb027d9u.apps.googleusercontent.com',
  );

  @override
  Future sendOtp(String email, String type) async {
    final response = await _v2.call(
      UrlConfigV2.sendOtp,
      RequestMethod.post,
      formData: FormData.fromMap({"email": email, "type": type}),
      options: _formOptions,
    );

    return response.data;
  }

  @override
  Future<SuccessResponse> verifyOtp(
      {required String email,
      required String code,
      required String type}) async {
    final response = await _v2.call(
      UrlConfigV2.verifyOtp,
      RequestMethod.post,
      formData: FormData.fromMap({"email": email, "code": code}),
      options: _formOptions,
    );

    return SuccessResponse.fromJson(response.data);
  }

  @override
  Future<bool> isUsernameAvailable(String username) async {
    final response = await _v2.call(
      UrlConfigV2.usernameAvailable,
      RequestMethod.get,
      queryParams: {"username": username},
    );

    return response.data["data"]["available"] == true;
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
      final response = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ]);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthSuccessResponse> oauthSignIn(OauthReqDto data) async {
    var token = await NotificationService().deviceToken;

    try {
      final response = await _v2.call(
        UrlConfigV2.oauthLogin,
        RequestMethod.post,
        formData: FormData.fromMap(
          data.copyWith(fcmToken: token).toJson()
            ..removeWhere((key, value) => value == null),
        ),
        options: _formOptions,
      );

      return AuthSuccessResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<AuthSuccessResponse> login(String input, String password) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.login,
        RequestMethod.post,
        formData: FormData.fromMap({
          "input": input,
          "password": password,
          "fcm_token": await NotificationService().deviceToken,
        }),
        options: _formOptions,
      );

      final authResponse = AuthSuccessResponse.fromJson(response.data);
      SessionManager.instance.isTherapistAccount =
          authResponse.data.business?.isTherapist ?? false;
      return authResponse;
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<AuthSuccessResponse> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String username,
    required String password,
    int? countryId,
    String? gender,
    DateTime? dateOfBirth,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.register,
        RequestMethod.post,
        formData: FormData.fromMap({
          "full_name": fullName,
          "email": email,
          "phone_number": phoneNumber,
          "username": username,
          "password": password,
          if (countryId != null) "country_id": countryId,
          if (gender != null) "gender": gender,
          if (dateOfBirth != null)
            "date_of_birth": DateFormat('yyyy-MM-dd').format(dateOfBirth),
        }),
        options: _formOptions,
      );

      return AuthSuccessResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);

      rethrow;
    }
  }

  @override
  Future<AuthSuccessResponse> registerTherapist({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.registerTherapist,
        RequestMethod.post,
        formData: FormData.fromMap({
          "full_name": fullName,
          "email": email,
          "phone_number": phoneNumber,
          "password": password,
          "password_confirmation": passwordConfirmation,
        }),
        options: _formOptions,
      );

      final authResponse = AuthSuccessResponse.fromJson(response.data);
      SessionManager.instance.isTherapistAccount = true;
      return authResponse;
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<dynamic> forgotPassword(String email) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.forgotPassword,
        RequestMethod.post,
        formData: FormData.fromMap({"email": email}),
        options: _formOptions,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> passwordReset(
      String code, String password, String passwordConfirmation) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.passwordReset,
        RequestMethod.post,
        formData: FormData.fromMap({
          "code": code,
          "password": password,
          "password_confirmation": passwordConfirmation,
        }),
        options: _formOptions,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> logout({required bool allDevices}) async {
    final response = await _v2.call(
      UrlConfigV2.logout,
      RequestMethod.post,
      data: {"all_devices": allDevices},
    );

    return response.data;
  }
}
