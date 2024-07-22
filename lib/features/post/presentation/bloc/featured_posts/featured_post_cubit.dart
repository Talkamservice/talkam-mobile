import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'featured_post_state.dart';

part 'featured_post_cubit.freezed.dart';

class FeaturedPostCubit extends Cubit<FeaturedPostState> {
  final PostRepository postRepository;

  var curentPage = 1;

  FeaturedPostCubit(this.postRepository)
      : super(const FeaturedPostState.initial());

  void getFeaturedPosts(PostFilterModel filter, {bool? reload}) async {
    if (reload ?? true) {
      emit(const FeaturedPostState.getFeaturedPostsLoading());
    }
    try {
      final response = await postRepository.getPosts(filter);
      emit(FeaturedPostState.getFeaturedPostsSuccess(response));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(FeaturedPostState.getFeaturedPostsFailed(error.toString()));
    }
  }

  void loadMore() async {
    // try {
    //   if (state is PostLoadingMoreState || _hasReachedEndOfList) return;
    //   emit(const PostState.loadingMoreEvents());
    //   _perPage += 1;
    //   final PalynxUser? palynxUser = SessionManager.instance.palynxUser;
    //   assert(palynxUser != null);
    //   final List<PalynxEvent> paginatedEvents =
    //   await _userEventsService.getCreatorsEventAndEventUserIsAttending(
    //       creatorId: palynxUser!.id, page: _perPage);
    //   _hasReachedEndOfList = paginatedEvents.isEmpty;
    //   emit(PostState.fetchEventsLoadedState(initialEvents + paginatedEvents));
    // } catch (exception) {
    //   _perPage -= 1;
    //   emit(PostState.fetchEventsLoadedState(initialEvents));
    // }

    emit(const FeaturedPostState.loadingMore());
    try {
      final response = await postRepository.getPosts(PostFilterModel());
      emit(FeaturedPostState.getFeaturedPostsSuccess(response));
    } catch (error) {
      emit(FeaturedPostState.getFeaturedPostsFailed(error.toString()));
    }
  }
}
