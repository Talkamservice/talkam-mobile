/// The API sends `starts_at` as a naive `"Y-m-d H:i:s"` string (Carbon's
/// `toDateTimeString()`) with no timezone marker — but the digits are always
/// the backend's fixed `Africa/Lagos` (WAT, UTC+1, no DST) wall clock, not
/// the device's timezone. `DateTime.tryParse` on a marker-less string
/// assumes it's already device-local, which silently gives the wrong
/// absolute instant on any device not also set to UTC+1 — harmless for
/// display text (which just echoes the digits back), but wrong for any real
/// elapsed-time math against `DateTime.now()`, like a session countdown.
DateTime? parseBackendSessionStartsAt(String? raw) {
  if (raw == null) return null;
  final naive = DateTime.tryParse(raw);
  if (naive == null) return null;
  return DateTime.utc(
    naive.year,
    naive.month,
    naive.day,
    naive.hour,
    naive.minute,
    naive.second,
  ).subtract(const Duration(hours: 1));
}

/// A `SessionReschedule` row awaiting a response — reschedule requests never
/// apply immediately; the counterpart must accept via `POST
/// /reschedules/{id}/respond`. Without surfacing this, the requester sees
/// the old time unchanged and reasonably assumes the request silently
/// failed, and the counterpart has no prompt to ever act on it.
class PendingRescheduleInfo {
  final int id;
  final DateTime? newStartsAt;

  /// True when the signed-in user is the one who requested it (so they're
  /// waiting on the other party) — false means it's on THEM to respond.
  final bool requestedByMe;

  const PendingRescheduleInfo({
    required this.id,
    required this.newStartsAt,
    required this.requestedByMe,
  });

  factory PendingRescheduleInfo.fromJson(dynamic json,
      {required int? myUserId}) {
    final map = Map<String, dynamic>.from(json as Map);
    final requestedBy = map['requested_by'];
    final requestedById = requestedBy is num
        ? requestedBy.toInt()
        : int.tryParse(requestedBy?.toString() ?? '');
    return PendingRescheduleInfo(
      id: (map['id'] as num?)?.toInt() ??
          int.tryParse(map['id']?.toString() ?? '') ??
          0,
      newStartsAt:
          parseBackendSessionStartsAt(map['new_starts_at']?.toString()),
      requestedByMe: myUserId != null &&
          requestedById != null &&
          myUserId == requestedById,
    );
  }
}

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
  final DateTime? startsAt;
  final int? clientId;
  final int? therapistId;
  final PendingRescheduleInfo? pendingReschedule;

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
    this.startsAt,
    this.clientId,
    this.therapistId,
    this.pendingReschedule,
  });
}
