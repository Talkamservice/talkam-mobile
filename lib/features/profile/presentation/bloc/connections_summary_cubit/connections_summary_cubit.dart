import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'connections_summary_state.dart';

part 'connections_summary_cubit.freezed.dart';

/// App-wide singleton holding the signed-in user's following/followers
/// *counts* (derived from the full list endpoints, since no dedicated count
/// endpoint exists). Fetched once — typically kicked off by [HomeScreen] on
/// launch — and read from wherever the counts are shown (currently the app
/// drawer) without re-fetching on every open.
class ConnectionsSummaryCubit extends Cubit<ConnectionsSummaryState> {
  final ProfileRepository _profileRepository;

  ConnectionsSummaryCubit(this._profileRepository)
      : super(const ConnectionsSummaryState.initial());

  /// No-ops if a fetch already succeeded or is in flight, unless [force].
  Future<void> fetchCounts({bool force = false}) async {
    if (!force &&
        (state is ConnectionsSummaryLoading ||
            state is ConnectionsSummarySuccess)) {
      return;
    }

    emit(const ConnectionsSummaryState.loading());
    try {
      final results = await Future.wait([
        _profileRepository.fetchFollowing(),
        _profileRepository.fetchFollowers(),
      ]);
      emit(ConnectionsSummaryState.success(
        followingCount: results[0].length,
        followersCount: results[1].length,
      ));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(ConnectionsSummaryState.failure(error.toString()));
    }
  }

  /// Refreshes in the background without emitting a loading state, so the
  /// drawer keeps showing the last known counts instead of flashing to 0
  /// while this resolves. Called every time the drawer is opened. Errors are
  /// swallowed — a failed background refresh shouldn't surface anything for
  /// an update the user didn't explicitly ask for; the stale counts just
  /// stay on screen until the next successful refresh.
  Future<void> refreshCountsSilently() async {
    try {
      final results = await Future.wait([
        _profileRepository.fetchFollowing(),
        _profileRepository.fetchFollowers(),
      ]);
      emit(ConnectionsSummaryState.success(
        followingCount: results[0].length,
        followersCount: results[1].length,
      ));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
    }
  }
}
