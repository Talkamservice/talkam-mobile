import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class AuthRepository {
  Future sendOtp(String email, String type);

  Future verifyOtp({required String email, required String code, required String type});

  Future<GoogleSignInAuthentication?> googleAuth();

  Future<String?> tikTokAuth();

  Future<AuthorizationCredentialAppleID?> appleAuth();

  Future<AccessToken?> facebookAuth();

  Future<AuthSuccessResponse> oauthSignIn(OauthReqDto data);

  Future<AuthSuccessResponse> login(String email, String password);

  Future<AuthSuccessResponse> register(String email, String password);

  Future<dynamic> forgotPassword(String email);

  Future<dynamic> passwordReset(String code, String password);
}
