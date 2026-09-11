import 'package:timeago/timeago.dart' as timeago;

/// Model for `GET /user/therapists/:id/reviews`. Response shape (after the
/// repository unwraps the top-level `data` envelope):
/// `{pagination_meta, data: [{id, rating, comment, author, created_at}],
/// histogram: {"1": n, ..., "5": n}}`.
class TherapistReviewItem {
  final int? id;
  final int rating;
  final String? comment;

  /// Already anonymised by the backend (e.g. "Anonymous") — displayed as-is.
  final String? author;
  final DateTime? createdAt;

  const TherapistReviewItem({
    this.id,
    required this.rating,
    this.comment,
    this.author,
    this.createdAt,
  });

  /// Relative time for display, e.g. "2 days ago" — the API only sends a
  /// raw `created_at` timestamp, never a pre-formatted string.
  String get timeAgo => createdAt == null ? '' : timeago.format(createdAt!);

  factory TherapistReviewItem.fromJson(Map<String, dynamic> json) =>
      TherapistReviewItem(
        id: int.tryParse(json['id']?.toString() ?? ''),
        rating: int.tryParse(json['rating']?.toString() ?? '') ?? 0,
        comment: json['comment']?.toString(),
        author: json['author']?.toString(),
        createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      );
}

class TherapistReviewsResponse {
  final List<TherapistReviewItem> reviews;
  final Map<int, int>? histogram;

  const TherapistReviewsResponse({required this.reviews, this.histogram});

  /// [json] must already be the unwrapped `data` object (the repository is
  /// responsible for stripping the outer `{message, data, success, code}`
  /// envelope, same as every other endpoint in this repository).
  factory TherapistReviewsResponse.fromJson(Map<String, dynamic> json) {
    final reviews = ((json['data'] as List?) ?? [])
        .map((e) => TherapistReviewItem.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();

    Map<int, int>? histogram;
    if (json['histogram'] is Map) {
      histogram = {};
      (json['histogram'] as Map).forEach((k, v) {
        final key = int.tryParse(k.toString());
        if (key != null) histogram![key] = (v as num?)?.toInt() ?? 0;
      });
    }

    return TherapistReviewsResponse(reviews: reviews, histogram: histogram);
  }
}
