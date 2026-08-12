part of 'post_bloc.dart';

@freezed
class PostEvent with _$PostEvent {
  const factory PostEvent.getCategoryById({
    String? categoryId,
  }) = _GetCategoryByIdEvent;
  const factory PostEvent.getCategories(
      {String? categoryId,
      bool? refresh,
      bool? mergeGroups}) = _GetCategoriesEvent;
  const factory PostEvent.getSubCategories() = _GetSubCategoriesEvent;
  const factory PostEvent.getInterestTopics() = _GetInterestTopicsEvent;
  const factory PostEvent.getPosts() = _GetPostsEvent;
  const factory PostEvent.createPost(CreatePostPayload postData) =
      _CreatePostEvent;
  const factory PostEvent.getPostDetails(String postId, {bool? refresh}) =
      _GetPostDetailsEvent;
  const factory PostEvent.deletePost(String postId) = _DeletePostEvent;
  const factory PostEvent.postReaction(String postId, String action) =
      _PostReactionEvent;
  const factory PostEvent.reportPost(String postId, String reason) =
      ReportPostEvent;
  const factory PostEvent.reportComment(
      String postId, String commentId, String reason) = ReportCommentEvent;
  const factory PostEvent.getPolls() = _GetPollsEvent;
  const factory PostEvent.getComments(String postId) = _GetCommentsEvent;
  const factory PostEvent.getAComment(String commentId) = _GetACommentEvent;
  const factory PostEvent.saveAComment(SaveCommentPayload payload) =
      _SaveACommentEvent;
  const factory PostEvent.deleteComment(String commentId) = _DeleteCommentEvent;
  const factory PostEvent.commentReaction(String commentId, String action) =
      _CommentReactionEvent;
  const factory PostEvent.getGuidelines() = _GetGuidelines;
  const factory PostEvent.getTrends() = _GetTrends;
  const factory PostEvent.notInterested(String postId) = _NotInterestedEvent;
}
