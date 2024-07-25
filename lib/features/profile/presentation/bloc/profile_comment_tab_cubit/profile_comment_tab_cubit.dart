import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/talk_am_comment.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'profile_comment_tab_state.dart';

part 'profile_comment_tab_cubit.freezed.dart';

class ProfileCommentTabCubit extends Cubit<ProfileCommentTabState> {
  final ProfileRepository _profileRepository;
  int _currentPage = 1;
  bool _hasReachedEndOfList = false;

  ProfileCommentTabCubit(this._profileRepository) : super(const ProfileCommentTabState.initial());

  Future<void> fetchUserComments() async {
    emit(const ProfileCommentTabState.loading());
    try {
      final List<TalkAmComment> comments = await _profileRepository.fetchUserComments();
      logger.i("current page is $_currentPage");
      emit(ProfileCommentTabState.loaded(comments));
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      emit(const ProfileCommentTabState.error());
    }
  }

  Future<void> loadMoreComments(List<TalkAmComment> previousPosts) async {
    if (_hasReachedEndOfList || state is ProfileCommentLoadingMoreTabState) return;
    emit(const ProfileCommentTabState.loadingMore());
    try {
      _currentPage += 1;
      final List<TalkAmComment> newComments = await _profileRepository.fetchUserComments();
      _hasReachedEndOfList = newComments.isEmpty;
      emit(ProfileCommentTabState.loaded([...previousPosts, ...newComments]));
    } catch (exception, stackTrace) {
      _currentPage -= 1;
      logger.e(exception, stackTrace: stackTrace);
      emit(ProfileCommentTabState.loaded(previousPosts));
    }
  }
}
