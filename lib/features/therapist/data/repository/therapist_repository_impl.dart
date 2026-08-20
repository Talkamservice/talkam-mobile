import 'package:dio/dio.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/therapist/data/models/session_note.dart';
import 'package:talkam/features/therapist/data/models/therapist_client.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';

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
}
