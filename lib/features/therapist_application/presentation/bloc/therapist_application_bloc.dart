import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/document_upload_tile.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_data.dart';

part 'therapist_application_event.dart';
part 'therapist_application_state.dart';

/// Drives the therapist application wizard (personal info → documents →
/// specialties → availability → payout).
///
/// There is no backend for this flow yet: document uploads and the final
/// submission are simulated locally so the screens are fully interactive
/// while the real endpoints are built. Search this file for "simulated" to
/// find every spot that needs a real API call swapped in.
class TherapistApplicationBloc
    extends Bloc<TherapistApplicationEvent, TherapistApplicationState> {
  TherapistApplicationBloc() : super(TherapistApplicationState()) {
    on<UpdateFullNameEvent>((e, emit) => emit(state.copyWith(
        personalInfo: state.personalInfo.copyWith(fullName: e.value))));
    on<UpdateEmailEvent>((e, emit) => emit(state.copyWith(
        personalInfo: state.personalInfo.copyWith(email: e.value))));
    on<UpdatePhoneEvent>((e, emit) => emit(state.copyWith(
        personalInfo: state.personalInfo.copyWith(phone: e.value))));
    on<UpdateCredentialTypeEvent>((e, emit) => emit(state.copyWith(
        personalInfo:
            state.personalInfo.copyWith(credentialType: e.value))));

    on<StartDocumentUploadEvent>(_onStartUpload);
    on<CancelDocumentUploadEvent>(_onCancelUpload);
    on<RemoveDocumentEvent>(_onRemoveDocument);
    on<DocumentProgressTickEvent>(_onProgressTick);

    on<UpdateBioEvent>((e, emit) => emit(
        state.copyWith(specialties: state.specialties.copyWith(bio: e.value))));
    on<ToggleSpecialtyEvent>(_onToggleSpecialty);

    on<SetSessionDurationEvent>((e, emit) => emit(state.copyWith(
        availability:
            state.availability.copyWith(sessionDurationMinutes: e.minutes))));
    on<ToggleWorkingDayEvent>(_onToggleWorkingDay);
    on<SetWorkingHoursEvent>(_onSetWorkingHours);
    on<ToggleDayPaidEvent>(_onToggleDayPaid);
    on<SetBufferEvent>((e, emit) => emit(state.copyWith(
        availability: state.availability.copyWith(bufferMinutes: e.minutes))));

    on<SetBankNameEvent>((e, emit) =>
        emit(state.copyWith(payout: state.payout.copyWith(bankName: e.value))));
    on<SetAccountNumberEvent>(_onSetAccountNumber);
    on<SetSessionRateEvent>((e, emit) => emit(
        state.copyWith(payout: state.payout.copyWith(sessionRate: e.value))));

    on<SubmitApplicationEvent>(_onSubmit);
  }

  final Random _random = Random();
  final Map<DocumentId, Timer> _uploadTimers = {};

  // ── Documents ──────────────────────────────────────────────────────────

  void _onStartUpload(
      StartDocumentUploadEvent e, Emitter<TherapistApplicationState> emit) {
    _uploadTimers[e.id]?.cancel();

    emit(state.copyWith(
      documents: state.documentsWith(state.document(e.id).copyWith(
        status: DocumentUploadStatus.uploading,
        progress: 0,
        fileName: e.fileName,
      )),
    ));

    // SIMULATED — replace with a real upload call + progress stream once the
    // documents endpoint exists.
    _uploadTimers[e.id] = Timer.periodic(const Duration(milliseconds: 350), (timer) {
      final current = state.document(e.id);
      if (current.status != DocumentUploadStatus.uploading) {
        timer.cancel();
        return;
      }

      // Small chance of a simulated failure so the failure UI is reachable.
      if (_random.nextDouble() < 0.06) {
        timer.cancel();
        add(DocumentProgressTickEvent(e.id, current.progress, failed: true));
        return;
      }

      final next = (current.progress + 0.08 + _random.nextDouble() * 0.1)
          .clamp(0.0, 1.0);
      add(DocumentProgressTickEvent(e.id, next));
      if (next >= 1.0) timer.cancel();
    });
  }

  void _onProgressTick(
      DocumentProgressTickEvent e, Emitter<TherapistApplicationState> emit) {
    final current = state.document(e.id);
    if (current.status != DocumentUploadStatus.uploading) return;

    if (e.failed) {
      emit(state.copyWith(
        documents: state.documentsWith(
            current.copyWith(status: DocumentUploadStatus.failure)),
      ));
      return;
    }

    final isComplete = e.progress >= 1.0;
    emit(state.copyWith(
      documents: state.documentsWith(current.copyWith(
        progress: e.progress,
        status:
            isComplete ? DocumentUploadStatus.success : DocumentUploadStatus.uploading,
      )),
    ));
  }

  void _onCancelUpload(
      CancelDocumentUploadEvent e, Emitter<TherapistApplicationState> emit) {
    _uploadTimers.remove(e.id)?.cancel();
    emit(state.copyWith(
      documents: state.documentsWith(DocumentUpload(id: e.id)),
    ));
  }

  void _onRemoveDocument(
      RemoveDocumentEvent e, Emitter<TherapistApplicationState> emit) {
    _uploadTimers.remove(e.id)?.cancel();
    emit(state.copyWith(
      documents: state.documentsWith(DocumentUpload(id: e.id)),
    ));
  }

  // ── Specialties ────────────────────────────────────────────────────────

  void _onToggleSpecialty(
      ToggleSpecialtyEvent e, Emitter<TherapistApplicationState> emit) {
    final current = List<String>.from(state.specialties.specialties);
    if (current.contains(e.specialty)) {
      current.remove(e.specialty);
    } else {
      current.add(e.specialty);
    }
    emit(state.copyWith(
        specialties: state.specialties.copyWith(specialties: current)));
  }

  // ── Availability ───────────────────────────────────────────────────────

  void _onToggleWorkingDay(
      ToggleWorkingDayEvent e, Emitter<TherapistApplicationState> emit) {
    final days = [
      for (final d in state.availability.days)
        if (d.day == e.day) d.copyWith(active: !d.active) else d,
    ];
    emit(state.copyWith(availability: state.availability.copyWith(days: days)));
  }

  void _onSetWorkingHours(
      SetWorkingHoursEvent e, Emitter<TherapistApplicationState> emit) {
    final days = [
      for (final d in state.availability.days)
        if (d.day == e.day)
          d.copyWith(start: e.start, end: e.end)
        else
          d,
    ];
    emit(state.copyWith(availability: state.availability.copyWith(days: days)));
  }

  void _onToggleDayPaid(
      ToggleDayPaidEvent e, Emitter<TherapistApplicationState> emit) {
    final days = [
      for (final d in state.availability.days)
        if (d.day == e.day) d.copyWith(paid: !d.paid) else d,
    ];
    emit(state.copyWith(availability: state.availability.copyWith(days: days)));
  }

  // ── Payout ─────────────────────────────────────────────────────────────

  void _onSetAccountNumber(
      SetAccountNumberEvent e, Emitter<TherapistApplicationState> emit) {
    // SIMULATED resolution — there is no bank-verification endpoint yet.
    // A well-formed 10-digit number resolves to a placeholder name so the
    // green "resolved" state is reachable; anything else is invalid.
    final isValid = e.value.length == 10 && int.tryParse(e.value) != null;
    emit(state.copyWith(
      payout: state.payout.copyWith(
        accountNumber: e.value,
        resolvedAccountName: isValid ? "ACCOUNT HOLDER NAME" : null,
        clearResolvedAccountName: !isValid,
      ),
    ));
  }

  // ── Submit ─────────────────────────────────────────────────────────────

  Future<void> _onSubmit(
      SubmitApplicationEvent e, Emitter<TherapistApplicationState> emit) async {
    emit(state.copyWith(submitStatus: SubmitStatus.submitting));

    // SIMULATED — replace with the real application-submission call once the
    // therapist-application endpoint exists.
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(submitStatus: SubmitStatus.submitted));
  }

  @override
  Future<void> close() {
    for (final timer in _uploadTimers.values) {
      timer.cancel();
    }
    _uploadTimers.clear();
    return super.close();
  }
}
