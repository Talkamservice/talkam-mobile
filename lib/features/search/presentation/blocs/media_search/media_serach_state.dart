part of 'media_serach_cubit.dart';

@freezed
class MediaSearchState with _$MediaSearchState {

  const factory MediaSearchState.mediaSearchLoaded(

      {required List<TalkamPost> postResults, required PostsPaginationData paginationData}) = _MediaSearcLoaded;

  const factory MediaSearchState.initial() = _MediaInitialState;
  const factory MediaSearchState.getMediaSearchLoading() = _MediaSearchLoading;


  const factory MediaSearchState.getMediaSearchFailed(String error) = _MediaSearchFailed;
}
