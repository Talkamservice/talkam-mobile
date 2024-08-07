import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'user_profile_posts_state.dart';

part 'user_profile_posts_cubit.freezed.dart';

class UserProfilePostsCubit extends Cubit<UserProfilePostsState> {
  final ProfileRepository _profileRepository;
  int _currentPage = 1;
  bool _hasReachedEndOfList = false;

  UserProfilePostsCubit(this._profileRepository)
      : super(const UserProfilePostsState.initial());

  Future<void> fetchUserPosts(String userId) async {
    emit(const UserProfilePostsState.loading());
    try {
      final List<TalkamPost> userPosts =
          await _profileRepository.fetchUserPostsById(page: _currentPage,userId: userId);
      emit(UserProfilePostsState.loaded(userPosts));
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      emit(const UserProfilePostsState.error());
    }
  }

  Future<void> loadMorePosts(List<TalkamPost> previousPosts) async {
    if (_hasReachedEndOfList || state is UserProfilePostsTabLoadingMoreState)
      return;
    emit(const UserProfilePostsState.loadingMore());
    try {
      _currentPage += 1;
      final List<TalkamPost> newUserPosts = await _profileRepository
          .fetchUserPosts(page: _currentPage, isPaginating: true);
      _hasReachedEndOfList = newUserPosts.isEmpty;
      emit(UserProfilePostsState.loaded([...previousPosts, ...newUserPosts]));
    } catch (exception, stackTrace) {
      _currentPage -= 1;
      logger.e(exception, stackTrace: stackTrace);
      emit(UserProfilePostsState.loaded(previousPosts));
    }
  }
}
