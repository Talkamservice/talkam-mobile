part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class OauthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class OauthSuccessState extends AuthState {
  final AuthSuccessResponse response;

  const OauthSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class OauthFailureState extends AuthState {
  final String error;

  const OauthFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class LoginSuccess extends AuthState {
  final AuthSuccessResponse response;

  const LoginSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class RegisterSuccess extends AuthState {
  final AuthSuccessResponse response;

  const RegisterSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class RegisterTherapistSuccess extends AuthState {
  final AuthSuccessResponse response;

  const RegisterTherapistSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class ForgotPasswordSuccess extends AuthState {
  final dynamic response;

  const ForgotPasswordSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class PasswordResetSuccess extends AuthState {
  final Map<String, dynamic> response;

  const PasswordResetSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class UploadAvatarSuccess extends AuthState {
  final Map<String, dynamic> response;

  const UploadAvatarSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class UpdateProfileSuccess extends AuthState {
  final Map<String, dynamic> response;

  const UpdateProfileSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class VerifyOtpSuccessState extends AuthState {
  final dynamic response;

  const VerifyOtpSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class OtpSentState extends AuthState {
  final dynamic response;

  const OtpSentState(this.response);

  @override
  List<Object> get props => [response];
}

/// The session has been cleared, server-side (best-effort) and locally —
/// always emitted regardless of whether the server call succeeded.
class LogoutCompleted extends AuthState {
  @override
  List<Object?> get props => [];
}
