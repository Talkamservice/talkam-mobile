import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/authentication/data/models/oauth_req_dto.dart';
import 'package:talkam/features/authentication/data/models/auth_response.dart';
import 'package:talkam/features/authentication/dormain/repository/auth_repository.dart';
import 'package:talkam/features/authentication/dormain/usecase/auth_success_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<GoogleAuthEvent>(_mapGoogleAuthEventToState);
    on<AppleAuthEvent>(_mapAppleAuthEventToState);
    on<FacebookAuthEvent>(_mapFacebookAuthEventToState);
    on<TikTokAuthEvent>(_mapTikTokAuthEventToState);
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<PasswordResetEvent>(_onPasswordReset);
    on<SendOtpEvent>(_onSendOtpEvent);
  }

  FutureOr<void> _mapGoogleAuthEventToState(
      GoogleAuthEvent event, Emitter<AuthState> emit) async {
    emit(OauthLoadingState());

    try {
      final response = await _authRepository.googleAuth();
      if (response == null) {
        emit(const OauthFailureState(error: "Google Authentication canceled"));
        return;
      }
      var res = await _authRepository.oauthSignIn(OauthReqDto(
        token: response?.accessToken,
        provider: 'google',
      ));

      AuthSuccessUsecase().execute(res);
      emit(OauthSuccessState(res));
    } catch (e) {
      emit(OauthFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapAppleAuthEventToState(
      AppleAuthEvent event, Emitter<AuthState> emit) async {
    emit(OauthLoadingState());

    try {
      final response = await _authRepository.appleAuth();

      if (response == null) {
        emit(const OauthFailureState(error: "Apple Authentication canceled"));
        return;
      }

      var res = await _authRepository.oauthSignIn(OauthReqDto(
        token: response?.identityToken,
        provider: 'apple',
      ));

      AuthSuccessUsecase().execute(res);

      emit(OauthSuccessState(res));
    } catch (e) {
      logger.e(e);
      emit(OauthFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapFacebookAuthEventToState(
      FacebookAuthEvent event, Emitter<AuthState> emit) async {
    emit(OauthLoadingState());

    try {
      final response = await _authRepository.facebookAuth();
      if (response == null) {
        emit(
            const OauthFailureState(error: "Facebook Authentication canceled"));
        return;
      }
      var res = await _authRepository.oauthSignIn(OauthReqDto(
        token: response?.tokenString,
        provider: 'facebook',
      ));
      AuthSuccessUsecase().execute(res);
      emit(OauthSuccessState(res));
    } catch (e) {
      emit(OauthFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapTikTokAuthEventToState(
      TikTokAuthEvent event, Emitter<AuthState> emit) async {
    emit(OauthLoadingState());

    try {
      final response = await _authRepository.tikTokAuth();

      if (response == null) {
        emit(const OauthFailureState(error: "Tiktok Authentication canceled"));
        return;
      }
      logger.w(response.toString());

      var res = await _authRepository.oauthSignIn(OauthReqDto(
        token: response,
        provider: 'tiktok',
      ));

      AuthSuccessUsecase().execute(res);
      emit(OauthSuccessState(res));
    } catch (e) {
      emit(OauthFailureState(error: e.toString()));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.login(event.email, event.password);
      AuthSuccessUsecase().execute(response);
      emit(LoginSuccess(response));
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response =
          await _authRepository.register(event.email, event.password);
      AuthSuccessUsecase().execute(response);
      emit(RegisterSuccess(response));
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }

  Future<void> _onForgotPassword(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.forgotPassword(event.email);
      emit(ForgotPasswordSuccess(response));
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }

  Future<void> _onPasswordReset(
      PasswordResetEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response =
          await _authRepository.passwordReset(event.code, event.password);
      emit(PasswordResetSuccess(response));
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }

  FutureOr<void> _onVerifyOtpEvent(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.verifyOtp(
          code: event.code, email: event.email, type: event.type);
      emit(VerifyOtpSuccessState(response));
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }

  FutureOr<void> _onSendOtpEvent(
      SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.sendOtp(event.email, event.type);
      emit(OtpSentState(response));
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }
}
