import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'profile_upvotes_state.dart';

part 'profile_upvotes_cubit.freezed.dart';

class ProfileUpvotesCubit extends Cubit<ProfileUpvotesState> {
  final ProfileRepository _profileRepository;
  int _currentPage = 1;
  bool _hasReachedEndOfList = false;

  ProfileUpvotesCubit(this._profileRepository)
      : super(const ProfileUpvotesState.initial());

  Future<void> fetchUserPosts({bool? reload= true}) async {
    if(reload!){
      emit(const ProfileUpvotesState.loading());

    }
    try {
      final List<TalkamPost> userPosts =
          await _profileRepository.fetchUserUpvote(page: _currentPage);
      emit(ProfileUpvotesState.loaded(userPosts));
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      emit( ProfileUpvotesState.error(exception.toString()));
    }
  }

  Future<void> loadMorePosts(List<TalkamPost> previousPosts) async {
    if (_hasReachedEndOfList || state is ProfileUpvotesTabLoadingMoreState)
      return;
    emit(const ProfileUpvotesState.loadingMore());
    try {
      _currentPage += 1;
      final List<TalkamPost> newUserPosts =
          await _profileRepository.fetchUserUpvote(
        page: _currentPage,
      );
      _hasReachedEndOfList = newUserPosts.isEmpty;
      emit(ProfileUpvotesState.loaded([...previousPosts, ...newUserPosts]));
    } catch (exception, stackTrace) {
      _currentPage -= 1;
      logger.e(exception, stackTrace: stackTrace);
      emit(ProfileUpvotesState.loaded(previousPosts));
    }
  }
}
