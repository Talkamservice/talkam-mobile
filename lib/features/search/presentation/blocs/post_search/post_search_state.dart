part of 'post_search_cubit.dart';

@freezed
class PostSearchState with _$PostSearchState {
  const factory PostSearchState.initial() = _Initial;

  const factory PostSearchState.postSearchLoaded(
      {required List<TalkamPost> postResults, required PostsPaginationData paginationData}) = _PostSearcLoaded;

  const factory PostSearchState.getPostSearchLoading() = _PostSearchLoading;


  const factory PostSearchState.getPostSearchFailed(String error) = _PostSearchFailed;

}
