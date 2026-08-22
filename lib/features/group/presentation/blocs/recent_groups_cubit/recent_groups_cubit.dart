import 'package:bloc/bloc.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

enum LoadStatus { idle, loading, success, error }

class RecentGroupsState {
  const RecentGroupsState({
    this.status = LoadStatus.idle,
    this.groups = const [],
    this.error,
  });

  final LoadStatus status;
  final List<TalkamGroup> groups;
  final String? error;

  RecentGroupsState copyWith({
    LoadStatus? status,
    List<TalkamGroup>? groups,
    String? error,
  }) =>
      RecentGroupsState(
        status: status ?? this.status,
        groups: groups ?? this.groups,
        error: error,
      );
}

/// Drives the Groups "Recent" tab against `GET /user/recents/fetch?sort=
/// group`. Tab-scoped, constructed locally (not GetIt-registered).
class RecentGroupsCubit extends Cubit<RecentGroupsState> {
  final GroupsRepository _repository;

  RecentGroupsCubit(this._repository) : super(const RecentGroupsState());

  Future<void> getRecentGroups() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final groups = await _repository.getRecentGroups();
      emit(state.copyWith(status: LoadStatus.success, groups: groups));
    } catch (e) {
      emit(state.copyWith(
        status: LoadStatus.error,
        error: e is ApiError
            ? (e.errorDescription ?? 'Something went wrong.')
            : 'Something went wrong.',
      ));
    }
  }
}
