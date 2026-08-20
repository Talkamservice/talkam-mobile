/// One row from `GET /therapist/clients` (v2) — a derived roster of users
/// with at least one confirmed/completed session with the therapist.
class TherapistClientListItem {
  const TherapistClientListItem({
    required this.id,
    required this.name,
    required this.username,
    this.avatar,
    required this.topics,
    required this.sessionsCount,
  });

  final int id;
  final String name;
  final String username;
  final String? avatar;
  final List<String> topics;
  final int sessionsCount;

  factory TherapistClientListItem.fromJson(Map<String, dynamic> json) =>
      TherapistClientListItem(
        id: json['id'],
        name: json['name'] ?? '',
        username: json['username'] ?? '',
        avatar: json['avatar'],
        topics: List<String>.from(json['topics'] ?? []),
        sessionsCount: json['sessions_count'] ?? 0,
      );
}

/// `GET /therapist/clients/{id}` (v2).
class TherapistClientDetail {
  const TherapistClientDetail({
    required this.id,
    required this.name,
    required this.topics,
    required this.clientSince,
    required this.sessionsCount,
    required this.completedSessions,
    this.treatmentPlan,
    required this.sessionHistory,
    required this.needsNote,
  });

  final int id;
  final String name;
  final List<String> topics;
  final String clientSince;
  final int sessionsCount;
  final int completedSessions;
  final TreatmentPlan? treatmentPlan;
  final List<ClientSessionHistoryItem> sessionHistory;
  final bool needsNote;

  factory TherapistClientDetail.fromJson(Map<String, dynamic> json) =>
      TherapistClientDetail(
        id: json['id'],
        name: json['name'] ?? '',
        topics: List<String>.from(json['topics'] ?? []),
        clientSince: json['client_since'] ?? '',
        sessionsCount: json['sessions_count'] ?? 0,
        completedSessions: json['completed_sessions'] ?? 0,
        treatmentPlan: json['treatment_plan'] == null
            ? null
            : TreatmentPlan.fromJson(json['treatment_plan']),
        sessionHistory: (json['session_history'] as List? ?? [])
            .map((e) =>
                ClientSessionHistoryItem.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        needsNote: json['needs_note'] ?? false,
      );
}

/// `POST /therapist/clients/{id}/treatment-plan` (v2) — one plan per pair,
/// repeat POSTs update it. [progressStatus] is a config-driven vocabulary
/// (no list-values endpoint is documented, so the UI offers a fixed set —
/// see [kProgressStatusOptions]).
class TreatmentPlan {
  const TreatmentPlan({
    required this.totalSessions,
    required this.progressStatus,
    this.notes,
  });

  final int totalSessions;
  final String progressStatus;
  final String? notes;

  factory TreatmentPlan.fromJson(Map<String, dynamic> json) => TreatmentPlan(
        totalSessions: int.tryParse(json['total_sessions'].toString()) ?? 0,
        progressStatus: json['progress_status'] ?? '',
        notes: json['notes'],
      );
}

/// Assumed vocabulary for [TreatmentPlan.progressStatus] — the API note
/// only says "config-driven vocabulary" with no values endpoint documented.
const kProgressStatusOptions = [
  'good_progress',
  'needs_attention',
  'stalled',
  'completed',
];

class ClientSessionHistoryItem {
  const ClientSessionHistoryItem({
    required this.id,
    required this.startsAt,
    required this.status,
    required this.format,
    this.summary,
  });

  final int id;
  final String startsAt;
  final String status;
  final String format;
  final String? summary;

  factory ClientSessionHistoryItem.fromJson(Map<String, dynamic> json) =>
      ClientSessionHistoryItem(
        id: json['id'],
        startsAt: json['starts_at'] ?? '',
        status: json['status'] ?? '',
        format: json['format'] ?? '',
        summary: json['summary'],
      );
}
