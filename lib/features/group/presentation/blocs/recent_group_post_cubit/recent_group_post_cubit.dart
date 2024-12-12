import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/post/data/models/post_filter_model.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

part 'recent_group_post_state.dart';

part 'recent_group_post_cubit.freezed.dart';

class RecentGroupPostCubit extends Cubit<RecentGroupPostState> {
  RecentGroupPostCubit(this.postRepository, this.groupRepository) : super(const RecentGroupPostState.initial());

  final PostRepository postRepository;
  final GroupsRepository groupRepository;

  void getRecentPosts({bool? reload}) async {
    if (reload ?? true) {
      emit(const RecentGroupPostState.getRecentPostsLoading());
    }
    try {
      final postResponse = await postRepository.getPosts(PostFilterModel.recentPost(isGroup: true));
      final groupResponse = await groupRepository.getPromotedGroups();

      // Merge posts and groups
      final mergedData = _mergePostsAndGroups(postResponse.data.data, groupResponse.groups??[]);

      emit(RecentGroupPostState.getRecentPostsSuccess(mergedData));
    } catch (error) {
      emit(RecentGroupPostState.getRecentPostsFailed(error.toString()));
    }
  }

  void loadMore() async {
    emit(const RecentGroupPostState.loadingMore());
    try {
      final postResponse = await postRepository.getPosts(PostFilterModel());
      // emit(RecentGroupPostState.getRecentPostsSuccess(postResponse));
    } catch (error) {
      emit(RecentGroupPostState.getRecentPostsFailed(error.toString()));
    }
  }

  List<dynamic> _mergePostsAndGroups(List<TalkamPost> posts, List<TalkamGroup> groups) {
    final List<dynamic> mergedData = [];
    int groupIndex = 0;

    for (int i = 0; i < posts.length; i++) {
      mergedData.add(posts[i]);

      // Add a group after every 5 posts
      if ((i + 1) % 5 == 0 && groupIndex < groups.length) {
        mergedData.add(groups[groupIndex]);
        groupIndex++;
      }
    }

    // Add remaining groups if posts are exhausted
    while (groupIndex < groups.length) {
      mergedData.add(groups[groupIndex]);
      groupIndex++;
    }

    return mergedData;
  }
}
