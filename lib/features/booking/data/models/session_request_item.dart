// Models for GET/POST /user/session-requests, POST /user/session-requests/:id/decline

class SessionRequestItem {
  final int id;
  final String status;
  final String? therapistName;
  final String format;
  final String preferredAt;
  final String? proposedStartsAt;
  final int? sessionId;
  final String? sessionStatus;

  const SessionRequestItem({
    required this.id,
    required this.status,
    this.therapistName,
    required this.format,
    required this.preferredAt,
    this.proposedStartsAt,
    this.sessionId,
    this.sessionStatus,
  });

  factory SessionRequestItem.fromJson(Map<String, dynamic> json) =>
      SessionRequestItem(
        id: (json['id'] as num?)?.toInt() ??
            int.tryParse(json['id']?.toString() ?? '') ??
            0,
        status: json['status']?.toString() ?? '',
        therapistName: json['therapist_name']?.toString(),
        format: json['format']?.toString() ?? '',
        preferredAt: json['preferred_at']?.toString() ?? '',
        proposedStartsAt: json['proposed_starts_at']?.toString(),
        sessionId: (json['session_id'] as num?)?.toInt(),
        sessionStatus: json['session_status']?.toString(),
      );

  bool get isPending => status == 'pending';

  /// Therapist proposed a real slot — client can pay (book) or decline it.
  bool get isProposed => status == 'proposed';
}

/// POST /user/session-requests and POST /user/session-requests/:id/decline
/// both just echo back {id, status} — this is that shape.
class SessionRequestResult {
  final int id;
  final String status;

  const SessionRequestResult({required this.id, required this.status});

  factory SessionRequestResult.fromJson(Map<String, dynamic> json) =>
      SessionRequestResult(
        id: (json['id'] as num?)?.toInt() ??
            int.tryParse(json['id']?.toString() ?? '') ??
            0,
        status: json['status']?.toString() ?? '',
      );
}
