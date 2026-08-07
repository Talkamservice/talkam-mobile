import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:talkam/features/therapist/data/models/therapist_editable_profile.dart';
import 'package:talkam/features/therapist/data/therapist_profile_store.dart';

part 'therapist_profile_edit_event.dart';
part 'therapist_profile_edit_state.dart';

/// Holds the therapist's Edit Profile draft.
///
/// Screen-scoped: constructed in the screen's `initState` and closed in
/// `dispose`. Deliberately **not** registered in GetIt — a lazy singleton would
/// leak one edit session's unsaved draft into the next time the screen opens.
///
/// Persistence goes through [TherapistProfileStore], which writes to
/// SharedPreferences today. When a therapist endpoint lands, swap that call for
/// a repository and leave these events and states untouched.
class TherapistProfileEditBloc
    extends Bloc<TherapistProfileEditEvent, TherapistProfileEditState> {
  TherapistProfileEditBloc({TherapistProfileStore? store})
      : _store = store ?? TherapistProfileStore.instance,
        super(_seed(store ?? TherapistProfileStore.instance)) {
    on<LoadTherapistProfileEvent>(_onLoad);

    on<SetFullNameEvent>((e, emit) => _patch(emit, (d) => d.copyWith(fullName: e.value)));
    on<SetTitleEvent>((e, emit) => _patch(emit, (d) => d.copyWith(title: e.value)));
    on<SetYearsExperienceEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(yearsExperience: e.value)));
    on<SetBioEvent>((e, emit) => _patch(emit, (d) => d.copyWith(bio: e.value)));
    on<SetAvatarEvent>((e, emit) => _patch(emit, (d) => d.copyWith(avatarUrl: e.value)));
    on<SetSpecialtiesEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(specialties: e.values)));
    on<SetSessionRateEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(sessionRate: e.digits)));

    on<UpsertAvailabilitySlotEvent>(_onUpsertSlot);
    on<RemoveAvailabilitySlotEvent>((e, emit) => _patch(
        emit, (d) => d.copyWith(availability: d.availability.removeById(e.id))));

    on<SaveTherapistProfileEvent>(_onSave);
  }

  final TherapistProfileStore _store;

  /// Seeded in the constructor rather than by an event, because events are
  /// processed asynchronously: a screen reading `state.draft` in `initState`
  /// to prime its text controllers would otherwise get the empty state and
  /// render a blank form.
  static TherapistProfileEditState _seed(TherapistProfileStore store) {
    final draft = store.draft;
    return TherapistProfileEditState(
      status: TherapistProfileEditStatus.ready,
      initial: draft,
      draft: draft,
    );
  }

  void _patch(
    Emitter<TherapistProfileEditState> emit,
    TherapistEditableProfile Function(TherapistEditableProfile) change,
  ) {
    emit(state.copyWith(draft: change(state.draft), clearSlotError: true));
  }

  void _onLoad(
    LoadTherapistProfileEvent event,
    Emitter<TherapistProfileEditState> emit,
  ) {
    final draft = _store.draft;
    emit(state.copyWith(
      status: TherapistProfileEditStatus.ready,
      initial: draft,
      draft: draft,
    ));
  }

  /// Re-validates before committing.
  ///
  /// The editor sheet already blocks an invalid window, so this is defence in
  /// depth: it guarantees the invariant "the persisted set never overlaps"
  /// holds regardless of any UI bug.
  void _onUpsertSlot(
    UpsertAvailabilitySlotEvent event,
    Emitter<TherapistProfileEditState> emit,
  ) {
    final availability = state.draft.availability;
    final error =
        availability.validate(event.slot, replacingId: event.slot.id);

    if (error != null) {
      emit(state.copyWith(slotError: error));
      return;
    }

    emit(state.copyWith(
      draft: state.draft
          .copyWith(availability: availability.upsert(event.slot)),
      clearSlotError: true,
    ));
  }

  Future<void> _onSave(
    SaveTherapistProfileEvent event,
    Emitter<TherapistProfileEditState> emit,
  ) async {
    emit(state.copyWith(saveAttempted: true, clearErrorMessage: true));

    if (!state.draft.isValid) {
      // Invalid drafts are surfaced inline by the fields themselves; nothing
      // to report globally, and nothing to write.
      return;
    }

    emit(state.copyWith(status: TherapistProfileEditStatus.saving));
    try {
      _store.save(state.draft);
      emit(state.copyWith(
        status: TherapistProfileEditStatus.saved,
        // Rebaseline so the screen goes clean without a reload.
        initial: state.draft,
      ));
    } catch (error, stack) {
      logger.e(error, stackTrace: stack);
      emit(state.copyWith(
        status: TherapistProfileEditStatus.failure,
        errorMessage: "Couldn't save your profile. Please try again.",
      ));
    }
  }
}
