import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

part 'recent_group_post_state.dart';

part 'recent_group_post_cubit.freezed.dart';

class RecentGroupPostCubit extends Cubit<RecentGroupPostState> {
  RecentGroupPostCubit(this.postRepository)
      : super(const RecentGroupPostState.initial());
  final PostRepository postRepository;

  void getRecentPosts({bool? reload}) async {
    if (reload ?? true) {
      emit(const RecentGroupPostState.getRecentPostsLoading());
    }
    try {

      final response = await postRepository
          .getPosts(PostFilterModel.recentPost(isGroup: true));
      emit(RecentGroupPostState.getRecentPostsSuccess(response));
    } catch (error) {
      emit(RecentGroupPostState.getRecentPostsFailed(error.toString()));
    }
  }

  void loadMore() async {
    emit(const RecentGroupPostState.loadingMore());
    try {
      final response = await postRepository.getPosts(PostFilterModel());
      emit(RecentGroupPostState.getRecentPostsSuccess(response));
    } catch (error) {
      emit(RecentGroupPostState.getRecentPostsFailed(error.toString()));
    }
  }
}
