import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/document_upload_tile.dart';
import 'package:talkam/features/therapist/data/models/session_rate.dart';

/// Step 1 — Personal Information.
class PersonalInfo {
  const PersonalInfo({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.credentialType,
    this.yearsExperience = '',
  });

  final String fullName;
  final String email;
  final String phone;
  final String? credentialType;

  /// Kept as text (matches [PayoutInfo.sessionRate]'s convention) since it's
  /// bound directly to a [TextEditingController]; parsed to `int` only when
  /// building the network payload.
  final String yearsExperience;

  bool get isValid =>
      fullName.trim().isNotEmpty &&
      email.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      credentialType != null &&
      int.tryParse(yearsExperience) != null;

  PersonalInfo copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? credentialType,
    String? yearsExperience,
  }) =>
      PersonalInfo(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        credentialType: credentialType ?? this.credentialType,
        yearsExperience: yearsExperience ?? this.yearsExperience,
      );
}

/// Step 2 — required documents. Ids are stable keys used by the bloc; the
/// display copy lives here so screen and bloc stay in sync automatically.
enum DocumentId {
  degreeCertificate,
  npaOrMdcnRegistration,
  governmentId,
  professionalIndemnityInsurance,
  professionalHeadshot,
}

extension DocumentIdX on DocumentId {
  /// The `type` value the v2 documents endpoint expects — distinct from the
  /// Dart enum member names above, which predate the real API contract.
  String get apiValue => switch (this) {
        DocumentId.degreeCertificate => "degree_certificate",
        DocumentId.npaOrMdcnRegistration => "licence",
        DocumentId.governmentId => "government_id",
        DocumentId.professionalIndemnityInsurance => "indemnity_insurance",
        DocumentId.professionalHeadshot => "headshot",
      };

  /// Only the licence document accepts an expiry date server-side.
  bool get supportsExpiry => this == DocumentId.npaOrMdcnRegistration;

  String get title => switch (this) {
        DocumentId.degreeCertificate => "Degree certificate",
        DocumentId.npaOrMdcnRegistration => "NPA or MDCN registration",
        DocumentId.governmentId => "Government-issued ID",
        DocumentId.professionalIndemnityInsurance =>
          "Professional indemnity insurance",
        DocumentId.professionalHeadshot => "Professional headshot photo",
      };

  String get subtitle => switch (this) {
        DocumentId.degreeCertificate =>
          "BSc or MSc Psychology or related field",
        DocumentId.npaOrMdcnRegistration =>
          "Current year licence — must not be expired",
        DocumentId.governmentId => "NIN slip, passport, or driver's licence",
        DocumentId.professionalIndemnityInsurance =>
          "Certificate of current coverage",
        DocumentId.professionalHeadshot => "Clear, front-facing portrait",
      };

  /// Short label used on the upload tile itself (kept distinct from [title]
  /// since some tiles use an abbreviation, e.g. "NPA / MDCN").
  String get shortLabel => switch (this) {
        DocumentId.npaOrMdcnRegistration => "NPA / MDCN",
        _ => title,
      };

  IconData get icon => switch (this) {
        DocumentId.degreeCertificate => Icons.school_outlined,
        DocumentId.npaOrMdcnRegistration => Icons.badge_outlined,
        DocumentId.governmentId => Icons.perm_identity_outlined,
        DocumentId.professionalIndemnityInsurance => Icons.shield_outlined,
        DocumentId.professionalHeadshot => Icons.camera_alt_outlined,
      };
}

/// A single requirement's upload state.
class DocumentUpload {
  const DocumentUpload({
    required this.id,
    this.status = DocumentUploadStatus.idle,
    this.progress = 0,
    this.fileName,
    this.serverId,
    this.expiresAt,
  });

  final DocumentId id;
  final DocumentUploadStatus status;

  /// 0..1, meaningful only while [status] is uploading.
  final double progress;
  final String? fileName;

  /// The id the server assigned this upload — needed for
  /// `DELETE /therapist/application/documents/{id}`. Null until uploaded.
  final dynamic serverId;

  /// Licence expiry (Y-m-d), only meaningful for [DocumentIdX.supportsExpiry].
  final String? expiresAt;

  DocumentUpload copyWith({
    DocumentUploadStatus? status,
    double? progress,
    String? fileName,
    dynamic serverId,
    String? expiresAt,
  }) =>
      DocumentUpload(
        id: id,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        fileName: fileName ?? this.fileName,
        serverId: serverId ?? this.serverId,
        expiresAt: expiresAt ?? this.expiresAt,
      );
}

