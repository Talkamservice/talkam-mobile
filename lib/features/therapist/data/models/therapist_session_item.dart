import 'package:talkam/features/session/data/models/session_model.dart';

/// `GET /therapist/sessions` (v2) — mirrored upcoming/past, each item
/// carrying the therapist's own NET earnings share and the client's rating.
class TherapistSessionsResponse {
  const TherapistSessionsResponse({
    required this.upcoming,
    required this.past,
  });

  final List<TherapistSessionItem> upcoming;
  final List<TherapistSessionItem> past;

  factory TherapistSessionsResponse.fromJson(Map<String, dynamic> json) =>
      TherapistSessionsResponse(
        upcoming: (json['upcoming'] as List? ?? [])
            .map((e) =>
                TherapistSessionItem.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        past: (json['past'] as List? ?? [])
            .map((e) =>
                TherapistSessionItem.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
}

class TherapistSessionItem {
  const TherapistSessionItem({
    required this.id,
    required this.uuid,
    required this.startsAt,
    required this.durationMinutes,
    required this.format,
    required this.status,
    required this.amount,
    required this.currency,
    required this.clientName,
    required this.earnings,
    this.rating,
    required this.hasNote,
    this.receiptUrl,
  });

  final int id;
  final String uuid;
  final String startsAt;
  final int durationMinutes;
  final String format;
  final String status;
  final String amount;
  final String currency;
  final String clientName;
  final num earnings;
  final num? rating;
  final bool hasNote;
  final String? receiptUrl;

  factory TherapistSessionItem.fromJson(Map<String, dynamic> json) =>
      TherapistSessionItem(
        id: json['id'],
        uuid: json['uuid'] ?? '',
        startsAt: json['starts_at'] ?? '',
        durationMinutes: json['duration_minutes'] ?? 0,
        format: json['format'] ?? 'video',
        status: json['status'] ?? '',
        amount: json['amount']?.toString() ?? '0',
        currency: json['currency'] ?? 'NGN',
        clientName: json['client_name'] ?? '',
        earnings: json['earnings'] ?? 0,
        rating: json['rating'],
        hasNote: json['has_note'] ?? false,
        receiptUrl: json['receipt_url'],
      );

  bool get isConfirmed => status == 'confirmed';

  /// Adapts this v2 session into the [SessionModel] shape shared by the
  /// existing session screens (prep/room/complete/cancel/reschedule sheets)
  /// so they don't need their own v2-aware rewrite.
  SessionModel toSessionModel() {
    final dt = DateTime.tryParse(startsAt);
    return SessionModel(
      id: id.toString(),
      // These screens display the *other party* under "therapistName" —
      // for a therapist's own session list that's the client.
      therapistName: clientName,
      therapistTitle: "Client",
      avatarUrl: "",
      initial: clientName.isNotEmpty ? clientName[0].toUpperCase() : "?",
      displayDate: dt == null ? startsAt : _formatDate(dt),
      displayTime: dt == null ? "" : _formatTime(dt),
      format: format.isNotEmpty
          ? "${format[0].toUpperCase()}${format.substring(1)}"
          : format,
      price: num.tryParse(earnings.toString())?.toDouble() ?? 0,
      rating: rating?.toDouble() ?? 0,
      isUpcoming: status != 'completed' && status != 'cancelled',
      status: status,
      startsAt: parseBackendSessionStartsAt(startsAt),
    );
  }

  static String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(dt.year, dt.month, dt.day);
    final diff = day.difference(today).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "Tomorrow";
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[dt.month - 1]} ${dt.day}";
  }

  static String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  }
}
