import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'user_profile_upvotes_state.dart';

part 'user_profile_upvotes_cubit.freezed.dart';

class UserProfileUpvotesCubit extends Cubit<UserProfileUpvotesState> {
  final ProfileRepository _profileRepository;
  int _currentPage = 1;
  bool _hasReachedEndOfList = false;

  UserProfileUpvotesCubit(this._profileRepository) : super(const UserProfileUpvotesState.initial());

  Future<void> fetchUserPosts(String userId, {bool? reload = true}) async {

    if (reload!) {
      emit(const UserProfileUpvotesState.loading());
    }

    try {
      final List<TalkamPost> userPosts = await _profileRepository.fetchUserUpvoteById(page: _currentPage, userId: userId);
      emit(UserProfileUpvotesState.loaded(userPosts));
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      emit(const UserProfileUpvotesState.error());
    }
  }

  Future<void> loadMorePosts(List<TalkamPost> previousPosts) async {
    if (_hasReachedEndOfList || state is UserProfileUpvotesTabLoadingMoreState) return;
    emit(const UserProfileUpvotesState.loadingMore());
    try {
      _currentPage += 1;
      final List<TalkamPost> newUserPosts = await _profileRepository.fetchUserUpvote(
        page: _currentPage,
      );
      _hasReachedEndOfList = newUserPosts.isEmpty;
      emit(UserProfileUpvotesState.loaded([...previousPosts, ...newUserPosts]));
    } catch (exception, stackTrace) {
      _currentPage -= 1;
      logger.e(exception, stackTrace: stackTrace);
      emit(UserProfileUpvotesState.loaded(previousPosts));
    }
  }
}
