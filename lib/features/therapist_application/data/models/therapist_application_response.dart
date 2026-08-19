// Response/payload models for the therapist application wizard's v2
// endpoints. One class per response shape — see
// TherapistApplicationRepository for which call returns which.

class TherapistApplicationSteps {
  const TherapistApplicationSteps({
    this.personal = false,
    this.documents = false,
    this.specialties = false,
    this.availability = false,
    this.payout = false,
  });

  final bool personal;
  final bool documents;
  final bool specialties;
  final bool availability;
  final bool payout;

  factory TherapistApplicationSteps.fromJson(Map<String, dynamic>? json) =>
      TherapistApplicationSteps(
        personal: json?['personal'] ?? false,
        documents: json?['documents'] ?? false,
        specialties: json?['specialties'] ?? false,
        availability: json?['availability'] ?? false,
        payout: json?['payout'] ?? false,
      );

  bool get isComplete =>
      personal && documents && specialties && availability && payout;

  /// The wizard route name for the first step not yet marked complete, in
  /// wizard order — where "continue application" should resume.
  String get firstIncompleteStepRoute {
    if (!personal) return _kPersonalInfoRoute;
    if (!documents) return _kQualificationsRoute;
    if (!specialties) return _kSpecialtiesRoute;
    if (!availability) return _kAvailabilityRoute;
    return _kPayoutRoute;
  }
}

// Route names duplicated from PageUrl (route_url.dart) rather than imported,
// to keep this data-model file free of navigation-layer dependencies.
const _kPersonalInfoRoute = 'therapistPersonalInfoScreen';
const _kQualificationsRoute = 'therapistQualificationsScreen';
const _kSpecialtiesRoute = 'therapistSpecialtiesScreen';
const _kAvailabilityRoute = 'therapistAvailabilityScreen';
const _kPayoutRoute = 'therapistPayoutScreen';

/// Response for Step 1 — Personal.
class TherapistApplicationStepsResponse {
  const TherapistApplicationStepsResponse({
    this.applicationId,
    this.status,
    required this.steps,
  });

  final dynamic applicationId;
  final String? status;
  final TherapistApplicationSteps steps;

  factory TherapistApplicationStepsResponse.fromJson(
          Map<String, dynamic> json) =>
      TherapistApplicationStepsResponse(
        applicationId: json['application_id'],
        status: json['status'],
        steps: TherapistApplicationSteps.fromJson(json['steps']),
      );
}

/// Response for Step 2 — a single uploaded document.
class TherapistDocumentResponse {
  const TherapistDocumentResponse({
    required this.id,
    required this.type,
    required this.status,
    this.expiresAt,
  });

  final dynamic id;
  final String type;
  final String status;
  final String? expiresAt;

  factory TherapistDocumentResponse.fromJson(Map<String, dynamic> json) =>
      TherapistDocumentResponse(
        id: json['id'],
        type: json['type'] ?? '',
        status: json['status'] ?? '',
        expiresAt: json['expires_at'],
      );
}

/// Response for Step 3 — Specialties.
class TherapistSpecialtiesResponse {
  const TherapistSpecialtiesResponse({
    required this.bio,
    required this.specialties,
  });

  final String bio;
  final List<int> specialties;

  factory TherapistSpecialtiesResponse.fromJson(Map<String, dynamic> json) =>
      TherapistSpecialtiesResponse(
        bio: json['bio'] ?? '',
        specialties: List<int>.from(json['specialties'] ?? const []),
      );
}

/// Response for Step 4 — Availability.
class TherapistAvailabilityResponse {
  const TherapistAvailabilityResponse({
    required this.sessionDuration,
    required this.bufferMinutes,
  });

  final int sessionDuration;
  final int bufferMinutes;

  factory TherapistAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      TherapistAvailabilityResponse(
        sessionDuration: json['session_duration'] ?? 0,
        bufferMinutes: json['buffer_minutes'] ?? 0,
      );
}

/// One entry from `GET /therapist/banks`.
class TherapistBank {
  const TherapistBank({
    required this.id,
    required this.code,
    required this.name,
  });

  final dynamic id;
  final String code;
  final String name;

  factory TherapistBank.fromJson(Map<String, dynamic> json) => TherapistBank(
        id: json['id'],
        code: json['code'].toString(),
        name: json['name'] ?? '',
      );
}

/// Response for `POST /therapist/payout-account/verify`.
class TherapistVerifyAccountResponse {
  const TherapistVerifyAccountResponse({
    required this.bankCode,
    required this.accountNumber,
    required this.accountName,
  });

  final String bankCode;
  final String accountNumber;
  final String accountName;

  factory TherapistVerifyAccountResponse.fromJson(Map<String, dynamic> json) =>
      TherapistVerifyAccountResponse(
        bankCode: json['bank_code'].toString(),
        accountNumber: json['account_number'].toString(),
        accountName: json['account_name'] ?? '',
      );
}

/// Response for Step 5 — Payout.
class TherapistPayoutResponse {
  const TherapistPayoutResponse({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    this.verifiedAt,
  });

  final String bankName;
  final String accountNumber;
  final String accountName;
  final String? verifiedAt;

  factory TherapistPayoutResponse.fromJson(Map<String, dynamic> json) =>
      TherapistPayoutResponse(
        bankName: json['bank_name'] ?? '',
        accountNumber: json['account_number'].toString(),
        accountName: json['account_name'] ?? '',
        verifiedAt: json['verified_at'],
      );
}

/// Response for `POST /therapist/application/submit`.
class TherapistSubmitResponse {
  const TherapistSubmitResponse({required this.status, this.submittedAt});

  final String status;
  final String? submittedAt;

  factory TherapistSubmitResponse.fromJson(Map<String, dynamic> json) =>
      TherapistSubmitResponse(
        status: json['status'] ?? '',
        submittedAt: json['submitted_at'],
      );
}

/// One day's payload entry for `POST /therapist/application/availability`.
class TherapistDayPayload {
  const TherapistDayPayload({
    required this.dayOfWeek,
    required this.active,
    this.startTime,
    this.endTime,
  });

  final String dayOfWeek;
  final bool active;
  final String? startTime;
  final String? endTime;

  Map<String, dynamic> toJson() => {
        'day_of_week': dayOfWeek,
        'start_time': startTime,
        'end_time': endTime,
        'active': active,
      };
}
