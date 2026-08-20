import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/therapist/data/models/availability_slot.dart';
import 'package:talkam/features/therapist/data/models/therapist_editable_profile.dart';
import 'package:talkam/features/therapist/data/therapist_profile_store.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';

part 'therapist_profile_edit_event.dart';
part 'therapist_profile_edit_state.dart';

/// Holds the therapist's Edit Profile draft.
///
/// Screen-scoped: constructed in the screen's `initState` and closed in
/// `dispose`. Deliberately **not** registered in GetIt — a lazy singleton would
/// leak one edit session's unsaved draft into the next time the screen opens.
///
/// Only `name`/`bio`/`yearsExperience`/`sessionRate`/`avatar` are accepted by
/// `POST /therapist/profile/update` — those go through [TherapistRepository].
/// `title`/`specialties`/`availability`/`sessionDurationMinutes` have no
/// backing endpoint yet, so they keep going through [TherapistProfileStore],
/// which writes them to SharedPreferences as before.
class TherapistProfileEditBloc
    extends Bloc<TherapistProfileEditEvent, TherapistProfileEditState> {
  TherapistProfileEditBloc(
      {TherapistProfileStore? store, TherapistRepository? repository})
      : _store = store ?? TherapistProfileStore.instance,
        _repository = repository ?? injector.get<TherapistRepository>(),
        super(_seed(store ?? TherapistProfileStore.instance)) {
    on<LoadTherapistProfileEvent>(_onLoad);

    on<SetFullNameEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(fullName: e.value)));
    on<SetTitleEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(title: e.value)));
    on<SetYearsExperienceEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(yearsExperience: e.value)));
    on<SetBioEvent>((e, emit) => _patch(emit, (d) => d.copyWith(bio: e.value)));
    on<SetAvatarEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(avatarUrl: e.value)));
    on<SetPendingAvatarEvent>((e, emit) =>
        _patch(emit, (d) => d.copyWith(pendingAvatarPath: e.path)));
    on<SetSpecialtiesEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(specialties: e.values)));
    on<SetSessionRateEvent>(
        (e, emit) => _patch(emit, (d) => d.copyWith(sessionRate: e.digits)));

    on<UpsertAvailabilitySlotEvent>(_onUpsertSlot);
    on<RemoveAvailabilitySlotEvent>((e, emit) => _patch(emit,
        (d) => d.copyWith(availability: d.availability.removeById(e.id))));

    on<SaveTherapistProfileEvent>(_onSave);
  }

  final TherapistProfileStore _store;
  final TherapistRepository _repository;

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
    final error = availability.validate(event.slot, replacingId: event.slot.id);

    if (error != null) {
      emit(state.copyWith(slotError: error));
      return;
    }

    emit(state.copyWith(
      draft:
          state.draft.copyWith(availability: availability.upsert(event.slot)),
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
      final draft = state.draft;
      await _repository.updateMyProfile(
        name: draft.fullName.trim(),
        bio: draft.bio.trim(),
        yearsExperience: draft.yearsExperience!,
        sessionRate: draft.rate.amount!,
        avatarPath: draft.pendingAvatarPath,
      );
      // title/specialties/availability/duration have no backing endpoint
      // yet — kept local, same as before the real endpoint landed.
      _store.save(draft);
      if (draft.pendingAvatarPath != null) {
        // The update response doesn't echo back a hosted avatar URL, so
        // re-fetch to pick up the real one rather than keep displaying the
        // local file path app-wide.
        unawaited(_store.fetchFromServer());
      }
      emit(state.copyWith(
        status: TherapistProfileEditStatus.saved,
        // Rebaseline so the screen goes clean without a reload.
        initial: draft,
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
