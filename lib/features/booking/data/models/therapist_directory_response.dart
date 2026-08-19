// Models for GET /user/therapists and GET /user/therapists/:id

int? parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

double parseDouble(dynamic value, [double defaultValue = 0.0]) {
  if (value == null) return defaultValue;
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? defaultValue;
}

String? parseString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

bool parseBool(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is num) return value != 0;
  final str = value.toString().toLowerCase();
  return str == 'true' || str == '1';
}

class TherapistSpecialtyItem {
  final int id;
  final String name;

  const TherapistSpecialtyItem({required this.id, required this.name});

  factory TherapistSpecialtyItem.fromJson(Map<String, dynamic> json) =>
      TherapistSpecialtyItem(
        id: parseInt(json['id']) ?? 0,
        name: parseString(json['name']) ?? '',
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class TherapistNextSlot {
  final String startsAt;
  final String endsAt;

  const TherapistNextSlot({required this.startsAt, required this.endsAt});

  factory TherapistNextSlot.fromJson(Map<String, dynamic> json) =>
      TherapistNextSlot(
        startsAt: parseString(json['starts_at']) ?? '',
        endsAt: parseString(json['ends_at']) ?? '',
      );
}

class TherapistDirectoryItem {
  final int id;
  final String name;
  final String username;
  final String? avatar;
  final bool isVerified;
  final String? credentialType;
  final int? yearsExperience;
  final String? sessionRate;
  final List<String>? sessionFormats;
  final double rating;
  final int reviewsCount;
  final List<TherapistSpecialtyItem> specialties;
  final TherapistNextSlot? nextSlot;

  const TherapistDirectoryItem({
    required this.id,
    required this.name,
    required this.username,
    this.avatar,
    required this.isVerified,
    this.credentialType,
    this.yearsExperience,
    this.sessionRate,
    this.sessionFormats,
    required this.rating,
    required this.reviewsCount,
    required this.specialties,
    this.nextSlot,
  });

  factory TherapistDirectoryItem.fromJson(Map<String, dynamic> json) {
    List<String>? formats;
    if (json['session_formats'] is List) {
      formats = (json['session_formats'] as List)
          .map((e) => parseString(e) ?? '')
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return TherapistDirectoryItem(
      id: parseInt(json['id']) ?? 0,
      name: parseString(json['name']) ?? '',
      username: parseString(json['username']) ?? '',
      avatar: parseString(json['avatar']),
      isVerified: parseBool(json['is_verified']),
      credentialType: parseString(json['credential_type']),
      yearsExperience: parseInt(json['years_experience']),
      sessionRate: parseString(json['session_rate']),
      sessionFormats: formats,
      rating: parseDouble(json['rating']),
      reviewsCount: parseInt(json['reviews_count']) ?? 0,
      specialties: (json['specialties'] as List<dynamic>? ?? [])
          .map((e) => TherapistSpecialtyItem.fromJson(
              e is Map ? Map<String, dynamic>.from(e) : {}))
          .toList(),
      nextSlot: json['next_slot'] is Map
          ? TherapistNextSlot.fromJson(
              Map<String, dynamic>.from(json['next_slot'] as Map))
          : null,
    );
  }

  /// Formats session rate for display e.g. "₦20,000"
  String get formattedRate {
    if (sessionRate == null) return '—';
    final amount = double.tryParse(sessionRate!) ?? 0;
    final formatted = amount.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '₦$formatted';
  }

  /// Resolved session formats — defaults to video + voice when null/empty.
  List<String> get resolvedFormats =>
      (sessionFormats == null || sessionFormats!.isEmpty)
          ? ['video', 'voice']
          : sessionFormats!;

  /// First specialty name for the card chip.
  String? get primarySpecialty =>
      specialties.isNotEmpty ? specialties.first.name : null;

  /// Human-readable next slot, e.g. "Today, 3:00 PM"
  String get nextSlotLabel {
    if (nextSlot == null) return 'No slots available';
    final dt = DateTime.tryParse(nextSlot!.startsAt);
    if (dt == null) return nextSlot!.startsAt;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final slotDay = DateTime(dt.year, dt.month, dt.day);
    final diff = slotDay.difference(today).inDays;
    String dayLabel;
    if (diff == 0) {
      dayLabel = 'Today';
    } else if (diff == 1) {
      dayLabel = 'Tomorrow';
    } else {
      dayLabel = '${_monthAbbrev(dt.month)} ${dt.day}';
    }
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final min = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$dayLabel, $hour:$min $period';
  }

  static String _monthAbbrev(int m) =>
      const [
        '',
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
        'Dec'
      ][m];
}

class TherapistDirectoryPaginationMeta {
  final int currentPage;
  final int lastPage;
  final int total;
  final bool canLoadMore;
  final String? nextPageUrl;

  const TherapistDirectoryPaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.canLoadMore,
    this.nextPageUrl,
  });

  factory TherapistDirectoryPaginationMeta.fromJson(
          Map<String, dynamic> json) =>
      TherapistDirectoryPaginationMeta(
        currentPage: parseInt(json['current_page']) ?? 1,
        lastPage: parseInt(json['last_page']) ?? 1,
        total: parseInt(json['total']) ?? 0,
        canLoadMore: parseBool(json['can_load_more']) || json['next_page_url'] != null,
        nextPageUrl: parseString(json['next_page_url']),
      );
}

class TherapistDirectoryResponse {
  final TherapistDirectoryPaginationMeta paginationMeta;
  final List<TherapistDirectoryItem> data;

