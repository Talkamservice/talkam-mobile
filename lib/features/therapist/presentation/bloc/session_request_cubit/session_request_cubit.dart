import 'package:bloc/bloc.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/features/therapist/data/models/session_request_sheet.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart'
    show LoadStatus;

part 'session_request_state.dart';

/// Drives the session-request bottom sheet reached from a booking-request
/// notification. Screen-scoped: constructed by the sheet itself and closed
/// when it's dismissed, matching the pattern used by other bottom sheets
/// with their own draft/load state in this app.
class SessionRequestCubit extends Cubit<SessionRequestState> {
  final TherapistRepository _repository;

  SessionRequestCubit(this._repository) : super(const SessionRequestState());

  Future<void> load(int sessionId) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final sheet = await _repository.getSessionRequest(sessionId);
      emit(state.copyWith(status: LoadStatus.success, sheet: sheet));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.error, error: _message(e)));
    }
  }

  Future<bool> acknowledge(int sessionId) async {
    emit(state.copyWith(acknowledging: true, clearAcknowledgeError: true));
    try {
      final result = await _repository.acknowledgeSession(sessionId);
      emit(state.copyWith(acknowledging: false, acknowledged: result));
      return true;
    } catch (e) {
      emit(state.copyWith(acknowledging: false, acknowledgeError: _message(e)));
      return false;
    }
  }

  String _message(Object e) => e is ApiError
      ? (e.errorDescription ?? 'Something went wrong. Please try again.')
      : 'Something went wrong. Please try again.';
}
