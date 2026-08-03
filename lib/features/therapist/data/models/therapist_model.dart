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
  });
}

class MockTherapistData {
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
    ),
  ];
}
