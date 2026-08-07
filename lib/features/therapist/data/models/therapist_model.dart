import 'package:talkam/features/therapist/data/models/availability_slot.dart';

/// A single client review rendered on a therapist's profile.
class TherapistReview {
  final int rating;
  final String body;

  /// Who left it, already anonymised for display — e.g. "Employee  •  anonymised".
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

  /// Primary therapeutic approach shown in the profile headline, e.g. "CBT".
  final String modality;

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
    this.modality = 'CBT',
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
    String? modality,
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
        modality: modality ?? this.modality,
        ratingBreakdown: ratingBreakdown ?? this.ratingBreakdown,
        reviews: reviews ?? this.reviews,
        availability: availability ?? this.availability,
      );

  /// The line under the name: "Anxiety  •  CBT  •  9 yrs experience".
  String get headline => [
        if (specialties.isNotEmpty) specialties.first,
        modality,
        '$yearsExperience yrs experience',
      ].join('  •  ');

  /// Time portion of [nextAvailableSlot] — "Today, 4pm" reads as "4pm" in the
  /// stat strip, where the day is already implied.
  String get nextSlotLabel => nextAvailableSlot.split(',').last.trim();

  /// Share of reviews awarding [star], or 0 when no histogram is available.
  double breakdownFor(int star) => ratingBreakdown[star] ?? 0;
}

class MockTherapistData {
  /// Placeholder histogram and reviews shared by every seeded therapist until
  /// a reviews endpoint exists. These were previously hardcoded inside the
  /// profile screen, which meant the UI could not render a therapist who had
  /// different numbers.
  static const Map<int, double> sampleBreakdown = {
    5: 0.92,
    4: 0.35,
    3: 0.15,
    2: 0.05,
    1: 0.0,
  };

  static const List<TherapistReview> sampleReviews = [
    TherapistReview(
      rating: 5,
      body:
          "Had a great session with my therapist! They listened and gave valuable insights. I feel more equipped now. Highly recommend!",
      attribution: "Employee  •  anonymised",
      timeAgo: "2 wks ago",
    ),
    TherapistReview(
      rating: 5,
      body:
          "Participated in a team-building workshop that enhanced our collaboration skills. It was fun and informative!",
      attribution: "Employee  •  anonymised",
      timeAgo: "1 wk ago",
    ),
  ];

  /// Stand-in for the signed-in therapist's own profile. Device-local mock
  /// until the backend exposes a therapist record for the current user —
  /// see SessionManager.isTherapistAccount.
  static const TherapistModel currentTherapist = TherapistModel(
    id: "me",
    name: "Dr. Femi Adebayo",
    title: "Clinical Psychologist, PHD",
    specialties: ["Anxiety", "Depression", "Stress", "Overwhelm"],
    pricePerSession: 25000,
    rating: 4.9,
    reviewsCount: 128,
    avatarUrl: "https://i.pravatar.cc/150?img=12",
    nextAvailableSlot: "Today, 4pm",
    isVerified: true,
    about:
        "Clinical psychologist with 8 years helping young professionals manage anxiety, burnout and relationship challenges. I use evidence-based CBT and mindfulness-based approaches.",
    totalSessions: 132,
    avgDuration: "2 hrs",
    yearsExperience: 9,
    sessionFormats: ["Video", "Voice"],
    ratingBreakdown: sampleBreakdown,
    reviews: sampleReviews,
  );

  static final List<TherapistModel> therapists = [
    const TherapistModel(
      id: "1",
      name: "Dr. Adewale K.",
      title: "Clinical Psychologist, PHD",
      specialties: ["Anxiety", "Depression", "Stress", "Overwhelm"],
      pricePerSession: 25000,
      rating: 4.9,
      reviewsCount: 128,
      avatarUrl: "https://i.pravatar.cc/150?img=51",
      nextAvailableSlot: "Today, 4:00pm",
      isVerified: true,
      about:
          "Clinical psychologist with 8 years helping young professionals manage anxiety, burnout and relationship challenges. I use evidence-based CBT and mindfulness-based approaches.",
      totalSessions: 132,
      avgDuration: "2 hrs",
      yearsExperience: 9,
      sessionFormats: ["Video", "Voice"],
      ratingBreakdown: sampleBreakdown,
      reviews: sampleReviews,
    ),
    const TherapistModel(
      id: "2",
      name: "Ms. Rachel T.",
      title: "Licensed Therapist, MSW",
      specialties: ["Depression", "Anxiety", "Trauma"],
      pricePerSession: 20000,
      rating: 4.7,
      reviewsCount: 75,
      avatarUrl: "https://i.pravatar.cc/150?img=47",
      nextAvailableSlot: "Tomorrow, 10:00am",
      isVerified: true,
      about:
          "I specialize in depression and trauma, providing a safe space to process and heal using trauma-informed therapy techniques.",
      totalSessions: 95,
      avgDuration: "1 hr",
      yearsExperience: 5,
      sessionFormats: ["Video"],
      ratingBreakdown: sampleBreakdown,
      reviews: sampleReviews,
    ),
    const TherapistModel(
      id: "3",
      name: "Dr. Samuel P.",
      title: "Counseling Psychologist, EdD",
      specialties: ["Stress", "Burnout", "Career"],
      pricePerSession: 30000,
      rating: 4.8,
      reviewsCount: 95,
      avatarUrl: "https://i.pravatar.cc/150?img=11",
      nextAvailableSlot: "Today, 2:00pm",
      isVerified: true,
      about:
          "Expert in managing work-related stress and career transitions. I work with clients to develop resilience and actionable career plans.",
      totalSessions: 210,
      avgDuration: "1.5 hrs",
      yearsExperience: 12,
      sessionFormats: ["Video", "Voice", "Chat"],
      ratingBreakdown: sampleBreakdown,
      reviews: sampleReviews,
    ),
  ];
}
