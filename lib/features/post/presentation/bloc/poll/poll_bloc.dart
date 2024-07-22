// poll_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talkam/features/post/dormain/repository/post_repository.dart';

import '../../../dormain/mixins/refresh_posts_mixin.dart';

part 'poll_event.dart';

part 'poll_state.dart';

part 'poll_bloc.freezed.dart';

class PollBloc extends Bloc<PollEvent, PollState> with RefreshPostsMixin {
  final PostRepository _eFundRepository;

  PollBloc(this._eFundRepository) : super(const PollState.initial()) {
    on<PollEvent>((event, emit) async {
      await event.map(
        selectPoll: (e) async => await _mapSelectPollToState(e.pollId, emit),
        deletePoll: (e) async => await _mapDeletePollToState(e.pollId, emit),
        updatePercentage: (_UpdatePercentage value) {},
        initialEvent: (_InitialEvent value) {},
      );
    });
  }



  Future<void> _mapSelectPollToState(String pollId,
      Emitter<PollState> emit) async {
    emit(const PollState.selectPollLoading());
    try {
      var response = await _eFundRepository.selectPoll(pollId);
      refreshPost(reload: false);
      await Future.delayed(const Duration(seconds: 2));
      emit(PollState.selectPollSuccess(response));
    } catch (e) {
      emit(PollState.selectPollFailure(e.toString()));
    }
  }

  Future<void> _mapDeletePollToState(String pollId,
      Emitter<PollState> emit) async {
    emit(const PollState.deletePollLoading());
    try {
      var response = await _eFundRepository.deletePoll(pollId);
      emit(PollState.deletePollSuccess(response));
    } catch (e) {
      emit(PollState.deletePollFailure(e.toString()));
    }
  }
}