  const TherapistDirectoryResponse({
    required this.paginationMeta,
    required this.data,
  });

  factory TherapistDirectoryResponse.fromJson(Map<String, dynamic> json) =>
      TherapistDirectoryResponse(
        paginationMeta: TherapistDirectoryPaginationMeta.fromJson(
            json['pagination_meta'] is Map
                ? Map<String, dynamic>.from(json['pagination_meta'] as Map)
                : {}),
        data: (json['data'] as List<dynamic>? ?? [])
            .map((e) => TherapistDirectoryItem.fromJson(
                e is Map ? Map<String, dynamic>.from(e) : {}))
            .toList(),
      );
}

/// Full profile — extends directory card with bio, histogram, etc.
class TherapistProfileDetail extends TherapistDirectoryItem {
  final String? bio;
  final String? status;
  final int? sessionDuration;
  final int? bufferMinutes;
  final int? completedSessions;
  final Map<int, int> ratingsHistogram;

  const TherapistProfileDetail({
    required super.id,
    required super.name,
    required super.username,
    super.avatar,
    required super.isVerified,
    super.credentialType,
    super.yearsExperience,
    super.sessionRate,
    super.sessionFormats,
    required super.rating,
    required super.reviewsCount,
    required super.specialties,
    super.nextSlot,
    this.bio,
    this.status,
    this.sessionDuration,
    this.bufferMinutes,
    this.completedSessions,
    this.ratingsHistogram = const {},
  });

  factory TherapistProfileDetail.fromJson(Map<String, dynamic> json) {
    final base = TherapistDirectoryItem.fromJson(json);
    final Map<int, int> histogram = {};
    if (json['ratings_histogram'] is Map) {
      (json['ratings_histogram'] as Map).forEach((k, v) {
        final key = parseInt(k);
        final val = parseInt(v);
        if (key != null && val != null) histogram[key] = val;
      });
    }
    return TherapistProfileDetail(
      id: base.id,
      name: base.name,
      username: base.username,
      avatar: base.avatar,
      isVerified: base.isVerified,
      credentialType: base.credentialType,
      yearsExperience: base.yearsExperience,
      sessionRate: base.sessionRate,
      sessionFormats: base.sessionFormats,
      rating: base.rating,
      reviewsCount: base.reviewsCount,
      specialties: base.specialties,
      nextSlot: base.nextSlot,
      bio: parseString(json['bio']),
      status: parseString(json['status']),
      sessionDuration: parseInt(json['session_duration']),
      bufferMinutes: parseInt(json['buffer_minutes']),
      completedSessions: parseInt(json['completed_sessions']),
      ratingsHistogram: histogram,
    );
  }

  /// Returns 0.0–1.0 fraction for a given star (1–5) out of total reviews.
  double histogramFraction(int star) {
    if (reviewsCount == 0) return 0.0;
    return (ratingsHistogram[star] ?? 0) / reviewsCount;
  }
}
