
part of 'post_bloc.dart';




@freezed
class PostState with _$PostState {
  const factory PostState.initial() = PostInitial;

  const factory PostState.getCategoriesLoading() = GetCategoriesLoadingState;
  const factory PostState.getCategoriesSuccess(GetCategoriesResponse response) = GetCategoriesSuccessState;
  const factory PostState.getCategoriesFailure(String error) = GetCategoriesFailureState;

  const factory PostState.getPostsLoading() = GetPostsLoadingState;
  const factory PostState.getPostsSuccess(GetPostsResponse response) = GetPostsSuccessState;
  const factory PostState.getPostsFailure(String error) = GetPostsFailureState;

  const factory PostState.createPostLoading() = CreatePostLoadingState;
  const factory PostState.createPostSuccess(CreatePostResponse response) = CreatePostSuccessState;
  const factory PostState.createPostFailure(String error) = CreatePostFailureState;

  const factory PostState.getPostDetailsLoading() = GetPostDetailsLoadingState;
  const factory PostState.getPostDetailsSuccess(PostDetailsResponse response) = GetPostDetailsSuccessState;
  const factory PostState.getPostDetailsFailure(String error) = GetPostDetailsFailureState;

  const factory PostState.deletePostLoading() = DeletePostLoadingState;
  const factory PostState.deletePostSuccess() = DeletePostSuccessState;
  const factory PostState.deletePostFailure(String error) = DeletePostFailureState;

  const factory PostState.postReactionLoading() = PostReactionLoadingState;
  const factory PostState.postReactionSuccess() = PostReactionSuccessState;
  const factory PostState.postReactionFailure(String error) = PostReactionFailureState;

  const factory PostState.reportPostLoading() = ReportPostLoadingState;
  const factory PostState.reportPostSuccess() = ReportPostSuccessState;
  const factory PostState.reportPostFailure(String error) = ReportPostFailureState;

  const factory PostState.getPollsLoading() = GetPollsLoadingState;
  const factory PostState.getPollsSuccess(GetPollsResponse response) = GetPollsSuccessState;
  const factory PostState.getPollsFailure(String error) = GetPollsFailureState;

  const factory PostState.getCommentsLoading() = GetCommentsLoadingState;
  const factory PostState.getCommentsSuccess(dynamic response) = GetCommentsSuccessState;
  const factory PostState.getCommentsFailure(String error) = GetCommentsFailureState;

  const factory PostState.getACommentLoading() = GetACommentLoadingState;
  const factory PostState.getACommentSuccess(dynamic response) = GetACommentSuccessState;
  const factory PostState.getACommentFailure(String error) = GetACommentFailureState;

  const factory PostState.saveACommentLoading() = SaveACommentLoadingState;
  const factory PostState.saveACommentSuccess() = SaveACommentSuccessState;
  const factory PostState.saveACommentFailure(String error) = SaveACommentFailureState;

  const factory PostState.deleteCommentLoading() = DeleteCommentLoadingState;
  const factory PostState.deleteCommentSuccess() = DeleteCommentSuccessState;
  const factory PostState.deleteCommentFailure(String error) = DeleteCommentFailureState;

  const factory PostState.commentReactionLoading() = CommentReactionLoadingState;
  const factory PostState.commentReactionSuccess() = CommentReactionSuccessState;
  const factory PostState.commentReactionFailure(String error) = CommentReactionFailureState;
}

