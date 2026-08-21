import 'package:dio/dio.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:talkam/features/therapist/data/models/session_note.dart';
import 'package:talkam/features/therapist/data/models/therapist_client.dart';
import 'package:talkam/features/therapist/data/models/therapist_note_library_item.dart';
import 'package:talkam/features/therapist/data/models/therapist_session_item.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';

/// `GET/PUT /therapist/availability` represent each day with a short key
/// (`mon`..`sun`), unlike [Weekday.name] (`monday`..`sunday`) used for local
/// persistence — this is the one place the two vocabularies meet.
const Map<Weekday, String> _kAvailabilityDayKeys = {
  Weekday.monday: 'mon',
  Weekday.tuesday: 'tue',
  Weekday.wednesday: 'wed',
  Weekday.thursday: 'thu',
  Weekday.friday: 'fri',
  Weekday.saturday: 'sat',
  Weekday.sunday: 'sun',
};

class TherapistRepositoryImpl extends TherapistRepository {
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

  @override
  Future<List<TherapistClientListItem>> getClients() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.therapistClients, RequestMethod.get);
      final data = response.data['data'] as List? ?? [];
      return data
          .map((e) =>
              TherapistClientListItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistClientDetail> getClientDetails(int clientId) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistClientDetail(clientId),
        RequestMethod.get,
      );
      return TherapistClientDetail.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TreatmentPlan> setTreatmentPlan(
    int clientId, {
    required int totalSessions,
    required String progressStatus,
    String? notes,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistClientTreatmentPlan(clientId),
        RequestMethod.post,
        formData: FormData.fromMap({
          "total_sessions": totalSessions,
          "progress_status": progressStatus,
          if (notes != null) "notes": notes,
        }),
        options: _formOptions,
      );
      return TreatmentPlan.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SessionNote> getSessionNote(int sessionId) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistSessionNotes(sessionId),
        RequestMethod.get,
      );
      return SessionNote.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SessionNote> saveSessionNote(
    int sessionId, {
    required String title,
    required String content,
    required bool sharedWithClient,
    required String status,
    required List<int> tags,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistSessionNotes(sessionId),
        RequestMethod.post,
        data: {
          "title": title,
          "content": content,
          "shared_with_client": sharedWithClient,
          "status": status,
          "tags": tags,
        },
      );
      return SessionNote.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistSessionsResponse> getSessions() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.therapistSessions, RequestMethod.get);
      return TherapistSessionsResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistNoteLibraryPage> getNotesLibrary({
    int? clientId,
    String? query,
    int page = 1,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistNotesLibrary,
        RequestMethod.get,
        queryParams: {
          "page": page.toString(),
          if (clientId != null) "client_id": clientId.toString(),
          if (query != null && query.isNotEmpty) "q": query,
        },
      );
      return TherapistNoteLibraryPage.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistProfileDetail> getMyProfile() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.therapistOwnProfile, RequestMethod.get);
      return TherapistProfileDetail.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateMyProfile({
    required String name,
    required String bio,
    required int yearsExperience,
    required int sessionRate,
    String? avatarPath,
  }) async {
    try {
      await _v2.call(
        UrlConfigV2.therapistOwnProfileUpdate,
        RequestMethod.post,
        formData: FormData.fromMap({
          "name": name,
          "bio": bio,
          "years_experience": yearsExperience,
          "session_rate": sessionRate,
          if (avatarPath != null)
            "avatar": await MultipartFile.fromFile(avatarPath),
        }),
        options: _formOptions,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeeklyAvailability> getMyAvailability() async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistAvailability,
        RequestMethod.get,
      );
      return _weeklyAvailabilityFromGrid(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeeklyAvailability> updateMyAvailability(
      WeeklyAvailability availability) async {
    try {
      final days = <String, List<Map<String, dynamic>>>{
        for (final key in _kAvailabilityDayKeys.values) key: [],
      };
      for (final slot in availability.slots) {
        days[_kAvailabilityDayKeys[slot.day]]!.add({
          "start": _minutesToHi(slot.startMinutes),
          "end": _minutesToHi(slot.endMinutes),
          "active": true,
        });
      }

      final response = await _v2.call(
        UrlConfigV2.therapistAvailability,
        RequestMethod.put,
        data: {"days": days},
      );
      return _weeklyAvailabilityFromGrid(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  /// Parses the `{"days": {...}, "slots": {"mon": [{"id","start","end",
  /// "active"}, ...], ...}}` shape shared by both the GET and PUT responses.
  /// Inactive rows are dropped — this UI has no concept of a disabled slot,
  /// only ones that exist or don't.
  WeeklyAvailability _weeklyAvailabilityFromGrid(dynamic data) {
    final slotsByDay = (data is Map ? data['slots'] : null) as Map? ?? {};
    final result = <AvailabilitySlot>[];
    for (final entry in _kAvailabilityDayKeys.entries) {
      final rows = (slotsByDay[entry.value] as List?) ?? [];
      for (final row in rows) {
        if (row is! Map) continue;
        final map = Map<String, dynamic>.from(row);
        if (map['active'] == false) continue;
        final start = _hiToMinutes(map['start']?.toString());
        final end = _hiToMinutes(map['end']?.toString());
        if (start == null || end == null) continue;
        result.add(AvailabilitySlot(
          id: map['id']?.toString() ??
              '${entry.value}-$start-$end-${result.length}',
          day: entry.key,
          startMinutes: start,
          endMinutes: end,
        ));
      }
    }
    return WeeklyAvailability(slots: result);
  }

  String _minutesToHi(int minutes) {
    final h = (minutes ~/ 60).toString().padLeft(2, '0');
    final m = (minutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  int? _hiToMinutes(String? hi) {
    if (hi == null) return null;
    final parts = hi.split(':');
    if (parts.length < 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return h * 60 + m;
  }
}