/// Step 3 — Specialties. [specialties] holds interest-topic ids (see
/// `GET /user/interest-topics`), not display labels.
class SpecialtiesInfo {
  const SpecialtiesInfo({this.bio = '', this.specialties = const []});

  final String bio;
  final List<int> specialties;

  bool get isValid => bio.trim().isNotEmpty && specialties.isNotEmpty;

  SpecialtiesInfo copyWith({String? bio, List<int>? specialties}) =>
      SpecialtiesInfo(
        bio: bio ?? this.bio,
        specialties: specialties ?? this.specialties,
      );
}

/// One working day's hours inside Step 4.
class DayAvailability {
  const DayAvailability({
    required this.day,
    this.active = false,
    this.start = const TimeOfDay(hour: 9, minute: 0),
    // Stays within TimeSelectSheet's 9 AM–5 PM picker range — see
    // TherapistAvailabilityScreen._pickTime.
    this.end = const TimeOfDay(hour: 17, minute: 0),
    this.paid = false,
  });

  final String day;
  final bool active;
  final TimeOfDay start;
  final TimeOfDay end;
  final bool paid;

  DayAvailability copyWith({
    bool? active,
    TimeOfDay? start,
    TimeOfDay? end,
    bool? paid,
  }) =>
      DayAvailability(
        day: day,
        active: active ?? this.active,
        start: start ?? this.start,
        end: end ?? this.end,
        paid: paid ?? this.paid,
      );
}

/// Step 4 — Availability.
class AvailabilityInfo {
  const AvailabilityInfo({
    this.sessionDurationMinutes = 15,
    this.days = const [
      DayAvailability(day: 'Mon', active: true),
      DayAvailability(day: 'Tue', active: true),
      DayAvailability(day: 'Wed', active: true),
      DayAvailability(day: 'Thu', active: true),
      DayAvailability(day: 'Fri', active: true),
      DayAvailability(day: 'Sat'),
      DayAvailability(day: 'Sun'),
    ],
    this.bufferMinutes = 10,
  });

  final int sessionDurationMinutes;
  final List<DayAvailability> days;
  final int bufferMinutes;

  bool get isValid => days.any((d) => d.active);

  AvailabilityInfo copyWith({
    int? sessionDurationMinutes,
    List<DayAvailability>? days,
    int? bufferMinutes,
  }) =>
      AvailabilityInfo(
        sessionDurationMinutes:
            sessionDurationMinutes ?? this.sessionDurationMinutes,
        days: days ?? this.days,
        bufferMinutes: bufferMinutes ?? this.bufferMinutes,
      );
}

/// Step 5 — Payout.
class PayoutInfo {
  const PayoutInfo({
    this.bankCode,
    this.bankName,
    this.accountNumber = '',
    this.resolvedAccountName,
    this.sessionRate = '',
    this.verifiedAt,
  });

  /// Delegated so onboarding and the therapist Edit Profile screen cannot
  /// drift apart. The previous local ceiling of ₦20,000 rejected the
  /// ₦25,000–₦30,000 the seeded therapists charge.
  static const int minSessionRate = SessionRate.min;
  static const int maxSessionRate = SessionRate.max;

  /// Flutterwave bank code — what the API actually keys on. [bankName] is
  /// kept alongside purely for display and because the payout-save endpoint
  /// wants both.
  final String? bankCode;
  final String? bankName;
  final String accountNumber;

  /// Populated by `POST /therapist/payout-account/verify` once [bankCode]
  /// and a well-formed [accountNumber] are both present.
  final String? resolvedAccountName;
  final String sessionRate;
  final String? verifiedAt;

  bool get isAccountValid =>
      accountNumber.length == 10 && int.tryParse(accountNumber) != null;

  bool get isSessionRateValid {
    final amount = int.tryParse(sessionRate);
    return amount != null &&
        amount >= minSessionRate &&
        amount <= maxSessionRate;
  }

  bool get isValid =>
      bankCode != null &&
      isAccountValid &&
      isSessionRateValid &&
      resolvedAccountName != null;

  PayoutInfo copyWith({
    String? bankCode,
    String? bankName,
    String? accountNumber,
    String? resolvedAccountName,
    bool clearResolvedAccountName = false,
    String? sessionRate,
    String? verifiedAt,
  }) =>
      PayoutInfo(
        bankCode: bankCode ?? this.bankCode,
        bankName: bankName ?? this.bankName,
        accountNumber: accountNumber ?? this.accountNumber,
        resolvedAccountName: clearResolvedAccountName
            ? null
            : (resolvedAccountName ?? this.resolvedAccountName),
        sessionRate: sessionRate ?? this.sessionRate,
        verifiedAt: verifiedAt ?? this.verifiedAt,
      );
}
