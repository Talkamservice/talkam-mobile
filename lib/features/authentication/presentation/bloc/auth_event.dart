part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class GoogleAuthEvent extends AuthEvent {
  const GoogleAuthEvent();

  @override
  List<Object?> get props => [];
}

class AppleAuthEvent extends AuthEvent {
  const AppleAuthEvent();

  @override
  List<Object?> get props => [];
}

class FacebookAuthEvent extends AuthEvent {
  const FacebookAuthEvent();

  @override
  List<Object?> get props => [];
}

class TikTokAuthEvent extends AuthEvent {
  const TikTokAuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String username;
  final String password;
  final int? countryId;
  final String? gender;
  final DateTime? dateOfBirth;

  const RegisterEvent({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.username,
    required this.password,
    this.countryId,
    this.gender,
    this.dateOfBirth,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        phoneNumber,
        username,
        password,
        countryId,
        gender,
        dateOfBirth,
      ];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent(this.email);

  @override
  List<Object> get props => [email];
}

class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String code;
  final String type;

  const VerifyOtpEvent(
      {required this.email, required this.code, required this.type});

  @override
  List<Object> get props => [email];
}

class PasswordResetEvent extends AuthEvent {
  final String code;
  final String password;
  final String passwordConfirmation;

  const PasswordResetEvent(this.code, this.password, this.passwordConfirmation);

  @override
  List<Object> get props => [code, password, passwordConfirmation];
}

class UploadAvatarEvent extends AuthEvent {
  final String filePath;

  const UploadAvatarEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class SendOtpEvent extends AuthEvent {
  final String email;
  final String type;

  const SendOtpEvent(this.email, this.type);

  @override
  List<Object> get props => [email];
}

class UpdateProfileEvent extends AuthEvent {
  final Map<String, dynamic> payload;

  const UpdateProfileEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

/// Invalidates the session server-side (best-effort) and clears it locally.
class LogoutEvent extends AuthEvent {
  final bool allDevices;

  const LogoutEvent({this.allDevices = false});

  @override
  List<Object> get props => [allDevices];
}
