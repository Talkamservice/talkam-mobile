part of 'comments_bloc.dart';

@freezed
class CommentsState with _$CommentsState {
  const factory CommentsState.initial() = _Initial;


  const factory CommentsState.getCommentsLoading() = GetCommentsLoadingState;
  const factory CommentsState.getCommentsSuccess(GetCommentsResponse response) = GetCommentsSuccessState;
  const factory CommentsState.getCommentsFailure(String error) = GetCommentsFailureState;

  const factory CommentsState.getACommentLoading() = GetACommentLoadingState;
  const factory CommentsState.getACommentSuccess(dynamic response) = GetACommentSuccessState;
  const factory CommentsState.getACommentFailure(String error) = GetACommentFailureState;

  const factory CommentsState.saveACommentLoading() = SaveACommentLoadingState;
  const factory CommentsState.saveACommentSuccess() = SaveACommentSuccessState;
  const factory CommentsState.saveACommentFailure(String error) = SaveACommentFailureState;

  const factory CommentsState.deleteCommentLoading() = DeleteCommentLoadingState;
  const factory CommentsState.deleteCommentSuccess() = DeleteCommentSuccessState;
  const factory CommentsState.deleteCommentFailure(String error) = DeleteCommentFailureState;

  const factory CommentsState.commentReactionLoading() = CommentReactionLoadingState;
  const factory CommentsState.commentReactionSuccess() = CommentReactionSuccessState;
  const factory CommentsState.commentReactionFailure(String error) = CommentReactionFailureState;


  const factory CommentsState.commentStaged(PostComment? comment) = CommentStaggedState;
  const factory CommentsState.stagedCommentRemoved() = StaggedCommentRemoved;

}
