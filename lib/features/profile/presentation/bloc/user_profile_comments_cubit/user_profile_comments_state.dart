part of 'user_profile_comments_cubit.dart';

@freezed
class UserProfileCommentsState with _$UserProfileCommentsState {
  const factory UserProfileCommentsState.initial() = _Initial;

  const factory UserProfileCommentsState.loading() = _Loading;

  const factory UserProfileCommentsState.loaded(List<TalkAmComment> comments) =
      _Loaded;

  const factory UserProfileCommentsState.loadingMore() =
      UserProfileCommentLoadingMoreTabState;



  const factory UserProfileCommentsState.error() = _Error;
}
