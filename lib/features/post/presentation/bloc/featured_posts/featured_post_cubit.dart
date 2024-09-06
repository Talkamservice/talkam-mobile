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

  FeaturedPostCubit(this.postRepository) : super(const FeaturedPostState.initial());

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

  void loadMore(GetPostsResponse previousPosts) async {
    // emit(const RecentPostState.loadingMore());

    try {
      final response = await postRepository.getPosts(PostFilterModel(page: previousPosts.data.paginationMeta.currentPage + 1, tab: "featured"));

      var updated = response.copyWith(data: response.data.copyWith(data: [...previousPosts.data.data, ...response.data.data]));

      emit(FeaturedPostState.getFeaturedPostsSuccess(updated));
    } catch (error) {
      emit(FeaturedPostState.getFeaturedPostsFailed(error.toString()));
    }
  }
}
