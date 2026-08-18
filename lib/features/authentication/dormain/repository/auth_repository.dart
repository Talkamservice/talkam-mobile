import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class AuthRepository {
  Future sendOtp(String email, String type);

  Future verifyOtp(
      {required String email, required String code, required String type});

  Future<GoogleSignInAuthentication?> googleAuth();

  Future<String?> tikTokAuth();

  Future<AuthorizationCredentialAppleID?> appleAuth();

  Future<AccessToken?> facebookAuth();

  Future<AuthSuccessResponse> oauthSignIn(OauthReqDto data);

  Future<AuthSuccessResponse> login(String input, String password);

  Future<AuthSuccessResponse> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String username,
    required String password,
    int? countryId,
    String? gender,
    DateTime? dateOfBirth,
  });

  Future<AuthSuccessResponse> registerTherapist({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String passwordConfirmation,
  });

  Future<dynamic> forgotPassword(String email);

  Future<dynamic> passwordReset(
      String code, String password, String passwordConfirmation);

  Future<bool> isUsernameAvailable(String username);

  /// Invalidates the current session's token server-side. [allDevices]
  /// requests logging out every session for this account, not just this one.
  Future<dynamic> logout({required bool allDevices});
}
