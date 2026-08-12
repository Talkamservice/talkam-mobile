part of 'connections_summary_cubit.dart';

@freezed
class ConnectionsSummaryState with _$ConnectionsSummaryState {
  const factory ConnectionsSummaryState.initial() = _ConnectionsSummaryInitial;

  const factory ConnectionsSummaryState.loading() = ConnectionsSummaryLoading;

  const factory ConnectionsSummaryState.success({
    required int followingCount,
    required int followersCount,
  }) = ConnectionsSummarySuccess;

  const factory ConnectionsSummaryState.failure(String error) =
      ConnectionsSummaryFailure;
}
