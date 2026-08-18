/// Response for `POST /user/messaging/conversations/{action}`
/// (mute | unmute | archive | unarchive | star | unstar | seen).
class ConversationStateResponse {
  const ConversationStateResponse({
    required this.isMuted,
    this.mutedUntil,
    this.archivedAt,
    this.starredAt,
    this.lastSeenAt,
  });

  final bool isMuted;
  final String? mutedUntil;
  final String? archivedAt;
  final String? starredAt;
  final String? lastSeenAt;

  factory ConversationStateResponse.fromJson(Map<String, dynamic> json) =>
      ConversationStateResponse(
        isMuted: json['is_muted'] ?? false,
        mutedUntil: json['muted_until'],
        archivedAt: json['archived_at'],
        starredAt: json['starred_at'],
        lastSeenAt: json['last_seen_at'],
      );
}
