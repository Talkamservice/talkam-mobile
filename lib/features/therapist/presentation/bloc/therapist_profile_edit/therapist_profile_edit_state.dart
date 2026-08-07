part of 'therapist_profile_edit_bloc.dart';

enum TherapistProfileEditStatus { initial, ready, saving, saved, failure }

class TherapistProfileEditState extends Equatable {
  const TherapistProfileEditState({
    this.status = TherapistProfileEditStatus.initial,
    this.initial = const TherapistEditableProfile(),
    this.draft = const TherapistEditableProfile(),
    this.saveAttempted = false,
    this.slotError,
    this.errorMessage,
  });

  final TherapistProfileEditStatus status;

  /// The profile as it was when the screen opened — the baseline the dirty
  /// check compares against. Reset to [draft] after a successful save so the
  /// screen goes clean without reloading.
  final TherapistEditableProfile initial;

  final TherapistEditableProfile draft;

  /// True once Save has been pressed. Field-level errors stay hidden until
  /// then, so an untouched form doesn't open covered in red.
  final bool saveAttempted;

  /// Set only when the bloc's defence-in-depth check rejects a slot the sheet
  /// should already have blocked.
  final SlotValidationError? slotError;

  final String? errorMessage;

  bool get hasChanges => draft != initial;

  bool get canSave => hasChanges && draft.isValid;

  TherapistProfileEditState copyWith({
    TherapistProfileEditStatus? status,
    TherapistEditableProfile? initial,
    TherapistEditableProfile? draft,
    bool? saveAttempted,
    SlotValidationError? slotError,
    bool clearSlotError = false,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) =>
      TherapistProfileEditState(
        status: status ?? this.status,
        initial: initial ?? this.initial,
        draft: draft ?? this.draft,
        saveAttempted: saveAttempted ?? this.saveAttempted,
        slotError: clearSlotError ? null : (slotError ?? this.slotError),
        errorMessage:
            clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      );

  @override
  List<Object?> get props => [
        status,
        initial,
        draft,
        saveAttempted,
        slotError,
        errorMessage,
      ];
}
