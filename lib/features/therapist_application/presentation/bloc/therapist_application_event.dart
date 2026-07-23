part of 'therapist_application_bloc.dart';

abstract class TherapistApplicationEvent extends Equatable {
  const TherapistApplicationEvent();

  @override
  List<Object?> get props => [];
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

// ── Step 2 — Documents ─────────────────────────────────────────────────────

/// Kicks off a simulated upload for [id]. There is no upload endpoint yet, so
/// progress and pass/fail are generated locally — see the bloc for details.
class StartDocumentUploadEvent extends TherapistApplicationEvent {
  const StartDocumentUploadEvent(this.id, this.fileName);
  final DocumentId id;
  final String fileName;
  @override
  List<Object?> get props => [id, fileName];
}

class CancelDocumentUploadEvent extends TherapistApplicationEvent {
  const CancelDocumentUploadEvent(this.id);
  final DocumentId id;
  @override
  List<Object?> get props => [id];
}

class RemoveDocumentEvent extends TherapistApplicationEvent {
  const RemoveDocumentEvent(this.id);
  final DocumentId id;
  @override
  List<Object?> get props => [id];
}

/// Internal — dispatched by the bloc's own upload timer, not by the UI.
class DocumentProgressTickEvent extends TherapistApplicationEvent {
  const DocumentProgressTickEvent(this.id, this.progress, {this.failed = false});
  final DocumentId id;
  final double progress;
  final bool failed;
  @override
  List<Object?> get props => [id, progress, failed];
}

// ── Step 3 — Specialties ───────────────────────────────────────────────────

class UpdateBioEvent extends TherapistApplicationEvent {
  const UpdateBioEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class ToggleSpecialtyEvent extends TherapistApplicationEvent {
  const ToggleSpecialtyEvent(this.specialty);
  final String specialty;
  @override
  List<Object?> get props => [specialty];
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

// ── Step 5 — Payout ─────────────────────────────────────────────────────────

class SetBankNameEvent extends TherapistApplicationEvent {
  const SetBankNameEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class SetAccountNumberEvent extends TherapistApplicationEvent {
  const SetAccountNumberEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class SetSessionRateEvent extends TherapistApplicationEvent {
  const SetSessionRateEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

// ── Submission ──────────────────────────────────────────────────────────────

class SubmitApplicationEvent extends TherapistApplicationEvent {
  const SubmitApplicationEvent();
}
