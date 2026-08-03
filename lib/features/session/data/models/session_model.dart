class SessionModel {
  final String id;
  final String therapistName;
  final String therapistTitle;
  final String avatarUrl;
  final String initial;
  final String displayDate;
  final String displayTime;
  final String format; // 'Video', 'Article', 'Podcast', 'Webinar'
  final double price;
  final double rating;
  final bool isUpcoming;
  final String? status;

  const SessionModel({
    required this.id,
    required this.therapistName,
    required this.therapistTitle,
    required this.avatarUrl,
    required this.initial,
    required this.displayDate,
    required this.displayTime,
    required this.format,
    required this.price,
    required this.rating,
    required this.isUpcoming,
    this.status,
  });
}

abstract class MockSessionData {
  static const List<SessionModel> upcomingSessions = [
    SessionModel(
      id: "s_1",
      therapistName: "Dr. Amaka Osei",
      therapistTitle: "Clinical Psychologist",
      avatarUrl: "https://i.pravatar.cc/150?img=47",
      initial: "E",
      displayDate: "Today",
      displayTime: "4:00 PM",
      format: "Video",
      price: 15000,
      rating: 4.9,
      isUpcoming: true,
    ),
    SessionModel(
      id: "s_2",
      therapistName: "Dr Dave",
      therapistTitle: "Psychiatrist & Therapist",
      avatarUrl: "https://i.pravatar.cc/150?img=12",
      initial: "F",
      displayDate: "Thu, Jul 4",
      displayTime: "10:00 AM",
      format: "Video",
      price: 25000,
      rating: 4.8,
      isUpcoming: true,
    ),
  ];

  static const List<SessionModel> pastSessions = [
    SessionModel(
      id: "s_3",
      therapistName: "Dr. Emeka O.",
      therapistTitle: "Family Therapist",
      avatarUrl: "https://i.pravatar.cc/150?img=60",
      initial: "E",
      displayDate: "Jun 25",
      displayTime: "2:00 PM",
      format: "Video",
      price: 15000,
      rating: 5.0,
      isUpcoming: false,
    ),
    SessionModel(
      id: "s_4",
      therapistName: "Ms. Amina Z.",
      therapistTitle: "Behavioral Therapist",
      avatarUrl: "https://i.pravatar.cc/150?img=32",
      initial: "F",
      displayDate: "Jul 10",
      displayTime: "11:00 AM",
      format: "Article",
      price: 10500,
      rating: 4.5,
      isUpcoming: false,
    ),
    SessionModel(
      id: "s_5",
      therapistName: "Mr. Kofi A.",
      therapistTitle: "Mental Health Counselor",
      avatarUrl: "https://i.pravatar.cc/150?img=59",
      initial: "G",
      displayDate: "Aug 5",
      displayTime: "3:30 PM",
      format: "Podcast",
      price: 12000,
      rating: 4.5,
      isUpcoming: false,
    ),
    SessionModel(
      id: "s_6",
      therapistName: "Dr. Lisa M.",
      therapistTitle: "Child & Youth Therapist",
      avatarUrl: "https://i.pravatar.cc/150?img=25",
      initial: "H",
      displayDate: "Sep 1",
      displayTime: "1:00 PM",
      format: "Webinar",
      price: 20000,
      rating: 4.5,
      isUpcoming: false,
    ),
  ];
}
