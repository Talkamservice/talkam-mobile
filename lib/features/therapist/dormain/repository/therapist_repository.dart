import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/therapist/data/models/session_note.dart';
import 'package:talkam/features/therapist/data/models/therapist_client.dart';
import 'package:talkam/features/therapist/data/models/therapist_note_library_item.dart';
import 'package:talkam/features/therapist/data/models/therapist_session_item.dart';

/// Covers the therapist-scoped `/therapist/*` v2 endpoints that aren't part
/// of the application wizard ([TherapistApplicationRepository]) — the
/// clients roster, a client's detail + treatment plan, per-session notes,
/// the therapist's own sessions list, the notes library/search, and the
/// therapist's own profile (self-view + edit).
abstract class TherapistRepository {
  /// `GET /therapist/profile` — same "section-07" shape as
  /// `GET /user/therapists/{id}` (the public directory profile), so it
  /// reuses [TherapistProfileDetail] rather than a parallel model.
  Future<TherapistProfileDetail> getMyProfile();

  /// `POST /therapist/profile/update`. `credentialType` is not accepted here
  /// — it's read-only post-approval (a separate re-verification path).
  Future<void> updateMyProfile({
    required String name,
    required String bio,
    required int yearsExperience,
    required int sessionRate,
    String? avatarPath,
  });
  Future<List<TherapistClientListItem>> getClients();

  Future<TherapistClientDetail> getClientDetails(int clientId);

  Future<TreatmentPlan> setTreatmentPlan(
    int clientId, {
    required int totalSessions,
    required String progressStatus,
    String? notes,
  });

  Future<SessionNote> getSessionNote(int sessionId);

  Future<SessionNote> saveSessionNote(
    int sessionId, {
    required String title,
    required String content,
    required bool sharedWithClient,
    required String status,
    required List<int> tags,
  });

  Future<TherapistSessionsResponse> getSessions();

  Future<TherapistNoteLibraryPage> getNotesLibrary({
    int? clientId,
    String? query,
    int page = 1,
  });
}
