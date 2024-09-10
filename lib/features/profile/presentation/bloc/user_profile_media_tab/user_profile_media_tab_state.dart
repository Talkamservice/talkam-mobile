part of 'user_profile_media_tab_cubit.dart';

@freezed
class UserProfileMediaTabState with _$UserProfileMediaTabState {
  const factory UserProfileMediaTabState.initial() = _Initial;



  const factory UserProfileMediaTabState.loading() = _Loading;

  const factory UserProfileMediaTabState.loaded(List<UserMedia> posts) = _Loaded;

  const factory UserProfileMediaTabState.loadingMore() =  UserProfileMediaTabLoadingMoreState;

  const factory UserProfileMediaTabState.error() = _Error;


}

