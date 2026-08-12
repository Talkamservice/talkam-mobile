import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/post/data/models/get_posts_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'connections_state.dart';

part 'connections_cubit.freezed.dart';

/// Screen-scoped cubit backing the Following/Followers tabs — registered as
/// a factory so each tab owns its own instance, matching [FollowCubit] and
/// the other per-item/per-tab cubits in this feature.
class ConnectionsCubit extends Cubit<ConnectionsState> {
  final ProfileRepository _profileRepository;

  ConnectionsCubit(this._profileRepository)
      : super(const ConnectionsState.initial());

  Future<void> fetchFollowing() async {
    emit(const ConnectionsState.loading());
    try {
      final users = await _profileRepository.fetchFollowing();
      emit(ConnectionsState.success(users));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(ConnectionsState.failure(error.toString()));
    }
  }

  Future<void> fetchFollowers() async {
    emit(const ConnectionsState.loading());
    try {
      final users = await _profileRepository.fetchFollowers();
      emit(ConnectionsState.success(users));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(ConnectionsState.failure(error.toString()));
    }
  }
}
