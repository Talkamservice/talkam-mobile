// poll_state.dart
part of 'poll_bloc.dart';

@freezed
class PollState with _$PollState {
  const factory PollState.initial() = _Initial;

  const factory PollState.fetchEFundsLoading() = _FetchEFundsLoading;
  const factory PollState.fetchEFundsSuccess(dynamic response) = _FetchEFundsSuccess;
  const factory PollState.fetchEFundsFailure(String error) = _FetchEFundsFailure;

  const factory PollState.selectPollLoading() = _SelectPollLoading;
  const factory PollState.selectPollSuccess(dynamic response) = _SelectPollSuccess;
  const factory PollState.selectPollFailure(String error) = _SelectPollFailure;

  const factory PollState.deletePollLoading() = _DeletePollLoading;
  const factory PollState.deletePollSuccess(dynamic response) = _DeletePollSuccess;
  const factory PollState.deletePollFailure(String error) = _DeletePollFailure;

  const factory PollState.updatePercentageState() = _UpdatePercentageState;

}
