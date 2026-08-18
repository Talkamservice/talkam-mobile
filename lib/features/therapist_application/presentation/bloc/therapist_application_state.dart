part of 'therapist_application_bloc.dart';

enum SubmitStatus { idle, submitting, submitted, error }

/// Generic save lifecycle reused across the steps that persist via a single
/// "Save and Continue"/"Continue" tap (personal, specialties, availability).
enum StepSaveStatus { idle, saving, success, error }

class TherapistApplicationState extends Equatable {
  TherapistApplicationState({
    this.personalInfo = const PersonalInfo(),
    List<DocumentUpload>? documents,
    this.specialties = const SpecialtiesInfo(),
    this.availability = const AvailabilityInfo(),
    this.payout = const PayoutInfo(),
    this.personalSaveStatus = StepSaveStatus.idle,
    this.personalSaveError,
    this.specialtiesSaveStatus = StepSaveStatus.idle,
    this.specialtiesSaveError,
    this.availabilitySaveStatus = StepSaveStatus.idle,
    this.availabilitySaveError,
    this.banks = const [],
    this.banksLoading = false,
    this.banksError,
    this.verifyingAccount = false,
    this.verifyError,
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

  final StepSaveStatus personalSaveStatus;
  final String? personalSaveError;
  final StepSaveStatus specialtiesSaveStatus;
  final String? specialtiesSaveError;
  final StepSaveStatus availabilitySaveStatus;
  final String? availabilitySaveError;

  final List<TherapistBank> banks;
  final bool banksLoading;
  final String? banksError;
  final bool verifyingAccount;
  final String? verifyError;

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
    StepSaveStatus? personalSaveStatus,
    String? personalSaveError,
    StepSaveStatus? specialtiesSaveStatus,
    String? specialtiesSaveError,
    StepSaveStatus? availabilitySaveStatus,
    String? availabilitySaveError,
    List<TherapistBank>? banks,
    bool? banksLoading,
    String? banksError,
    bool? verifyingAccount,
    String? verifyError,
    SubmitStatus? submitStatus,
    String? submitError,
  }) =>
      TherapistApplicationState(
        personalInfo: personalInfo ?? this.personalInfo,
        documents: documents ?? this.documents,
        specialties: specialties ?? this.specialties,
        availability: availability ?? this.availability,
        payout: payout ?? this.payout,
        personalSaveStatus: personalSaveStatus ?? this.personalSaveStatus,
        personalSaveError: personalSaveError,
        specialtiesSaveStatus:
            specialtiesSaveStatus ?? this.specialtiesSaveStatus,
        specialtiesSaveError: specialtiesSaveError,
        availabilitySaveStatus:
            availabilitySaveStatus ?? this.availabilitySaveStatus,
        availabilitySaveError: availabilitySaveError,
        banks: banks ?? this.banks,
        banksLoading: banksLoading ?? this.banksLoading,
        banksError: banksError,
        verifyingAccount: verifyingAccount ?? this.verifyingAccount,
        verifyError: verifyError,
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
        personalInfo.credentialType,
        personalInfo.yearsExperience,
        documents,
        specialties.bio,
        specialties.specialties,
        availability.sessionDurationMinutes,
        availability.days,
        availability.bufferMinutes,
        payout.bankCode,
        payout.bankName,
        payout.accountNumber,
        payout.resolvedAccountName,
        payout.sessionRate,
        payout.verifiedAt,
        personalSaveStatus,
        personalSaveError,
        specialtiesSaveStatus,
        specialtiesSaveError,
        availabilitySaveStatus,
        availabilitySaveError,
        banks,
        banksLoading,
        banksError,
        verifyingAccount,
        verifyError,
        submitStatus,
        submitError,
      ];
}
