part of 'session_request_cubit.dart';

class SessionRequestState {
  const SessionRequestState({
    this.status = LoadStatus.idle,
    this.sheet,
    this.error,
    this.acknowledging = false,
    this.acknowledgeError,
    this.acknowledged,
  });

  final LoadStatus status;
  final SessionRequestSheet? sheet;
  final String? error;

  final bool acknowledging;
  final String? acknowledgeError;
  final SessionAcknowledgeResult? acknowledged;

  SessionRequestState copyWith({
    LoadStatus? status,
    SessionRequestSheet? sheet,
    String? error,
    bool? acknowledging,
    String? acknowledgeError,
    bool clearAcknowledgeError = false,
    SessionAcknowledgeResult? acknowledged,
  }) =>
      SessionRequestState(
        status: status ?? this.status,
        sheet: sheet ?? this.sheet,
        error: error ?? this.error,
        acknowledging: acknowledging ?? this.acknowledging,
        acknowledgeError: clearAcknowledgeError
            ? null
            : (acknowledgeError ?? this.acknowledgeError),
        acknowledged: acknowledged ?? this.acknowledged,
      );
}
