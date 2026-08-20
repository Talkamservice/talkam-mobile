// Model for POST /user/bookings/:id/cancel

class SessionCancelResult {
  final String status;
  final String? cancelledBy;

  const SessionCancelResult({required this.status, this.cancelledBy});

  factory SessionCancelResult.fromJson(Map<String, dynamic> json) =>
      SessionCancelResult(
        status: json['status']?.toString() ?? '',
        cancelledBy: json['cancelled_by']?.toString(),
      );
}
