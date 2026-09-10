import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';

abstract class GroupInviteState extends Equatable {
  const GroupInviteState();

  @override
  List<Object?> get props => [];
}

class GroupInviteIdle extends GroupInviteState {
  const GroupInviteIdle();
}

class InviteToGroupLoading extends GroupInviteState {
  const InviteToGroupLoading();
}

class InviteToGroupSuccess extends GroupInviteState {
  const InviteToGroupSuccess();
}

class InviteToGroupFailure extends GroupInviteState {
  const InviteToGroupFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

class AcceptGroupInviteLoading extends GroupInviteState {
  const AcceptGroupInviteLoading();
}

class AcceptGroupInviteSuccess extends GroupInviteState {
  const AcceptGroupInviteSuccess();
}

class AcceptGroupInviteFailure extends GroupInviteState {
  const AcceptGroupInviteFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

/// Not a freezed union like [GroupsState] — deliberately plain Equatable
/// classes (same shape as MoodCheckCubit's state) so this doesn't need
/// build_runner. Kept as its own small cubit rather than adding variants to
/// GroupsState, since inviting/accepting are one-shot actions from a
/// short-lived sheet/screen, not part of the main groups-list lifecycle.
class GroupInviteCubit extends Cubit<GroupInviteState> {
  GroupInviteCubit(this._groupRepository) : super(const GroupInviteIdle());

  final GroupsRepository _groupRepository;

  Future<void> inviteToGroup(
      {required String groupId, required String email}) async {
    emit(const InviteToGroupLoading());
    try {
      await _groupRepository.inviteToGroup(groupId: groupId, email: email);
      emit(const InviteToGroupSuccess());
    } catch (e) {
      emit(InviteToGroupFailure(e.toString()));
    }
  }

  /// [uuid] identifies the invite itself (from the invite link/notification
  /// once that's wired up), not the group.
  Future<void> acceptGroupInvite(String uuid) async {
    emit(const AcceptGroupInviteLoading());
    try {
      await _groupRepository.acceptGroupInvite(uuid);
      emit(const AcceptGroupInviteSuccess());
    } catch (e) {
      emit(AcceptGroupInviteFailure(e.toString()));
    }
  }
}
