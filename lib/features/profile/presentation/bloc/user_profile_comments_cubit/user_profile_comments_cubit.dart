import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_comments_response.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'user_profile_comments_state.dart';

part 'user_profile_comments_cubit.freezed.dart';

class UserProfileCommentsCubit extends Cubit<UserProfileCommentsState> {
  final ProfileRepository _profileRepository;
  int _currentPage = 1;
  bool _hasReachedEndOfList = false;

  UserProfileCommentsCubit(this._profileRepository)
      : super(const UserProfileCommentsState.initial());

  Future<void> fetchUserComments(String userId) async {
    emit(const UserProfileCommentsState.loading());
    try {
      final List<TalkAmComment> comments =
          await _profileRepository.fetchUserCommentsById(userId);
      emit(UserProfileCommentsState.loaded(comments));
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      emit(const UserProfileCommentsState.error());
    }
  }

  Future<void> loadMoreComments(
      List<TalkAmComment> previousPosts, String userId) async {
    if (_hasReachedEndOfList || state is UserProfileCommentLoadingMoreTabState)
      return;
    emit(const UserProfileCommentsState.loadingMore());
    try {
      _currentPage += 1;
      final List<TalkAmComment> newComments =
          await _profileRepository.fetchUserCommentsById(userId);
      _hasReachedEndOfList = newComments.isEmpty;
      emit(UserProfileCommentsState.loaded([...previousPosts, ...newComments]));
    } catch (exception, stackTrace) {
      _currentPage -= 1;
      logger.e(exception, stackTrace: stackTrace);
      emit(UserProfileCommentsState.loaded(previousPosts));
    }
  }
}
