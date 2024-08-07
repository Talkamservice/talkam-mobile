part of 'profile_upvotes_cubit.dart';

@freezed
class ProfileUpvotesState with _$ProfileUpvotesState{
  const factory ProfileUpvotesState.initial() = _Initial;

  // const factory ProfileUpvotesTabState.initial() = _Initial;

  const factory ProfileUpvotesState.loading() = _Loading;

  const factory ProfileUpvotesState.loaded(List<TalkamPost> posts) = _Loaded;

  const factory ProfileUpvotesState.loadingMore() = ProfileUpvotesTabLoadingMoreState;

  
  const factory ProfileUpvotesState.error(String error) = _Error;
}


