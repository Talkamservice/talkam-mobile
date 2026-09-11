import 'package:bloc/bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/resettable_on_logout.dart';
import 'package:talkam/features/group/dormain/repository/group_repository.dart';
import 'package:talkam/features/profile/data/models/drawer_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

enum DrawerDataStatus { idle, loading, success, error }

class DrawerDataState {
  const DrawerDataState({
    this.status = DrawerDataStatus.idle,
    this.data,
    this.error,
    this.joinedGroups = const [],
    this.followedGroups = const [],
  });

  final DrawerDataStatus status;
  final DrawerResponse? data;
  final String? error;

  /// Groups the user is actually a member of — `GET /user/groups/joined`.
  final List<TalkamGroup> joinedGroups;

  /// The lighter follow relationship, not membership — `GET
  /// /user/groups/members/following` (Follow != Join).
  final List<TalkamGroup> followedGroups;

  DrawerDataState copyWith({
    DrawerDataStatus? status,
    DrawerResponse? data,
    String? error,
    List<TalkamGroup>? joinedGroups,
    List<TalkamGroup>? followedGroups,
  }) =>
      DrawerDataState(
        status: status ?? this.status,
        data: data ?? this.data,
        error: error,
        joinedGroups: joinedGroups ?? this.joinedGroups,
        followedGroups: followedGroups ?? this.followedGroups,
      );
}

/// Backs the side drawer's profile card, follow counts, followed groups,
/// joined groups, and private groups.
///
/// GetIt singleton (like `ConnectionsSummaryCubit`/`GroupsCubit`, which this
/// replaces as the drawer's data source): the shell keeps the drawer's
/// branch alive, so a screen-scoped instance would only ever fetch once.
class DrawerDataCubit extends Cubit<DrawerDataState>
    implements ResettableOnLogout {
  final ProfileRepository _repository;
  final GroupsRepository _groupsRepository;

  DrawerDataCubit(this._repository, this._groupsRepository)
      : super(const DrawerDataState());

  @override
  void resetForLogout() => emit(const DrawerDataState());

  /// [silent] skips the loading state so a background refresh (e.g. on
  /// every drawer open, or right after a follow/join/leave elsewhere in the
  /// app) doesn't flash the UI back to empty while it's already showing the
  /// last-known data.
  ///
  /// The three fetches run concurrently and are handled independently — a
  /// transient failure on one of the group lists shouldn't blank the profile
  /// card/counts that loaded fine, and vice versa.
  Future<void> fetch({bool silent = false}) async {
    if (!silent) emit(state.copyWith(status: DrawerDataStatus.loading));

    final drawerFuture = _repository.getDrawer();
    final joinedFuture = _groupsRepository.getJoinedGroups(page: 1);
    final followedFuture = _groupsRepository.getFollowedGroups(page: 1);

    try {
      final data = await drawerFuture;
      emit(state.copyWith(status: DrawerDataStatus.success, data: data));
    } catch (e) {
      if (!silent) {
        emit(state.copyWith(
            status: DrawerDataStatus.error, error: e.toString()));
      }
    }

    try {
      final joined = await joinedFuture;
      emit(state.copyWith(joinedGroups: joined.groups ?? const []));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
    }

    try {
      final followed = await followedFuture;
      emit(state.copyWith(followedGroups: followed.groups ?? const []));
    } catch (e, stack) {
      logger.e(e, stackTrace: stack);
    }
  }
}
