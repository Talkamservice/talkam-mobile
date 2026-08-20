part of 'therapist_client_cubit.dart';

enum LoadStatus { idle, loading, success, error }

class TherapistClientState {
  const TherapistClientState({
    this.clientsStatus = LoadStatus.idle,
    this.clients = const [],
    this.clientsError,
    this.detailStatus = LoadStatus.idle,
    this.detail,
    this.detailError,
    this.savingPlan = false,
    this.planError,
    this.noteStatus = LoadStatus.idle,
    this.note,
    this.noteError,
    this.savingNote = false,
    this.saveNoteError,
  });

  final LoadStatus clientsStatus;
  final List<TherapistClientListItem> clients;
  final String? clientsError;

  final LoadStatus detailStatus;
  final TherapistClientDetail? detail;
  final String? detailError;

  final bool savingPlan;
  final String? planError;

  final LoadStatus noteStatus;
  final SessionNote? note;
  final String? noteError;

  final bool savingNote;
  final String? saveNoteError;

  TherapistClientState copyWith({
    LoadStatus? clientsStatus,
    List<TherapistClientListItem>? clients,
    String? clientsError,
    LoadStatus? detailStatus,
    TherapistClientDetail? detail,
    String? detailError,
    bool? savingPlan,
    String? planError,
    LoadStatus? noteStatus,
    SessionNote? note,
    String? noteError,
    bool? savingNote,
    String? saveNoteError,
  }) =>
      TherapistClientState(
        clientsStatus: clientsStatus ?? this.clientsStatus,
        clients: clients ?? this.clients,
        clientsError: clientsError,
        detailStatus: detailStatus ?? this.detailStatus,
        detail: detail ?? this.detail,
        detailError: detailError,
        savingPlan: savingPlan ?? this.savingPlan,
        planError: planError,
        noteStatus: noteStatus ?? this.noteStatus,
        note: note ?? this.note,
        noteError: noteError,
        savingNote: savingNote ?? this.savingNote,
        saveNoteError: saveNoteError,
      );
}
