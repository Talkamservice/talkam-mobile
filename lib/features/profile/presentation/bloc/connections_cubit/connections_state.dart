part of 'connections_cubit.dart';

@freezed
class ConnectionsState with _$ConnectionsState {
  const factory ConnectionsState.initial() = _ConnectionsInitial;

  const factory ConnectionsState.loading() = ConnectionsLoading;

  const factory ConnectionsState.success(List<PostCreator> users) =
      ConnectionsSuccess;

  const factory ConnectionsState.failure(String error) = ConnectionsFailure;
}
