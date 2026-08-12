part of 'therapist_application_bloc.dart';

abstract class TherapistApplicationEvent extends Equatable {
  const TherapistApplicationEvent();

  @override
  List<Object?> get props => [];
}

class ResetSaveStatusesEvent extends TherapistApplicationEvent {
  const ResetSaveStatusesEvent();
}

// ── Step 1 — Personal information ─────────────────────────────────────────

class UpdateFullNameEvent extends TherapistApplicationEvent {
  const UpdateFullNameEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class UpdateEmailEvent extends TherapistApplicationEvent {
  const UpdateEmailEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class UpdatePhoneEvent extends TherapistApplicationEvent {
  const UpdatePhoneEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class UpdateCredentialTypeEvent extends TherapistApplicationEvent {
  const UpdateCredentialTypeEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class UpdateYearsExperienceEvent extends TherapistApplicationEvent {
  const UpdateYearsExperienceEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

/// Persists Step 1 via `POST /therapist/application/personal`.
class SavePersonalInfoEvent extends TherapistApplicationEvent {
  const SavePersonalInfoEvent();
}

// ── Step 2 — Documents ─────────────────────────────────────────────────────

/// Uploads [filePath] for [id] via `POST /therapist/application/documents`.
/// [expiresAt] (Y-m-d) is only sent for the licence document.
class UploadDocumentEvent extends TherapistApplicationEvent {
  const UploadDocumentEvent(this.id, this.filePath, this.fileName,
      {this.expiresAt});
  final DocumentId id;
  final String filePath;
  final String fileName;
  final String? expiresAt;
  @override
  List<Object?> get props => [id, filePath, fileName, expiresAt];
}

/// Internal — dispatched by the bloc's own upload call as progress arrives.
class DocumentProgressTickEvent extends TherapistApplicationEvent {
  const DocumentProgressTickEvent(this.id, this.progress);
  final DocumentId id;
  final double progress;
  @override
  List<Object?> get props => [id, progress];
}

/// Removes an uploaded document. Calls
/// `DELETE /therapist/application/documents/{id}` when the document has a
/// server id (i.e. it was actually uploaded), otherwise just clears local
/// state (nothing to delete server-side).
class RemoveDocumentEvent extends TherapistApplicationEvent {
  const RemoveDocumentEvent(this.id);
  final DocumentId id;
  @override
  List<Object?> get props => [id];
}

// ── Step 3 — Specialties ───────────────────────────────────────────────────

class UpdateBioEvent extends TherapistApplicationEvent {
  const UpdateBioEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class ToggleSpecialtyEvent extends TherapistApplicationEvent {
  const ToggleSpecialtyEvent(this.specialtyId);
  final int specialtyId;
  @override
  List<Object?> get props => [specialtyId];
}

/// Persists Step 3 via `POST /therapist/application/specialties`.
class SaveSpecialtiesEvent extends TherapistApplicationEvent {
  const SaveSpecialtiesEvent();
}

// ── Step 4 — Availability ──────────────────────────────────────────────────

class SetSessionDurationEvent extends TherapistApplicationEvent {
  const SetSessionDurationEvent(this.minutes);
  final int minutes;
  @override
  List<Object?> get props => [minutes];
}

class ToggleWorkingDayEvent extends TherapistApplicationEvent {
  const ToggleWorkingDayEvent(this.day);
  final String day;
  @override
  List<Object?> get props => [day];
}

class SetWorkingHoursEvent extends TherapistApplicationEvent {
  const SetWorkingHoursEvent(this.day, {this.start, this.end});
  final String day;
  final TimeOfDay? start;
  final TimeOfDay? end;
  @override
  List<Object?> get props => [day, start, end];
}

class ToggleDayPaidEvent extends TherapistApplicationEvent {
  const ToggleDayPaidEvent(this.day);
  final String day;
  @override
  List<Object?> get props => [day];
}

class SetBufferEvent extends TherapistApplicationEvent {
  const SetBufferEvent(this.minutes);
  final int minutes;
  @override
  List<Object?> get props => [minutes];
}

/// Persists Step 4 via `POST /therapist/application/availability`.
class SaveAvailabilityEvent extends TherapistApplicationEvent {
  const SaveAvailabilityEvent();
}

// ── Step 5 — Payout ─────────────────────────────────────────────────────────

/// Fetches the Flutterwave bank list — cheap to re-fetch since it's cached
/// 6h server-side, but the bloc only calls the repository once per instance.
class LoadBanksEvent extends TherapistApplicationEvent {
  const LoadBanksEvent();
}

class SetBankEvent extends TherapistApplicationEvent {
  const SetBankEvent({required this.code, required this.name});
  final String code;
  final String name;
  @override
  List<Object?> get props => [code, name];
}

class SetAccountNumberEvent extends TherapistApplicationEvent {
  const SetAccountNumberEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

/// Resolves the account name via `POST /therapist/payout-account/verify`.
/// Dispatched once a bank and a well-formed account number are both set —
/// see [TherapistPayoutScreen]'s debounce.
class VerifyAccountEvent extends TherapistApplicationEvent {
  const VerifyAccountEvent();
}

class SetSessionRateEvent extends TherapistApplicationEvent {
  const SetSessionRateEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

// ── Submission ──────────────────────────────────────────────────────────────

/// Saves Step 5 (`POST /therapist/application/payout`) then, on success,
/// submits the whole application (`POST /therapist/application/submit`).
class SubmitApplicationEvent extends TherapistApplicationEvent {
  const SubmitApplicationEvent();
}
