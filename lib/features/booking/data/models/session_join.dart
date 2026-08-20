// Model for GET /user/bookings/:id/join

class SessionJoinDetails {
  final String channelRef;
  final String token;
  final String startsAt;
  final int durationMinutes;

  const SessionJoinDetails({
    required this.channelRef,
    required this.token,
    required this.startsAt,
    required this.durationMinutes,
  });

  factory SessionJoinDetails.fromJson(Map<String, dynamic> json) =>
      SessionJoinDetails(
        channelRef: json['channel_ref']?.toString() ?? '',
        token: json['token']?.toString() ?? '',
        startsAt: json['starts_at']?.toString() ?? '',
        durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
      );
}
