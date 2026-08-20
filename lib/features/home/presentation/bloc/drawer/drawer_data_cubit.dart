import 'package:bloc/bloc.dart';
import 'package:talkam/features/profile/data/models/drawer_response.dart';
import 'package:talkam/features/profile/dormain/repository/profile_repository.dart';

enum DrawerDataStatus { idle, loading, success, error }

class DrawerDataState {
  const DrawerDataState({
    this.status = DrawerDataStatus.idle,
    this.data,
    this.error,
  });

  final DrawerDataStatus status;
  final DrawerResponse? data;
  final String? error;

  DrawerDataState copyWith({
    DrawerDataStatus? status,
    DrawerResponse? data,
    String? error,
  }) =>
      DrawerDataState(
        status: status ?? this.status,
        data: data ?? this.data,
        error: error,
      );
}

/// Backs the side drawer's profile card, follow counts, followed topics,
/// groups, and private groups — all from the one `GET /user/drawer` call.
///
/// GetIt singleton (like `ConnectionsSummaryCubit`/`GroupsCubit`, which this
/// replaces as the drawer's data source): the shell keeps the drawer's
/// branch alive, so a screen-scoped instance would only ever fetch once.
class DrawerDataCubit extends Cubit<DrawerDataState> {
  final ProfileRepository _repository;

  DrawerDataCubit(this._repository) : super(const DrawerDataState());

  /// [silent] skips the loading state so a background refresh (e.g. on
  /// every drawer open) doesn't flash the UI back to empty while it's
  /// already showing the last-known data.
  Future<void> fetch({bool silent = false}) async {
    if (!silent) emit(state.copyWith(status: DrawerDataStatus.loading));
    try {
      final data = await _repository.getDrawer();
      emit(state.copyWith(status: DrawerDataStatus.success, data: data));
    } catch (e) {
      if (!silent) {
        emit(state.copyWith(
            status: DrawerDataStatus.error, error: e.toString()));
      }
    }
  }
}
