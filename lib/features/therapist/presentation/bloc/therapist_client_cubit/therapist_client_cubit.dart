import 'package:bloc/bloc.dart';
import 'package:talkam/features/therapist/data/models/session_note.dart';
import 'package:talkam/features/therapist/data/models/therapist_client.dart';
import 'package:talkam/features/therapist/data/models/therapist_note_library_item.dart';
import 'package:talkam/features/therapist/data/models/therapist_session_item.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';

part 'therapist_client_state.dart';

/// Drives the therapist Clients roster/detail/treatment-plan/session-note
/// screens, plus the therapist's own Sessions list and Notes library,
/// against the real v2 `/therapist/*` endpoints. One instance per screen,
/// constructed locally (not GetIt-registered), matching the pattern used by
/// the other screen-scoped blocs in this app.
class TherapistClientCubit extends Cubit<TherapistClientState> {
  final TherapistRepository _repository;

  TherapistClientCubit(this._repository) : super(const TherapistClientState());

  Future<void> getClients() async {
    emit(state.copyWith(clientsStatus: LoadStatus.loading));
    try {
      final clients = await _repository.getClients();
      emit(state.copyWith(clientsStatus: LoadStatus.success, clients: clients));
    } catch (e) {
      emit(state.copyWith(
        clientsStatus: LoadStatus.error,
        clientsError: e.toString(),
      ));
    }
  }

  Future<void> getClientDetails(int clientId) async {
    emit(state.copyWith(detailStatus: LoadStatus.loading));
    try {
      final detail = await _repository.getClientDetails(clientId);
      emit(state.copyWith(detailStatus: LoadStatus.success, detail: detail));
    } catch (e) {
      emit(state.copyWith(
        detailStatus: LoadStatus.error,
        detailError: e.toString(),
      ));
    }
  }

  Future<bool> setTreatmentPlan(
    int clientId, {
    required int totalSessions,
    required String progressStatus,
    String? notes,
  }) async {
    emit(state.copyWith(savingPlan: true));
    try {
      final plan = await _repository.setTreatmentPlan(
        clientId,
        totalSessions: totalSessions,
        progressStatus: progressStatus,
        notes: notes,
      );
      final updatedDetail = state.detail == null
          ? null
          : TherapistClientDetail(
              id: state.detail!.id,
              name: state.detail!.name,
              topics: state.detail!.topics,
              clientSince: state.detail!.clientSince,
              sessionsCount: state.detail!.sessionsCount,
              completedSessions: state.detail!.completedSessions,
              treatmentPlan: plan,
              sessionHistory: state.detail!.sessionHistory,
              needsNote: state.detail!.needsNote,
            );
      emit(state.copyWith(savingPlan: false, detail: updatedDetail));
      return true;
    } catch (e) {
      emit(state.copyWith(savingPlan: false, planError: e.toString()));
      return false;
    }
  }

  Future<void> getSessionNote(int sessionId) async {
    emit(state.copyWith(noteStatus: LoadStatus.loading));
    try {
      final note = await _repository.getSessionNote(sessionId);
      emit(state.copyWith(noteStatus: LoadStatus.success, note: note));
    } catch (e) {
      emit(state.copyWith(
        noteStatus: LoadStatus.error,
        noteError: e.toString(),
      ));
    }
  }

  Future<bool> saveSessionNote(
    int sessionId, {
    required String title,
    required String content,
    required bool sharedWithClient,
    required String status,
    required List<int> tags,
  }) async {
    emit(state.copyWith(savingNote: true));
    try {
      final note = await _repository.saveSessionNote(
        sessionId,
        title: title,
        content: content,
        sharedWithClient: sharedWithClient,
        status: status,
        tags: tags,
      );
      emit(state.copyWith(savingNote: false, note: note));
      return true;
    } catch (e) {
      emit(state.copyWith(savingNote: false, saveNoteError: e.toString()));
      return false;
    }
  }

  Future<void> getSessions() async {
    emit(state.copyWith(sessionsStatus: LoadStatus.loading));
    try {
      final response = await _repository.getSessions();
      emit(state.copyWith(
        sessionsStatus: LoadStatus.success,
        upcomingSessions: response.upcoming,
        pastSessions: response.past,
      ));
    } catch (e) {
      emit(state.copyWith(
        sessionsStatus: LoadStatus.error,
        sessionsError: e.toString(),
      ));
    }
  }

  Future<void> getNotesLibrary({
    int? clientId,
    String? query,
    bool loadMore = false,
  }) async {
    final page = loadMore ? state.notesLibraryPage + 1 : 1;
    emit(state.copyWith(notesLibraryStatus: LoadStatus.loading));
    try {
      final result = await _repository.getNotesLibrary(
        clientId: clientId,
        query: query,
        page: page,
      );
      emit(state.copyWith(
        notesLibraryStatus: LoadStatus.success,
        notesLibrary:
            loadMore ? [...state.notesLibrary, ...result.notes] : result.notes,
        notesLibraryCanLoadMore: result.canLoadMore,
        notesLibraryPage: result.currentPage,
      ));
    } catch (e) {
      emit(state.copyWith(
        notesLibraryStatus: LoadStatus.error,
        notesLibraryError: e.toString(),
      ));
    }
  }
}
