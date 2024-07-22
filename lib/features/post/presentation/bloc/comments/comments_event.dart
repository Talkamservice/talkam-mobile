part of 'comments_bloc.dart';

@freezed
class CommentsEvent with _$CommentsEvent {
  const factory CommentsEvent.started() = _Started;

  const factory CommentsEvent.selectCommentForReply(PostComment? comment) =
      _SelectCommentEvent;

  const factory CommentsEvent.getComments(String postId,{bool? reload}) = _GetCommentsEvent;

  const factory CommentsEvent.getAComment(String commentId) = _GetACommentEvent;

  const factory CommentsEvent.saveAComment(SaveCommentPayload payload) =
      _SaveACommentEvent;

  const factory CommentsEvent.deleteComment(String commentId) =
      _DeleteCommentEvent;

  const factory CommentsEvent.commentReaction(String commentId, String action) =
      _CommentReactionEvent;
}
