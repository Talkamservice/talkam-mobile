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
    on<_AvailabilityLoadedEvent>(_onAvailabilityLoaded);

    _loadAvailability();
  }

  final TherapistProfileStore _store;
  final TherapistRepository _repository;

  /// Availability has a real backing endpoint (unlike title/specialties/
  /// duration, still local-only) but the constructor seeds synchronously
  /// from local storage so the form isn't blank on first frame — this
  /// backfills the real server copy once it lands.
  Future<void> _loadAvailability() async {
    try {
      final availability = await _repository.getMyAvailability();
      if (isClosed) return;
      add(_AvailabilityLoadedEvent(availability));
    } catch (error, stack) {
      logger.e(error, stackTrace: stack);
      // Non-blocking — the locally-seeded availability already renders.
    }
  }

  /// Only overwrites the draft if the user hasn't started editing yet, so a
  /// fast typer never loses in-progress changes to a slow response.
  void _onAvailabilityLoaded(
    _AvailabilityLoadedEvent event,
    Emitter<TherapistProfileEditState> emit,
  ) {
    final draftUntouched =
        state.draft.availability == state.initial.availability;
    emit(state.copyWith(
      initial: state.initial.copyWith(availability: event.availability),
      draft: draftUntouched
          ? state.draft.copyWith(availability: event.availability)
          : state.draft,
    ));
  }

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
      var draft = state.draft;
      await _repository.updateMyProfile(
        name: draft.fullName.trim(),
        bio: draft.bio.trim(),
        yearsExperience: draft.yearsExperience!,
        sessionRate: draft.rate.amount!,
        avatarPath: draft.pendingAvatarPath,
      );
      // Availability now has a real endpoint — a full replace, so the
      // server-persisted copy (real ids) becomes the new draft/initial.
      // title/specialties/duration still have no backing endpoint, so they
      // stay local only.
      final savedAvailability =
          await _repository.updateMyAvailability(draft.availability);
      draft = draft.copyWith(availability: savedAvailability);
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
        draft: draft,
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
