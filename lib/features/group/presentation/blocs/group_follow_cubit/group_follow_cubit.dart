import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/dormain/mixins/refresh_groups_mixin.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';

part 'group_follow_state.dart';

part 'group_follow_cubit.freezed.dart';

/// Screen/widget-scoped cubit for the group follow toggle — a lighter
/// relationship than membership (Follow != Join). Registered as a factory so
/// each [FollowGroupButton] usage gets its own instance.
class GroupFollowCubit extends Cubit<GroupFollowState> with RefreshGroupsMixin {
  final GroupsRepository _groupsRepository;

  GroupFollowCubit(this._groupsRepository)
      : super(const GroupFollowState.initial());

  Future<void> toggleFollow(String groupId) async {
    emit(const GroupFollowState.loading());
    try {
      final following = await _groupsRepository.toggleFollowGroup(groupId);
      emit(GroupFollowState.success(following));
      refreshAllGroupLists();
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(GroupFollowState.failure(error.toString()));
    }
  }
}
