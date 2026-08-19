// Model for GET /user/therapists/:id/reviews (response TBD)

class TherapistReviewItem {
  final int? id;
  final int rating;
  final String? comment;
  final String? timeAgo;
  // Reviews are always displayed anonymised — no user name/avatar.

  const TherapistReviewItem({
    this.id,
    required this.rating,
    this.comment,
    this.timeAgo,
  });

  factory TherapistReviewItem.fromJson(Map<String, dynamic> json) =>
      TherapistReviewItem(
        id: json['id'] as int?,
        rating: (json['rating'] as num?)?.toInt() ?? 0,
        comment: json['comment'] as String?,
        timeAgo: json['time_ago'] as String? ?? json['created_at'] as String?,
      );
}

class TherapistReviewsResponse {
  final List<TherapistReviewItem> reviews;
  final Map<int, int>? histogram;

  const TherapistReviewsResponse({required this.reviews, this.histogram});

  factory TherapistReviewsResponse.fromJson(Map<String, dynamic> json) {
    // Shape TBD — parse defensively
    final dynamic raw = json['data'];
    List<TherapistReviewItem> reviews = [];
    if (raw is List) {
      reviews = raw
          .map((e) =>
              TherapistReviewItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (raw is Map && raw['data'] is List) {
      reviews = (raw['data'] as List)
          .map((e) =>
              TherapistReviewItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    Map<int, int>? histogram;
    if (json['histogram'] is Map) {
      histogram = {};
      (json['histogram'] as Map).forEach((k, v) {
        final key = int.tryParse(k.toString());
        if (key != null) histogram![key] = (v as num).toInt();
      });
    }

    return TherapistReviewsResponse(reviews: reviews, histogram: histogram);
  }
}
