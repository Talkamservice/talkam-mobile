/// `GET /therapist/sessions/{id}/request` (v2) — the assigned therapist's
/// view of a pending booking: who it's from, what it's for, and the payout
/// split. 403s for anyone but the assigned therapist.
class SessionRequestSheet {
  const SessionRequestSheet({
    required this.id,
    required this.clientName,
    required this.newClient,
    required this.topics,
    required this.startsAt,
    required this.durationMinutes,
    required this.format,
    required this.amount,
    required this.youReceive,
    required this.currency,
    this.note,
    this.acknowledgedAt,
  });

  final int id;
  final String clientName;
  final bool newClient;
  final List<String> topics;
  final String startsAt;
  final int durationMinutes;
  final String format;
  final String amount;
  final num youReceive;
  final String currency;
  final String? note;
  final String? acknowledgedAt;

  bool get isAcknowledged => acknowledgedAt != null;

  factory SessionRequestSheet.fromJson(Map<String, dynamic> json) =>
      SessionRequestSheet(
        id: json['id'],
        clientName: json['client_name'] ?? '',
        newClient: json['new_client'] ?? false,
        topics: List<String>.from(json['topics'] ?? []),
        startsAt: json['starts_at'] ?? '',
        durationMinutes: json['duration_minutes'] ?? 0,
        format: json['format'] ?? 'video',
        amount: json['amount']?.toString() ?? '0',
        youReceive: json['you_receive'] ?? 0,
        currency: json['currency'] ?? 'NGN',
        note: json['note'],
        acknowledgedAt: json['acknowledged_at'],
      );
}

/// `POST /therapist/sessions/{id}/acknowledge` response.
class SessionAcknowledgeResult {
  const SessionAcknowledgeResult({
    required this.acknowledgedAt,
    required this.status,
  });

  final String acknowledgedAt;
  final String status;

  factory SessionAcknowledgeResult.fromJson(Map<String, dynamic> json) =>
      SessionAcknowledgeResult(
        acknowledgedAt: json['acknowledged_at'] ?? '',
        status: json['status'] ?? '',
      );
}
