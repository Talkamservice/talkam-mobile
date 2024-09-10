part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class SaveUserLocallyEvent extends ProfileEvent {
  final TalkamUser appUser;

  const SaveUserLocallyEvent(this.appUser);

  @override
  List<Object?> get props => [appUser];
}

class GetCachedUserEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class UploadAvatarEvent extends ProfileEvent {
  final String filePath;

  const UploadAvatarEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfilePayload payload;

  const UpdateProfileEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

class GetAvatarsEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class BlockUerEvent extends ProfileEvent {
  final String userId;
  final bool? reload;

  const BlockUerEvent(this.userId, {this.reload = true});

  @override
  List<Object?> get props => [userId,reload];
}

class GetRemoteUser extends ProfileEvent {
  const GetRemoteUser();

  @override
  List<Object?> get props => [];
}

class UpdateInterestEvent extends ProfileEvent {
  final String categoryId;

  const UpdateInterestEvent(this.categoryId);

  @override
  List<Object?> get props => [];
}
