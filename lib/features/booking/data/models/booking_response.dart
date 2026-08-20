// Models for POST /user/bookings, GET /user/bookings/:id

import 'package:talkam/features/session/data/models/session_model.dart';

class BookingResponse {
  final int id;
  final String uuid;
  final int therapistId;
  final String therapistName;
  final String startsAt;
  final int durationMinutes;
  final String format;
  final String status;
  final String coverage;
  final String? acknowledgedAt;
  final String amount;
  final String currency;
  final String? notes;
  final bool hasNote;
  final String? paymentReference;
  final double? rating;
  final String? clientPreMood;
  final String? clientPostMood;
  final String? receiptUrl;
  final String? sharedNote;
  final dynamic pendingReschedule;

  const BookingResponse({
    required this.id,
    required this.uuid,
    required this.therapistId,
    required this.therapistName,
    required this.startsAt,
    required this.durationMinutes,
    required this.format,
    required this.status,
    required this.coverage,
    this.acknowledgedAt,
    required this.amount,
    required this.currency,
    this.notes,
    required this.hasNote,
    this.paymentReference,
    this.rating,
    this.clientPreMood,
    this.clientPostMood,
    this.receiptUrl,
    this.sharedNote,
    this.pendingReschedule,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) => BookingResponse(
        id: (json['id'] as num?)?.toInt() ??
            int.tryParse(json['id']?.toString() ?? '') ??
            0,
        uuid: json['uuid']?.toString() ?? '',
        therapistId: (json['therapist_id'] as num?)?.toInt() ??
            int.tryParse(json['therapist_id']?.toString() ?? '') ??
            0,
        therapistName: json['therapist_name']?.toString() ?? '',
        startsAt: json['starts_at']?.toString() ?? '',
        durationMinutes: (json['duration_minutes'] as num?)?.toInt() ??
            int.tryParse(json['duration_minutes']?.toString() ?? '') ??
            0,
        format: json['format']?.toString() ?? '',
        status: json['status']?.toString() ?? '',
        coverage: json['coverage']?.toString() ?? '',
        acknowledgedAt: json['acknowledged_at']?.toString(),
        amount: json['amount']?.toString() ?? '',
        currency: json['currency']?.toString() ?? '',
        notes: json['notes']?.toString(),
        hasNote: json['has_note'] == true ||
            json['has_note'] == 1 ||
            json['has_note']?.toString() == 'true',
        paymentReference: json['payment_reference']?.toString(),
        rating: (json['rating'] as num?)?.toDouble() ??
            double.tryParse(json['rating']?.toString() ?? ''),
        clientPreMood: json['client_pre_mood']?.toString(),
        clientPostMood: json['client_post_mood']?.toString(),
        receiptUrl: json['receipt_url']?.toString(),
        sharedNote: json['shared_note']?.toString(),
        pendingReschedule: json['pending_reschedule'],
      );

  /// Formatted amount, e.g. "₦20,000"
  String get formattedAmount {
    final val = double.tryParse(amount) ?? 0;
    final formatted = val.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '₦$formatted';
  }

  /// Human-readable start date/time
  String get formattedStartsAt {
    final dt = DateTime.tryParse(startsAt);
    if (dt == null) return startsAt;
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
    return '$dayLabel at $hour:$min $period';
  }

  static String _monthAbbrev(int m) =>
      const ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m];

  bool get isPendingPayment => status == 'pending_payment';
  bool get isConfirmed => status == 'confirmed';
  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';
  bool get isCancelled => status == 'cancelled';
  bool get needsReview => isCompleted && rating == null;

  /// Adapts this into the [SessionModel] shape shared by the existing
  /// session screens (room/prep/cancel/reschedule sheets, receipt) so they
  /// don't need their own booking-aware rewrite — same approach as
  /// TherapistSessionItem.toSessionModel() on the therapist side.
  SessionModel toSessionModel() {
    final dt = DateTime.tryParse(startsAt);
    return SessionModel(
      id: id.toString(),
      therapistName: therapistName,
      therapistTitle: '',
      avatarUrl: '',
      initial: therapistName.isNotEmpty ? therapistName[0].toUpperCase() : '?',
      displayDate: dt == null ? startsAt : _displayDateOnly(dt),
      displayTime: dt == null ? '' : _displayTimeOnly(dt),
      format: format.isNotEmpty
          ? '${format[0].toUpperCase()}${format.substring(1)}'
          : format,
      price: double.tryParse(amount) ?? 0,
      rating: rating ?? 0,
      isUpcoming: status != 'completed' &&
          status != 'cancelled' &&
          status != 'no_show' &&
          status != 'failed' &&
          status != 'expired',
      status: status,
      startsAt: parseBackendSessionStartsAt(startsAt),
    );
  }

  String _displayDateOnly(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(dt.year, dt.month, dt.day);
    final diff = day.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    return '${_monthAbbrev(dt.month)} ${dt.day}';
  }

  String _displayTimeOnly(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final min = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$min $period';
  }
}
