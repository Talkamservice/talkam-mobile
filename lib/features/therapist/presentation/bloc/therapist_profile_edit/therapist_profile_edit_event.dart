part of 'therapist_profile_edit_bloc.dart';

/// `Set*` for scalar fields, `Upsert*`/`Remove*` for collection operations.
sealed class TherapistProfileEditEvent extends Equatable {
  const TherapistProfileEditEvent();

  @override
  List<Object?> get props => const [];
}

/// Seeds the draft from the stored profile. Dispatched once, from initState.
class LoadTherapistProfileEvent extends TherapistProfileEditEvent {
  const LoadTherapistProfileEvent();
}

class SetFullNameEvent extends TherapistProfileEditEvent {
  const SetFullNameEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class SetTitleEvent extends TherapistProfileEditEvent {
  const SetTitleEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class SetYearsExperienceEvent extends TherapistProfileEditEvent {
  const SetYearsExperienceEvent(this.value);
  final int value;
  @override
  List<Object?> get props => [value];
}

class SetBioEvent extends TherapistProfileEditEvent {
  const SetBioEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class SetAvatarEvent extends TherapistProfileEditEvent {
  const SetAvatarEvent(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

class SetSpecialtiesEvent extends TherapistProfileEditEvent {
  const SetSpecialtiesEvent(this.values);
  final List<String> values;
  @override
  List<Object?> get props => [values];
}

/// Digits only — the field strips its own separators before dispatching.
class SetSessionRateEvent extends TherapistProfileEditEvent {
  const SetSessionRateEvent(this.digits);
  final String digits;
  @override
  List<Object?> get props => [digits];
}

/// Adds a window, or replaces the existing one with the same id.
class UpsertAvailabilitySlotEvent extends TherapistProfileEditEvent {
  const UpsertAvailabilitySlotEvent(this.slot);
  final AvailabilitySlot slot;
  @override
  List<Object?> get props => [slot];
}

class RemoveAvailabilitySlotEvent extends TherapistProfileEditEvent {
  const RemoveAvailabilitySlotEvent(this.id);
  final String id;
  @override
  List<Object?> get props => [id];
}

class SaveTherapistProfileEvent extends TherapistProfileEditEvent {
  const SaveTherapistProfileEvent();
}
