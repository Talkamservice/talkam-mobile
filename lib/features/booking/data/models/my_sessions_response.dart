import 'package:talkam/features/booking/data/models/booking_response.dart';

// Model for GET /user/bookings

class MySessionsSummary {
  final int upcoming;
  final int completed;
  final int sessionsUsed;
  final int? sessionsAllowed;
  final String? quarterStart;
  final int? employeeCap;
  final int employeeCapUsed;

  const MySessionsSummary({
    required this.upcoming,
    required this.completed,
    required this.sessionsUsed,
    this.sessionsAllowed,
    this.quarterStart,
    this.employeeCap,
    required this.employeeCapUsed,
  });

  factory MySessionsSummary.fromJson(Map<String, dynamic> json) =>
      MySessionsSummary(
        upcoming: json['upcoming'] as int? ?? 0,
        completed: json['completed'] as int? ?? 0,
        sessionsUsed: json['sessions_used'] as int? ?? 0,
        sessionsAllowed: json['sessions_allowed'] as int?,
        quarterStart: json['quarter_start'] as String?,
        employeeCap: json['employee_cap'] as int?,
        employeeCapUsed: json['employee_cap_used'] as int? ?? 0,
      );
}

class MySessionsResponse {
  final List<BookingResponse> upcoming;
  final List<BookingResponse> past;
  final MySessionsSummary summary;

  const MySessionsResponse({
    required this.upcoming,
    required this.past,
    required this.summary,
  });

  factory MySessionsResponse.fromJson(Map<String, dynamic> json) =>
      MySessionsResponse(
        upcoming: (json['upcoming'] as List<dynamic>? ?? [])
            .map((e) => BookingResponse.fromJson(e as Map<String, dynamic>))
            .toList(),
        past: (json['past'] as List<dynamic>? ?? [])
            .map((e) => BookingResponse.fromJson(e as Map<String, dynamic>))
            .toList(),
        summary: MySessionsSummary.fromJson(
            json['summary'] as Map<String, dynamic>? ?? {}),
      );

  bool get isEmpty => upcoming.isEmpty && past.isEmpty;
}
