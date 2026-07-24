import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/document_upload_tile.dart';

/// Step 1 — Personal Information.
class PersonalInfo {
  const PersonalInfo({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.credentialType,
  });

  final String fullName;
  final String email;
  final String phone;
  final String? credentialType;

  bool get isValid =>
      fullName.trim().isNotEmpty &&
      email.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      credentialType != null;

  PersonalInfo copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? credentialType,
  }) =>
      PersonalInfo(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        credentialType: credentialType ?? this.credentialType,
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
  String get title => switch (this) {
        DocumentId.degreeCertificate => "Degree certificate",
        DocumentId.npaOrMdcnRegistration => "NPA or MDCN registration",
        DocumentId.governmentId => "Government-issued ID",
        DocumentId.professionalIndemnityInsurance =>
          "Professional indemnity insurance",
        DocumentId.professionalHeadshot => "Professional headshot photo",
      };

  String get subtitle => switch (this) {
        DocumentId.degreeCertificate => "BSc or MSc Psychology or related field",
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
  });

  final DocumentId id;
  final DocumentUploadStatus status;

  /// 0..1, meaningful only while [status] is uploading.
  final double progress;
  final String? fileName;

  DocumentUpload copyWith({
    DocumentUploadStatus? status,
    double? progress,
    String? fileName,
  }) =>
      DocumentUpload(
        id: id,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        fileName: fileName ?? this.fileName,
      );
}

/// Step 3 — Specialties.
class SpecialtiesInfo {
  const SpecialtiesInfo({this.bio = '', this.specialties = const []});

  final String bio;
  final List<String> specialties;

  bool get isValid => bio.trim().isNotEmpty && specialties.isNotEmpty;

  SpecialtiesInfo copyWith({String? bio, List<String>? specialties}) =>
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

/// Step 5 — Payout. There is no bank-resolution endpoint yet, so account
/// verification below is a local length check, not a real lookup.
class PayoutInfo {
  const PayoutInfo({
    this.bankName,
    this.accountNumber = '',
    this.resolvedAccountName,
    this.sessionRate = '',
  });

  static const int minSessionRate = 0;
  static const int maxSessionRate = 20000;

  final String? bankName;
  final String accountNumber;
  final String? resolvedAccountName;
  final String sessionRate;

  bool get isAccountValid =>
      accountNumber.length == 10 && int.tryParse(accountNumber) != null;

  bool get isSessionRateValid {
    final amount = int.tryParse(sessionRate);
    return amount != null &&
        amount >= minSessionRate &&
        amount <= maxSessionRate;
  }

  bool get isValid =>
      bankName != null && isAccountValid && isSessionRateValid;

  PayoutInfo copyWith({
    String? bankName,
    String? accountNumber,
    String? resolvedAccountName,
    bool clearResolvedAccountName = false,
    String? sessionRate,
  }) =>
      PayoutInfo(
        bankName: bankName ?? this.bankName,
        accountNumber: accountNumber ?? this.accountNumber,
        resolvedAccountName: clearResolvedAccountName
            ? null
            : (resolvedAccountName ?? this.resolvedAccountName),
        sessionRate: sessionRate ?? this.sessionRate,
      );
}
