import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/save_comment_payload.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

part 'comments_event.dart';

part 'comments_state.dart';

part 'comments_bloc.freezed.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  List<PostComment> comments = [];
  PostComment? stagedComment;

  CommentsBloc(this._postRepository) : super(const CommentsState.initial()) {
    on<CommentsEvent>((event, emit) async {
      await event.map(
        getComments: (e) async => await _mapGetCommentsEventToState(e.postId, emit, reload: e.reload),
        selectCommentForReply: (e) async => await _mapSelectCommentForReplyToState(e.comment, emit),
        getAComment: (e) async => await _mapGetACommentEventToState(e.commentId, emit),
        saveAComment: (e) async => await _mapSaveACommentEventToState(e.payload, emit),
        deleteComment: (e) async => await _mapDeleteCommentEventToState(e.commentId, emit),
        commentReaction: (e) async => await _mapCommentReactionEventToState(e.commentId, e.action, emit),
        started: (_Started value) {},
      );
    });
  }

  final PostRepository _postRepository;

  Future<void> _mapGetCommentsEventToState(String postId, Emitter<CommentsState> emit, {bool? reload = true}) async {
    if (reload ?? true) {
      emit(const CommentsState.getCommentsLoading());
    }
    try {
      final response = await _postRepository.getComments(postId);
      comments = response.data;
      injector.get<ProfileBloc>().add(const GetRemoteUser());
      emit(CommentsState.getCommentsSuccess(response));
    } catch (error) {
      emit(CommentsState.getCommentsFailure(error.toString()));
    }
  }

  Future<void> _mapGetACommentEventToState(String commentId, Emitter<CommentsState> emit) async {
    emit(const CommentsState.getACommentLoading());
    try {
      final response = await _postRepository.getAComment(commentId);
      injector.get<ProfileBloc>().add(const GetRemoteUser());
      emit(CommentsState.getACommentSuccess(response));
    } catch (error) {
      emit(CommentsState.getACommentFailure(error.toString()));
    }
  }

  Future<void> _mapSaveACommentEventToState(SaveCommentPayload payload, Emitter<CommentsState> emit) async {
    emit(const CommentsState.saveACommentLoading());
    try {
      final response = await _postRepository.saveAComment(payload);
      injector.get<ProfileBloc>().add(const GetRemoteUser());
      emit(const CommentsState.saveACommentSuccess());
    } catch (error) {
      emit(CommentsState.saveACommentFailure(error.toString()));
    }
  }

  Future<void> _mapDeleteCommentEventToState(String commentId, Emitter<CommentsState> emit) async {
    emit(const CommentsState.deleteCommentLoading());
    try {
      await _postRepository.deleteComment(commentId);
      injector.get<ProfileBloc>().add(const GetRemoteUser());
      emit(const CommentsState.deleteCommentSuccess());
    } catch (error) {
      emit(CommentsState.deleteCommentFailure(error.toString()));
    }
  }

  Future<void> _mapCommentReactionEventToState(String commentId, String action, Emitter<CommentsState> emit) async {
    emit(const CommentsState.commentReactionLoading());
    try {
      await _postRepository.commentReaction(commentId, action);

      emit(const CommentsState.commentReactionSuccess());
    } catch (error) {
      emit(CommentsState.commentReactionFailure(error.toString()));
    }
  }

  _mapSelectCommentForReplyToState(PostComment? comment, Emitter<CommentsState> emit) async {
    if (comment?.id == stagedComment?.id) {
      stagedComment = null;
      emit(const CommentsState.stagedCommentRemoved());
    } else {
      stagedComment = comment;
    }
    emit(CommentsState.commentStaged(comment));
    emit(const CommentsState.stagedCommentRemoved());
  }
}
