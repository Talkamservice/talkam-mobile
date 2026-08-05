class ClientModel {
  final String id;
  final String name;
  final String email;
  final String initial;
  final String avatarUrl;
  final String lastSessionDate;
  final String joinedDate;
  final String diagnosis;
  final String plan;
  final String progress;
  final int totalSessions;

  const ClientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.initial,
    required this.avatarUrl,
    required this.lastSessionDate,
    required this.joinedDate,
    required this.diagnosis,
    required this.plan,
    required this.progress,
    required this.totalSessions,
  });
}

abstract class MockClientData {
  static const List<ClientModel> clients = [
    ClientModel(
      id: "c_1",
      name: "Emeka O.",
      email: "emeka@example.com",
      initial: "E",
      avatarUrl: "", // No avatar in screenshot, just initial
      lastSessionDate: "Today",
      joinedDate: "Mar 2023",
      diagnosis: "Anxiety • Work stress",
      plan: "Cognitive Behavioral Therapy.",
      progress: "Good.",
      totalSessions: 3,
    ),
    ClientModel(
      id: "c_2",
      name: "Fiona L.",
      email: "fiona@example.com",
      initial: "F",
      avatarUrl: "",
      lastSessionDate: "Yesterday",
      joinedDate: "Jan 2024",
      diagnosis: "Depression • Personal loss",
      plan: "Talk therapy.",
      progress: "Stable.",
      totalSessions: 5,
    ),
    ClientModel(
      id: "c_3",
      name: "Gabriel R.",
      email: "gabriel@example.com",
      initial: "G",
      avatarUrl: "",
      lastSessionDate: "Last week",
      joinedDate: "Nov 2022",
      diagnosis: "PTSD • Trauma recovery",
      plan: "Trauma therapy.",
      progress: "Improving.",
      totalSessions: 8,
    ),
  ];
}
