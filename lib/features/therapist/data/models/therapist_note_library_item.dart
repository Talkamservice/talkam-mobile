/// `GET /therapist/notes` (v2) — the therapist's own notes, paginated,
/// optionally filtered by `client_id` or searched via `q`. Distinct from
/// [SessionNote] (a single note read/written via
/// `/therapist/sessions/{id}/notes`) — this is the searchable library view;
/// each row still carries [sessionId] so tapping one opens that same
/// session-scoped editor rather than a separate read-only detail screen.
class TherapistNoteLibraryPage {
  const TherapistNoteLibraryPage({
    required this.notes,
    required this.canLoadMore,
    required this.currentPage,
  });

  final List<TherapistNoteLibraryItem> notes;
  final bool canLoadMore;
  final int currentPage;

  factory TherapistNoteLibraryPage.fromJson(Map<String, dynamic> json) {
    final meta = json['pagination_meta'] ?? {};
    return TherapistNoteLibraryPage(
      notes: (json['data'] as List? ?? [])
          .map((e) =>
              TherapistNoteLibraryItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      canLoadMore: meta['can_load_more'] ?? false,
      currentPage: meta['current_page'] ?? 1,
    );
  }
}

class TherapistNoteLibraryItem {
  const TherapistNoteLibraryItem({
    required this.id,
    required this.sessionId,
    required this.title,
    required this.content,
    required this.sharedWithClient,
    required this.status,
    required this.tags,
    required this.clientId,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int sessionId;
  final String title;
  final String content;
  final bool sharedWithClient;
  final String status;
  final List<int> tags;
  final int? clientId;
  final String? createdAt;
  final String? updatedAt;

  factory TherapistNoteLibraryItem.fromJson(Map<String, dynamic> json) =>
      TherapistNoteLibraryItem(
        id: json['id'],
        sessionId: json['session_id'],
        title: json['title'] ?? '',
        content: json['content'] ?? '',
        sharedWithClient: json['shared_with_client'] ?? false,
        status: json['status'] ?? 'draft',
        tags: List<int>.from(json['tags'] ?? []),
        clientId: json['client_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}
