import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';

part 'group_follow_state.dart';

part 'group_follow_cubit.freezed.dart';

/// Screen/widget-scoped cubit for the group follow toggle — a lighter
/// relationship than membership (Follow != Join). Registered as a factory so
/// each [FollowGroupButton] usage gets its own instance.
class GroupFollowCubit extends Cubit<GroupFollowState> {
  final GroupsRepository _groupsRepository;

  GroupFollowCubit(this._groupsRepository)
      : super(const GroupFollowState.initial());

  Future<void> toggleFollow(String groupId) async {
    emit(const GroupFollowState.loading());
    try {
      final following = await _groupsRepository.toggleFollowGroup(groupId);
      emit(GroupFollowState.success(following));
      // Keep the shared GroupsCubit singleton (the sidebar's "Groups" list,
      // prefetched once on HomeScreen launch) in sync with this toggle
      // instead of leaving it stale until the next app launch.
      injector
          .get<GroupsCubit>()
          .getGroups(isFollowing: true, shouldRefresh: false);
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(GroupFollowState.failure(error.toString()));
    }
  }
}
