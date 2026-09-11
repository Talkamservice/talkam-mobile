import 'package:flutter/cupertino.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/booking/data/models/therapist_review_item.dart';

/// A single client review rendered on a therapist's profile.
class TherapistReview {
  final int rating;
  final String body;

  /// Who left it, already anonymised by the backend for display — e.g.
  /// "Anonymous".
  final String attribution;
  final String timeAgo;

  const TherapistReview({
    required this.rating,
    required this.body,
    required this.attribution,
    required this.timeAgo,
  });
}

class TherapistModel {
  final String id;
  final String name;
  final String title;
  final List<String> specialties;
  final double pricePerSession;
  final double rating;
  final int reviewsCount;
  final String avatarUrl;
  final String nextAvailableSlot;
  final bool isVerified;
  final String about;
  final int totalSessions;
  final String avgDuration;
  final int yearsExperience;
  final List<String> sessionFormats;

  /// Share of reviews per star, keyed 1-5, each 0.0-1.0. Empty when the
  /// backend has not supplied a histogram — bars then render empty.
  final Map<int, double> ratingBreakdown;

  final List<TherapistReview> reviews;

  /// Recurring weekly windows the therapist accepts bookings in. Empty until
  /// they set it on the Edit Profile screen.
  final WeeklyAvailability availability;

  const TherapistModel({
    required this.id,
    required this.name,
    required this.title,
    required this.specialties,
    required this.pricePerSession,
    required this.rating,
    required this.reviewsCount,
    required this.avatarUrl,
    required this.nextAvailableSlot,
    required this.isVerified,
    required this.about,
    required this.totalSessions,
    required this.avgDuration,
    required this.yearsExperience,
    required this.sessionFormats,
    this.ratingBreakdown = const {},
    this.reviews = const [],
    this.availability = const WeeklyAvailability(),
  });

  TherapistModel copyWith({
    String? id,
    String? name,
    String? title,
    List<String>? specialties,
    double? pricePerSession,
    double? rating,
    int? reviewsCount,
    String? avatarUrl,
    String? nextAvailableSlot,
    bool? isVerified,
    String? about,
    int? totalSessions,
    String? avgDuration,
    int? yearsExperience,
    List<String>? sessionFormats,
    Map<int, double>? ratingBreakdown,
    List<TherapistReview>? reviews,
    WeeklyAvailability? availability,
  }) =>
      TherapistModel(
        id: id ?? this.id,
        name: name ?? this.name,
        title: title ?? this.title,
        specialties: specialties ?? this.specialties,
        pricePerSession: pricePerSession ?? this.pricePerSession,
        rating: rating ?? this.rating,
        reviewsCount: reviewsCount ?? this.reviewsCount,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        nextAvailableSlot: nextAvailableSlot ?? this.nextAvailableSlot,
        isVerified: isVerified ?? this.isVerified,
        about: about ?? this.about,
        totalSessions: totalSessions ?? this.totalSessions,
        avgDuration: avgDuration ?? this.avgDuration,
        yearsExperience: yearsExperience ?? this.yearsExperience,
        sessionFormats: sessionFormats ?? this.sessionFormats,
        ratingBreakdown: ratingBreakdown ?? this.ratingBreakdown,
        reviews: reviews ?? this.reviews,
        availability: availability ?? this.availability,
      );

  /// The line under the name: "Anxiety  •  Bipolar  •  9 yrs experience".
  String get headline => [
        ...specialties.take(2),
        '$yearsExperience yrs experience',
      ].join('  •  ');

  /// Time portion of [nextAvailableSlot] — "Today, 4pm" reads as "4pm" in the
  /// stat strip, where the day is already implied.
  String get nextSlotLabel => nextAvailableSlot.split(',').last.trim();

  /// Share of reviews awarding [star], or 0 when no histogram is available.
  double breakdownFor(int star) => ratingBreakdown[star] ?? 0;

  /// Placeholder shown before the first successful fetch (or when it fails)
  /// — every stat reads as zero/blank rather than a fabricated number.
  factory TherapistModel.empty() => const TherapistModel(
        id: '',
        name: '',
        title: '',
        specialties: [],
        pricePerSession: 0,
        rating: 0,
        reviewsCount: 0,
        avatarUrl: '',
        nextAvailableSlot: '',
        isVerified: false,
        about: '',
        totalSessions: 0,
        avgDuration: '',
        yearsExperience: 0,
        sessionFormats: [],
      );

  factory TherapistModel.fromDirectoryItem(TherapistDirectoryItem item) {
    final rate = double.tryParse(item.sessionRate ?? '') ?? 0.0;
    return TherapistModel(
      id: item.id.toString(),
      name: item.name,
      title: item.credentialType ?? 'Licensed Therapist',
      specialties: item.specialties.isNotEmpty
          ? item.specialties.map((s) => s.name).toList()
          : ['Mental Health'],
      pricePerSession: rate,
      rating: item.rating,
      reviewsCount: item.reviewsCount,
      avatarUrl: item.avatar ?? '',
      nextAvailableSlot: item.nextSlotLabel,
      isVerified: item.isVerified,
      about: '',
      totalSessions: 0,
      avgDuration: '50 mins',
      yearsExperience: item.yearsExperience ?? 0,
      sessionFormats: item.resolvedFormats,
    );
  }

  factory TherapistModel.fromProfileDetail(
    TherapistProfileDetail detail, [
    TherapistReviewsResponse? reviewsResponse,
  ]) {
    final base = TherapistModel.fromDirectoryItem(detail);
    final reviews = (reviewsResponse?.reviews ?? [])
        .map((r) => TherapistReview(
              rating: r.rating,
              body: r.comment ?? '',
              attribution: r.author ?? 'Anonymous',
              timeAgo: r.timeAgo,
            ))
        .toList();
    final Map<int, double> breakdown = {};
    
    // The histogram might come from the detail profile or the reviews response
    final rawHistogram = reviewsResponse?.histogram ?? detail.ratingsHistogram;
    
    int totalCount = detail.reviewsCount;
    if (totalCount == 0 && rawHistogram.isNotEmpty) {
      totalCount = rawHistogram.values.fold(0, (sum, count) => sum + count);
    }
    
    if (totalCount > 0) {
      rawHistogram.forEach((k, v) {
        breakdown[k] = v / totalCount;
      });
    }
    
    debugPrint('Mapped ${reviews.length} reviews from API');
    
    return base.copyWith(
      about: detail.bio ?? '',
      totalSessions: detail.completedSessions ?? 0,
      yearsExperience: detail.yearsExperience ?? 0,
      ratingBreakdown: breakdown,
      reviewsCount: totalCount,
      reviews: reviews,
      // fromDirectoryItem() always hardcodes '50 mins' since the plain
      // directory list item carries no duration — but the full profile
      // detail does, so use the real value once we have it.
      avgDuration: detail.sessionDuration != null
          ? '${detail.sessionDuration} min'
          : base.avgDuration,
    );
  }
}
