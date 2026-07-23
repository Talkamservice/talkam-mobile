part of 'therapist_application_bloc.dart';

enum SubmitStatus { idle, submitting, submitted, error }

class TherapistApplicationState extends Equatable {
  TherapistApplicationState({
    this.personalInfo = const PersonalInfo(),
    List<DocumentUpload>? documents,
    this.specialties = const SpecialtiesInfo(),
    this.availability = const AvailabilityInfo(),
    this.payout = const PayoutInfo(),
    this.submitStatus = SubmitStatus.idle,
    this.submitError,
  }) : documents = documents ??
            DocumentId.values
                .map((id) => DocumentUpload(id: id))
                .toList(growable: false);

  final PersonalInfo personalInfo;
  final List<DocumentUpload> documents;
  final SpecialtiesInfo specialties;
  final AvailabilityInfo availability;
  final PayoutInfo payout;
  final SubmitStatus submitStatus;
  final String? submitError;

  DocumentUpload document(DocumentId id) =>
      documents.firstWhere((d) => d.id == id);

  bool get allDocumentsUploaded =>
      documents.every((d) => d.status == DocumentUploadStatus.success);

  TherapistApplicationState copyWith({
    PersonalInfo? personalInfo,
    List<DocumentUpload>? documents,
    SpecialtiesInfo? specialties,
    AvailabilityInfo? availability,
    PayoutInfo? payout,
    SubmitStatus? submitStatus,
    String? submitError,
  }) =>
      TherapistApplicationState(
        personalInfo: personalInfo ?? this.personalInfo,
        documents: documents ?? this.documents,
        specialties: specialties ?? this.specialties,
        availability: availability ?? this.availability,
        payout: payout ?? this.payout,
        submitStatus: submitStatus ?? this.submitStatus,
        submitError: submitError,
      );

  /// Replaces a single document by id, leaving the rest of the list intact.
  List<DocumentUpload> documentsWith(DocumentUpload updated) => [
        for (final d in documents)
          if (d.id == updated.id) updated else d,
      ];

  @override
  List<Object?> get props => [
        personalInfo.fullName,
        personalInfo.email,
        personalInfo.phone,
        personalInfo.credentialType,
        documents,
        specialties.bio,
        specialties.specialties,
        availability.sessionDurationMinutes,
        availability.days,
        availability.bufferMinutes,
        payout.bankName,
        payout.accountNumber,
        payout.resolvedAccountName,
        payout.sessionRate,
        submitStatus,
        submitError,
      ];
}
