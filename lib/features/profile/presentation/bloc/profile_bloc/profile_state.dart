part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class UserInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class UserCachedState extends ProfileState {
  final TalkamUser user;

  const UserCachedState(this.user);

  @override
  List<Object> get props => [user];
}

class UploadAvatarLoading extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UploadAvatarFailure extends ProfileState {
  final String error;

  const UploadAvatarFailure(this.error);

  @override
  List<Object> get props => [error];
}

class UploadAvatarSuccess extends ProfileState {
  final dynamic response;

  const UploadAvatarSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class UpdateProfileLoading extends ProfileState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UpdateProfileFailure extends ProfileState {
  final String error;

  const UpdateProfileFailure(this.error);

  @override
  List<Object> get props => [error];
}

class UpdateProfileSuccess extends ProfileState {
  final UpdateProfileResponse response;

  const UpdateProfileSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class GetAvatarsLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class GetAvatarsSuccessState extends ProfileState {
  final GetAvatarsResponse response;

  const GetAvatarsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetAvatarsFailureState extends ProfileState {
  final String error;

  const GetAvatarsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class BlockUserLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class BlockUserSuccessState extends ProfileState {
  final BlockUserResponse response;

  const BlockUserSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetProfileSuccessState extends ProfileState {
  final TalkamUser user;

  const GetProfileSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class BlockUserFailureState extends ProfileState {
  final String error;

  const BlockUserFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetProfileFailureState extends ProfileState {
  final String error;

  const GetProfileFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class UpdateInterestFailureState extends ProfileState {
  final String error;

  const UpdateInterestFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdateInterestLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class UpdateInterestSuccessState extends ProfileState {
  final dynamic response;

  const UpdateInterestSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}
