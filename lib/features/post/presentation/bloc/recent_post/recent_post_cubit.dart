import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'recent_post_state.dart';

part 'recent_post_cubit.freezed.dart';

class RecentPostCubit extends Cubit<RecentPostState> {
  final PostRepository postRepository;

  RecentPostCubit(this.postRepository) : super(const RecentPostState.initial());

  void getRecentPosts(PostFilterModel filter, {bool? reload}) async {
    if (reload ?? true) {
      emit(const RecentPostState.getRecentPostsLoading());
    }
    try {
      final response = await postRepository.getPosts(filter);
      emit(RecentPostState.getRecentPostsSuccess(response));
    } catch (error) {
      emit(RecentPostState.getRecentPostsFailed(error.toString()));
    }
  }

  void loadMore(GetPostsResponse previousPosts) async {
    // emit(const RecentPostState.loadingMore());


    try {
      final response = await postRepository.getPosts(PostFilterModel(page: previousPosts.data.paginationMeta.currentPage+1,tab: "latest"));

    var updated =  response.copyWith(data: response.data.copyWith(data: [...previousPosts.data.data, ...response.data.data]));


      emit(RecentPostState.getRecentPostsSuccess(updated));
    } catch (error) {
      emit(RecentPostState.getRecentPostsFailed(error.toString()));
    }
  }
}
