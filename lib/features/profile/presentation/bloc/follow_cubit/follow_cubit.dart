import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

part 'follow_state.dart';

part 'follow_cubit.freezed.dart';

/// Screen/widget-scoped cubit for the follow/subscribe-to-author toggle —
/// registered as a factory so each `SubscribeButton` usage gets its own
/// instance, matching the per-item pattern used for post reactions.
class FollowCubit extends Cubit<FollowState> {
  final ProfileRepository _profileRepository;

  FollowCubit(this._profileRepository) : super(const FollowState.initial());

  Future<void> toggleFollow(String userId) async {
    emit(const FollowState.loading());
    try {
      final following = await _profileRepository.toggleFollow(userId);
      emit(FollowState.success(following));
    } catch (error, stack) {
      logger.e(error);
      logger.e(stack);
      emit(FollowState.failure(error.toString()));
    }
  }
}
