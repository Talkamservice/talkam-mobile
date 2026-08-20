// Models for POST /user/bookings/:id/reschedule, POST /reschedules/:id/respond

/// Matches SessionConstants::RESCHEDULE_REASONS on the backend — the reason
/// picker list. Sending anything else 422s.
abstract class RescheduleReason {
  static const String personalEmergency = 'personal_emergency';
  static const String technicalIssues = 'technical_issues';
  static const String clientRequest = 'client_request';

  static const List<String> all = [
    personalEmergency,
    technicalIssues,
    clientRequest,
  ];
}

class SessionReschedule {
  final int id;
  final String status;
  final String? newStartsAt;

  const SessionReschedule({
    required this.id,
    required this.status,
    this.newStartsAt,
  });

  factory SessionReschedule.fromJson(Map<String, dynamic> json) =>
      SessionReschedule(
        id: (json['id'] as num?)?.toInt() ??
            int.tryParse(json['id']?.toString() ?? '') ??
            0,
        status: json['status']?.toString() ?? '',
        newStartsAt: json['new_starts_at']?.toString(),
      );

  bool get isPending => status == 'pending';
  bool get isAccepted => status == 'accepted';
  bool get isDeclined => status == 'declined';
}
