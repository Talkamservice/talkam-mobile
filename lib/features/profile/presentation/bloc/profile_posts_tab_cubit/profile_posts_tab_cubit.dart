import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'profile_posts_tab_state.dart';

part 'profile_posts_tab_cubit.freezed.dart';

class ProfilePostsTabCubit extends Cubit<ProfilePostsTabState> {
  final ProfileRepository _profileRepository;
  int _currentPage = 1;
  bool _hasReachedEndOfList = false;

  ProfilePostsTabCubit(this._profileRepository) : super(const ProfilePostsTabState.initial());

  Future<void> fetchUserPosts() async {
    emit(const ProfilePostsTabState.loading());
    try {
      final List<TalkamPost> userPosts = await _profileRepository.fetchUserPosts(page: _currentPage);
      emit(ProfilePostsTabState.loaded(userPosts));
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      emit(const ProfilePostsTabState.error());
    }
  }

  Future<void> loadMorePosts(List<TalkamPost> previousPosts) async {
    if (_hasReachedEndOfList || state is ProfilePostsTabLoadingMoreState) return;
    emit(const ProfilePostsTabState.loadingMore());
    try {
      _currentPage += 1;
      final List<TalkamPost> newUserPosts =
          await _profileRepository.fetchUserPosts(page: _currentPage, isPaginating: true);
      _hasReachedEndOfList = newUserPosts.isEmpty;
      emit(ProfilePostsTabState.loaded([...previousPosts, ...newUserPosts]));
    } catch (exception, stackTrace) {
      _currentPage -= 1;
      logger.e(exception, stackTrace: stackTrace);
      emit(ProfilePostsTabState.loaded(previousPosts));
    }
  }
}
