// poll_event.dart
part of 'poll_bloc.dart';

@freezed
class PollEvent with _$PollEvent {
  const factory PollEvent.selectPoll(String pollId) = _SelectPoll;
  const factory PollEvent.deletePoll(String pollId) = _DeletePoll;
  const factory PollEvent.updatePercentage() = _UpdatePercentage;
  const factory PollEvent.initialEvent() = _InitialEvent;
}
