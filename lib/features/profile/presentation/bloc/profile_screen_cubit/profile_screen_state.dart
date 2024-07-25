part of 'profile_screen_cubit.dart';

@freezed
class ProfileScreenState with _$ProfileScreenState {
  const factory ProfileScreenState.initial() = _Initial;

  const factory ProfileScreenState.loading() = _Loading;

  const factory ProfileScreenState.loaded(TalkamUser appUser) = _Loaded;

  const factory ProfileScreenState.error() = _Error;
}
