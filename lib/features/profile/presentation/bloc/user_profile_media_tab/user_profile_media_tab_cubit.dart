import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/profile/data/models/user_media_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'user_profile_media_tab_state.dart';
part 'user_profile_media_tab_cubit.freezed.dart';

class UserProfileMediaTabCubit extends Cubit<UserProfileMediaTabState> {
  final ProfileRepository _profileRepository;
  int _currentPage = 1;
  bool _hasReachedEndOfList = false;

  UserProfileMediaTabCubit(this._profileRepository)
      : super(const UserProfileMediaTabState.initial());

  Future<void> fetchUserMedia(String userId) async {
    emit(const UserProfileMediaTabState.loading());
    try {
      final List<UserMedia> userPosts =

      await _profileRepository.fetchUserMediaById(page: _currentPage, userId: userId,);
      emit(UserProfileMediaTabState.loaded(userPosts));
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      emit(const UserProfileMediaTabState.error());
    }
  }

  Future<void> loadMorePosts(List<UserMedia> previousPosts,String userId) async {
    if (_hasReachedEndOfList || state is UserProfileMediaTabLoadingMoreState)
      return;
    emit(const UserProfileMediaTabState.loadingMore());

    try {
      _currentPage += 1;
      final List<UserMedia> newUserPosts = await _profileRepository
          .fetchUserMediaById(page: _currentPage, userId: userId,);

      _hasReachedEndOfList = newUserPosts.isEmpty;
      emit(UserProfileMediaTabState.loaded([...previousPosts, ...newUserPosts]));
    } catch (exception, stackTrace) {
      _currentPage -= 1;
      logger.e(exception, stackTrace: stackTrace);
      emit(UserProfileMediaTabState.loaded(previousPosts));
    }
  }
}
