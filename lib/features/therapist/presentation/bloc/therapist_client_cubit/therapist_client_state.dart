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
    this.sessionsStatus = LoadStatus.idle,
    this.upcomingSessions = const [],
    this.pastSessions = const [],
    this.sessionsError,
    this.notesLibraryStatus = LoadStatus.idle,
    this.notesLibrary = const [],
    this.notesLibraryCanLoadMore = false,
    this.notesLibraryPage = 1,
    this.notesLibraryError,
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

  final LoadStatus sessionsStatus;
  final List<TherapistSessionItem> upcomingSessions;
  final List<TherapistSessionItem> pastSessions;
  final String? sessionsError;

  final LoadStatus notesLibraryStatus;
  final List<TherapistNoteLibraryItem> notesLibrary;
  final bool notesLibraryCanLoadMore;
  final int notesLibraryPage;
  final String? notesLibraryError;

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
    LoadStatus? sessionsStatus,
    List<TherapistSessionItem>? upcomingSessions,
    List<TherapistSessionItem>? pastSessions,
    String? sessionsError,
    LoadStatus? notesLibraryStatus,
    List<TherapistNoteLibraryItem>? notesLibrary,
    bool? notesLibraryCanLoadMore,
    int? notesLibraryPage,
    String? notesLibraryError,
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
        sessionsStatus: sessionsStatus ?? this.sessionsStatus,
        upcomingSessions: upcomingSessions ?? this.upcomingSessions,
        pastSessions: pastSessions ?? this.pastSessions,
        sessionsError: sessionsError,
        notesLibraryStatus: notesLibraryStatus ?? this.notesLibraryStatus,
        notesLibrary: notesLibrary ?? this.notesLibrary,
        notesLibraryCanLoadMore:
            notesLibraryCanLoadMore ?? this.notesLibraryCanLoadMore,
        notesLibraryPage: notesLibraryPage ?? this.notesLibraryPage,
        notesLibraryError: notesLibraryError,
      );
}
