part of 'user_profile_cubit.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.initial() = _Initial;




  const factory UserProfileState.profileLoading() = _Loading;

  const factory UserProfileState.profileLoaded(TalkamUser appUser) = _Loaded;

  const factory UserProfileState.getProfileError(String error) = _Error;
}
