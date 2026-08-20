/// `GET`/`POST /therapist/sessions/{id}/notes` (v2). One note per session,
/// private by default — `sharedWithClient: true` exposes it on the client's
/// booking detail as `shared_note`.
class SessionNote {
  const SessionNote({
    this.id,
    required this.sessionId,
    this.therapistId,
    required this.title,
    required this.content,
    required this.sharedWithClient,
    required this.status,
    required this.tags,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int sessionId;
  final int? therapistId;
  final String title;
  final String content;
  final bool sharedWithClient;
  final String status;
  final List<int> tags;
  final String? createdAt;
  final String? updatedAt;

  factory SessionNote.fromJson(Map<String, dynamic> json) => SessionNote(
        id: json['id'],
        sessionId: json['session_id'],
        therapistId: json['therapist_id'],
        title: json['title'] ?? '',
        content: json['content'] ?? '',
        sharedWithClient: json['shared_with_client'] ?? false,
        status: json['status'] ?? 'draft',
        tags: List<int>.from(json['tags'] ?? []),
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'shared_with_client': sharedWithClient,
        'status': status,
        'tags': tags,
      };
}
