import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'trending_post_state.dart';

part 'trending_post_cubit.freezed.dart';

class TrendingPostCubit extends Cubit<TrendingPostState> {
  final PostRepository postRepository;

  TrendingPostCubit(this.postRepository) : super(const TrendingPostState.initial());

  void getTrendingPosts(PostFilterModel filter, {bool? reload}) async {
    if (reload ?? true) {
      emit(const TrendingPostState.getTrendingPostsLoading());
    }
    try {
      final response = await postRepository.getPosts(filter);
      emit(TrendingPostState.getTrendingPostsSuccess(response));
    } catch (error) {
      emit(TrendingPostState.getTrendingPostsFailed(error.toString()));
    }
  }

  void loadMore(GetPostsResponse previousPosts) async {
    // emit(const RecentPostState.loadingMore());
    try {
      final response = await postRepository.getPosts(PostFilterModel(page: previousPosts.data.paginationMeta.currentPage + 1,tab: "trending"));

      var updated = response.copyWith(data: response.data.copyWith(data: [...previousPosts.data.data, ...response.data.data]));

      emit(TrendingPostState.getTrendingPostsSuccess(updated));
    } catch (error) {
      emit(TrendingPostState.getTrendingPostsFailed(error.toString()));
    }
  }
}
