import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/create_post_payload.dart';
import 'package:talkam/features/post/data/models/create_post_response.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/post/data/models/get_guidlines_response.dart';
import 'package:talkam/features/post/data/models/get_polls_response.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_details_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'post_event.dart';

part 'post_state.dart';

part 'post_bloc.freezed.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  List<TalkamGuidelineModel> rules = [];

  PostBloc(this._postRepository) : super(const PostState.initial()) {
    on<PostEvent>((event, emit) async {
      await event.map(
        getGuidelines: (e) async =>
            await _mapGetGuideLinesEventToState(emit, e),
        getCategories: (e) async =>
            await _mapGetCategoriesEventToState(emit, e),
        getPosts: (e) async => await _mapGetPostsEventToState(emit),
        createPost: (e) async =>
            await _mapCreatePostEventToState(e.postData, emit),
        getPostDetails: (e) async =>
            await _mapGetPostDetailsEventToState(e.postId, emit),
        deletePost: (e) async =>
            await _mapDeletePostEventToState(e.postId, emit),
        postReaction: (e) async =>
            await _mapPostReactionEventToState(e.postId, e.action, emit),
        reportPost: (e) async =>
            await _mapReportPostEventToState(e.postId, e.reason, emit),
        reportComment: (e) async => await _mapReportCommentEventToState(
            e.postId, e.commentId, e.reason, emit),
        getPolls: (e) async => await _mapGetPollsEventToState(emit),
        getComments: (e) async =>
            await _mapGetCommentsEventToState(e.postId, emit),
        getAComment: (e) async =>
            await _mapGetACommentEventToState(e.commentId, emit),
        saveAComment: (e) async =>
            await _mapSaveACommentEventToState(e.payload, emit),
        deleteComment: (e) async =>
            await _mapDeleteCommentEventToState(e.commentId, emit),
        commentReaction: (e) async =>
            await _mapCommentReactionEventToState(e.commentId, e.action, emit),
      );
    });
  }

  Future<void> _mapGetCategoriesEventToState(
      Emitter<PostState> emit, _GetCategoriesEvent e) async {
    emit(const PostState.getCategoriesLoading());
    try {
      final response =
          await _postRepository.getCategories(categoryId: e.categoryId);

      emit(PostState.getCategoriesSuccess(response));
    } catch (error) {
      emit(PostState.getCategoriesFailure(error.toString()));
    }
  }

  Future<void> _mapGetPostsEventToState(Emitter<PostState> emit) async {
    emit(const PostState.getPostsLoading());
    try {
      final response = await _postRepository.getPosts(PostFilterModel.all());
      emit(PostState.getPostsSuccess(response));
    } catch (error) {
      emit(PostState.getPostsFailure(error.toString()));
    }
  }

  Future<void> _mapCreatePostEventToState(
      CreatePostPayload postData, Emitter<PostState> emit) async {
    emit(const PostState.createPostLoading());
    try {
      final response = await _postRepository.createPost(postData);
      emit(PostState.createPostSuccess(response));
    } catch (error) {
      emit(PostState.createPostFailure(error.toString()));
    }
  }

  Future<void> _mapGetPostDetailsEventToState(
      String postId, Emitter<PostState> emit) async {
    emit(const PostState.getPostDetailsLoading());
    try {
      final response = await _postRepository.getPostDetails(postId);

      emit(PostState.getPostDetailsSuccess(response));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(PostState.getPostDetailsFailure(error.toString()));
    }
  }

  Future<void> _mapDeletePostEventToState(
      String postId, Emitter<PostState> emit) async {
    emit(const PostState.deletePostLoading());
    try {
      await _postRepository.deletePost(postId);
      emit(const PostState.deletePostSuccess());
    } catch (error) {
      emit(PostState.deletePostFailure(error.toString()));
    }
  }

  Future<void> _mapPostReactionEventToState(
      String postId, String action, Emitter<PostState> emit) async {
    emit(const PostState.postReactionLoading());
    try {
      await _postRepository.postReaction(postId, action);
      emit(const PostState.postReactionSuccess());
    } catch (error) {
      emit(PostState.postReactionFailure(error.toString()));
    }
  }

  Future<void> _mapReportPostEventToState(
      String postId, String reason, Emitter<PostState> emit) async {
    emit(const PostState.reportPostLoading());
    try {
      await _postRepository.reportPost(postId, reason);
      emit(const PostState.reportPostSuccess());
    } catch (error) {
      emit(PostState.reportPostFailure(error.toString()));
    }
  }

  Future<void> _mapReportCommentEventToState(String postId, String commentId,
      String reason, Emitter<PostState> emit) async {
    emit(const PostState.reportCommentLoading());
    try {
      await _postRepository.reportComment(postId, commentId, reason);
      emit(const PostState.reportCommentSuccess());
    } catch (error) {
      emit(PostState.reportCommentFailure(error.toString()));
    }
  }

  Future<void> _mapGetPollsEventToState(Emitter<PostState> emit) async {
    emit(const PostState.getPollsLoading());
    try {
      final response = await _postRepository.getPolls();
      emit(PostState.getPollsSuccess(response));
    } catch (error) {
      emit(PostState.getPollsFailure(error.toString()));
    }
  }

  Future<void> _mapGetCommentsEventToState(
      String postId, Emitter<PostState> emit) async {
    emit(const PostState.getCommentsLoading());
    try {
      final response = await _postRepository.getComments(postId);
      emit(PostState.getCommentsSuccess(response));
    } catch (error) {
      emit(PostState.getCommentsFailure(error.toString()));
    }
  }

  Future<void> _mapGetACommentEventToState(
      String commentId, Emitter<PostState> emit) async {
    emit(const PostState.getACommentLoading());
    try {
      final response = await _postRepository.getAComment(commentId);
      emit(PostState.getACommentSuccess(response));
    } catch (error) {
      emit(PostState.getACommentFailure(error.toString()));
    }
  }

  Future<void> _mapSaveACommentEventToState(
      SaveCommentPayload payload, Emitter<PostState> emit) async {
    emit(const PostState.saveACommentLoading());
    try {
      await _postRepository.saveAComment(payload);
      emit(const PostState.saveACommentSuccess());
    } catch (error) {
      emit(PostState.saveACommentFailure(error.toString()));
    }
  }

  Future<void> _mapDeleteCommentEventToState(
      String commentId, Emitter<PostState> emit) async {
    emit(const PostState.deleteCommentLoading());
    try {
      await _postRepository.deleteComment(commentId);
      emit(const PostState.deleteCommentSuccess());
    } catch (error) {
      emit(PostState.deleteCommentFailure(error.toString()));
    }
  }

  Future<void> _mapCommentReactionEventToState(
      String commentId, String action, Emitter<PostState> emit) async {
    emit(const PostState.commentReactionLoading());
    try {
      await _postRepository.commentReaction(commentId, action);
      emit(const PostState.commentReactionSuccess());
    } catch (error) {
      emit(PostState.commentReactionFailure(error.toString()));
    }
  }

  _mapGetGuideLinesEventToState(
      Emitter<PostState> emit, _GetGuidelines e) async {
    if (rules.isEmpty) {
      emit(const PostState.getGuidelinesLoading());
    }
    try {
      var response = await _postRepository.getRules();
      rules = response.data;
      emit(PostState.getGuideLinesSuccess(response));
    } catch (error) {
      emit(PostState.getGuideLinesFailed(error.toString()));
    }
  }
}
