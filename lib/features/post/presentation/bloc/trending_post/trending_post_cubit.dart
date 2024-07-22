import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'trending_post_state.dart';
part 'trending_post_cubit.freezed.dart';

class TrendingPostCubit extends Cubit<TrendingPostState> {
  final PostRepository postRepository;

  TrendingPostCubit(this.postRepository)
      : super(const TrendingPostState.initial());

  void getTrendingPosts(PostFilterModel filter,{bool? reload}) async {
    if(reload??true){
      emit(const TrendingPostState.getTrendingPostsLoading());

    }
    try {
      final response = await postRepository.getPosts(filter);
      emit(TrendingPostState.getTrendingPostsSuccess(response));
    } catch (error) {
      emit(TrendingPostState.getTrendingPostsFailed(error.toString()));
    }
  }

  void loadMore() async {
    emit(const TrendingPostState.loadingMore());
    try {
      final response = await postRepository.getPosts(PostFilterModel());
      emit(TrendingPostState.getTrendingPostsSuccess(response));
    } catch (error) {
      emit(TrendingPostState.getTrendingPostsFailed(error.toString()));
    }
  }
}
