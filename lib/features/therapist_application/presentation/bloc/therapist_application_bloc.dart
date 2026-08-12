import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/document_upload_tile.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_data.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_response.dart';
import 'package:talkam/features/therapist_application/dormain/repository/therapist_application_repository.dart';

part 'therapist_application_event.dart';
part 'therapist_application_state.dart';

/// Drives the therapist application wizard (personal info → documents →
/// specialties → availability → payout) against the real v2 endpoints.
class TherapistApplicationBloc
    extends Bloc<TherapistApplicationEvent, TherapistApplicationState> {
  TherapistApplicationBloc(this._repository)
      : super(TherapistApplicationState()) {
    on<ResetSaveStatusesEvent>((e, emit) => emit(state.copyWith(
          personalSaveStatus: StepSaveStatus.idle,
          specialtiesSaveStatus: StepSaveStatus.idle,
          availabilitySaveStatus: StepSaveStatus.idle,
        )));
    on<UpdateFullNameEvent>((e, emit) => emit(state.copyWith(
        personalSaveStatus: StepSaveStatus.idle,
        personalInfo: state.personalInfo.copyWith(fullName: e.value))));
    on<UpdateEmailEvent>((e, emit) => emit(state.copyWith(
        personalSaveStatus: StepSaveStatus.idle,
        personalInfo: state.personalInfo.copyWith(email: e.value))));
    on<UpdatePhoneEvent>((e, emit) => emit(state.copyWith(
        personalSaveStatus: StepSaveStatus.idle,
        personalInfo: state.personalInfo.copyWith(phone: e.value))));
    on<UpdateCredentialTypeEvent>((e, emit) => emit(state.copyWith(
        personalSaveStatus: StepSaveStatus.idle,
        personalInfo: state.personalInfo.copyWith(credentialType: e.value))));
    on<UpdateYearsExperienceEvent>((e, emit) => emit(state.copyWith(
        personalSaveStatus: StepSaveStatus.idle,
        personalInfo: state.personalInfo.copyWith(yearsExperience: e.value))));
    on<SavePersonalInfoEvent>(_onSavePersonalInfo);

    on<UploadDocumentEvent>(_onUploadDocument);
    on<DocumentProgressTickEvent>(_onProgressTick);
    on<RemoveDocumentEvent>(_onRemoveDocument);

    on<UpdateBioEvent>((e, emit) => emit(state.copyWith(
        specialtiesSaveStatus: StepSaveStatus.idle,
        specialties: state.specialties.copyWith(bio: e.value))));
    on<ToggleSpecialtyEvent>(_onToggleSpecialty);
    on<SaveSpecialtiesEvent>(_onSaveSpecialties);

    on<SetSessionDurationEvent>((e, emit) => emit(state.copyWith(
        availabilitySaveStatus: StepSaveStatus.idle,
        availability:
            state.availability.copyWith(sessionDurationMinutes: e.minutes))));
    on<ToggleWorkingDayEvent>(_onToggleWorkingDay);
    on<SetWorkingHoursEvent>(_onSetWorkingHours);
    on<ToggleDayPaidEvent>(_onToggleDayPaid);
    on<SetBufferEvent>((e, emit) => emit(state.copyWith(
        availabilitySaveStatus: StepSaveStatus.idle,
        availability: state.availability.copyWith(bufferMinutes: e.minutes))));
    on<SaveAvailabilityEvent>(_onSaveAvailability);

    on<LoadBanksEvent>(_onLoadBanks);
    on<SetBankEvent>((e, emit) => emit(state.copyWith(
            payout: state.payout.copyWith(
          bankCode: e.code,
          bankName: e.name,
          clearResolvedAccountName: true,
        ))));
    on<SetAccountNumberEvent>((e, emit) => emit(state.copyWith(
            payout: state.payout.copyWith(
          accountNumber: e.value,
          clearResolvedAccountName: true,
        ))));
    on<VerifyAccountEvent>(_onVerifyAccount);
    on<SetSessionRateEvent>((e, emit) => emit(
        state.copyWith(payout: state.payout.copyWith(sessionRate: e.value))));

    on<SubmitApplicationEvent>(_onSubmit);
  }

  final TherapistApplicationRepository _repository;

  // ── Step 1 — Personal ──────────────────────────────────────────────────

  Future<void> _onSavePersonalInfo(
      SavePersonalInfoEvent e, Emitter<TherapistApplicationState> emit) async {
    emit(state.copyWith(personalSaveStatus: StepSaveStatus.saving));
    try {
      await _repository.savePersonal(
        credentialType: state.personalInfo.credentialType!,
        yearsExperience: int.parse(state.personalInfo.yearsExperience),
      );
      emit(state.copyWith(personalSaveStatus: StepSaveStatus.success));
    } catch (error) {
      emit(state.copyWith(
        personalSaveStatus: StepSaveStatus.error,
        personalSaveError: error.toString(),
      ));
    }
  }

  // ── Step 2 — Documents ─────────────────────────────────────────────────

  Future<void> _onUploadDocument(
      UploadDocumentEvent e, Emitter<TherapistApplicationState> emit) async {
    emit(state.copyWith(
      documents: state.documentsWith(state.document(e.id).copyWith(
            status: DocumentUploadStatus.uploading,
            progress: 0,
            fileName: e.fileName,
            expiresAt: e.expiresAt,
          )),
    ));

    try {
      final response = await _repository.uploadDocument(
        type: e.id.apiValue,
        filePath: e.filePath,
        fileName: e.fileName,
        expiresAt: e.expiresAt,
        onSendProgress: (sent, total) {
          if (total <= 0) return;
          add(DocumentProgressTickEvent(e.id, sent / total));
        },
      );

      final current = state.document(e.id);
      if (current.status != DocumentUploadStatus.uploading) return;
      emit(state.copyWith(
        documents: state.documentsWith(current.copyWith(
          status: DocumentUploadStatus.success,
          progress: 1,
          serverId: response.id,
        )),
      ));
    } catch (error) {
      final current = state.document(e.id);
      if (current.status != DocumentUploadStatus.uploading) return;
      emit(state.copyWith(
        documents: state.documentsWith(
            current.copyWith(status: DocumentUploadStatus.failure)),
      ));
    }
  }

  void _onProgressTick(
      DocumentProgressTickEvent e, Emitter<TherapistApplicationState> emit) {
    final current = state.document(e.id);
    if (current.status != DocumentUploadStatus.uploading) return;
    emit(state.copyWith(
      documents: state.documentsWith(
          current.copyWith(progress: e.progress.clamp(0.0, 0.99))),
    ));
  }

  Future<void> _onRemoveDocument(
      RemoveDocumentEvent e, Emitter<TherapistApplicationState> emit) async {
    final current = state.document(e.id);
    final serverId = current.serverId;

    emit(state.copyWith(
      documents: state.documentsWith(DocumentUpload(id: e.id)),
    ));

    if (serverId != null) {
      try {
        await _repository.deleteDocument(serverId.toString());
      } catch (_) {
        // The tile already reset locally; a stray server-side document from
        // a failed delete isn't worth surfacing here — the user can just
        // re-upload, which replaces it (documents endpoint is upsert-by-type).
      }
    }
  }

  // ── Step 3 — Specialties ───────────────────────────────────────────────

  void _onToggleSpecialty(
      ToggleSpecialtyEvent e, Emitter<TherapistApplicationState> emit) {
    final current = List<int>.from(state.specialties.specialties);
    if (current.contains(e.specialtyId)) {
      current.remove(e.specialtyId);
    } else {
      current.add(e.specialtyId);
    }
    emit(state.copyWith(
        specialtiesSaveStatus: StepSaveStatus.idle,
        specialties: state.specialties.copyWith(specialties: current)));
  }

  Future<void> _onSaveSpecialties(
      SaveSpecialtiesEvent e, Emitter<TherapistApplicationState> emit) async {
    emit(state.copyWith(specialtiesSaveStatus: StepSaveStatus.saving));
    try {
      await _repository.saveSpecialties(
        bio: state.specialties.bio,
        specialtyIds: state.specialties.specialties,
      );
      emit(state.copyWith(specialtiesSaveStatus: StepSaveStatus.success));
    } catch (error) {
      emit(state.copyWith(
        specialtiesSaveStatus: StepSaveStatus.error,
        specialtiesSaveError: error.toString(),
      ));
    }
  }

  // ── Step 4 — Availability ───────────────────────────────────────────────

  void _onToggleWorkingDay(
      ToggleWorkingDayEvent e, Emitter<TherapistApplicationState> emit) {
    final days = [
      for (final d in state.availability.days)
        if (d.day == e.day) d.copyWith(active: !d.active) else d,
    ];
    emit(state.copyWith(
        availabilitySaveStatus: StepSaveStatus.idle,
        availability: state.availability.copyWith(days: days)));
  }

  void _onSetWorkingHours(
      SetWorkingHoursEvent e, Emitter<TherapistApplicationState> emit) {
    final days = [
      for (final d in state.availability.days)
        if (d.day == e.day) d.copyWith(start: e.start, end: e.end) else d,
    ];
    emit(state.copyWith(
        availabilitySaveStatus: StepSaveStatus.idle,
        availability: state.availability.copyWith(days: days)));
  }

  void _onToggleDayPaid(
      ToggleDayPaidEvent e, Emitter<TherapistApplicationState> emit) {
    final days = [
      for (final d in state.availability.days)
        if (d.day == e.day) d.copyWith(paid: !d.paid) else d,
    ];
    emit(state.copyWith(
        availabilitySaveStatus: StepSaveStatus.idle,
        availability: state.availability.copyWith(days: days)));
  }

  Future<void> _onSaveAvailability(
      SaveAvailabilityEvent e, Emitter<TherapistApplicationState> emit) async {
    emit(state.copyWith(availabilitySaveStatus: StepSaveStatus.saving));
    try {
      await _repository.saveAvailability(
        sessionDuration: state.availability.sessionDurationMinutes,
        bufferMinutes: state.availability.bufferMinutes,
        days: state.availability.days
            .map((d) => TherapistDayPayload(
                  dayOfWeek: _apiDayName(d.day),
                  active: d.active,
                  startTime: d.active ? _formatTime(d.start) : null,
                  endTime: d.active ? _formatTime(d.end) : null,
                ))
            .toList(),
      );
      emit(state.copyWith(availabilitySaveStatus: StepSaveStatus.success));
    } catch (error) {
      emit(state.copyWith(
        availabilitySaveStatus: StepSaveStatus.error,
        availabilitySaveError: error.toString(),
      ));
    }
  }

  static const Map<String, String> _dayApiNames = {
    'Mon': 'monday',
    'Tue': 'tuesday',
    'Wed': 'wednesday',
    'Thu': 'thursday',
    'Fri': 'friday',
    'Sat': 'saturday',
    'Sun': 'sunday',
  };

  String _apiDayName(String uiDay) =>
      _dayApiNames[uiDay] ?? uiDay.toLowerCase();

  String _formatTime(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  // ── Step 5 — Payout ─────────────────────────────────────────────────────

  Future<void> _onLoadBanks(
      LoadBanksEvent e, Emitter<TherapistApplicationState> emit) async {
    if (state.banks.isNotEmpty || state.banksLoading) return;
    emit(state.copyWith(banksLoading: true, banksError: null));
    try {
      final banks = await _repository.getBanks();
      final sortedBanks = List<TherapistBank>.from(banks)
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      emit(state.copyWith(banks: sortedBanks, banksLoading: false));
    } catch (error) {
      emit(state.copyWith(
        banksLoading: false,
        banksError: error.toString(),
      ));
    }
  }

  Future<void> _onVerifyAccount(
      VerifyAccountEvent e, Emitter<TherapistApplicationState> emit) async {
    final bankCode = state.payout.bankCode;
    if (bankCode == null || !state.payout.isAccountValid) return;

    emit(state.copyWith(verifyingAccount: true, verifyError: null));
    try {
      final response = await _repository.verifyAccount(
        bankCode: bankCode,
        accountNumber: state.payout.accountNumber,
      );
      emit(state.copyWith(
        verifyingAccount: false,
        payout: state.payout.copyWith(
          resolvedAccountName: response.accountName,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        verifyingAccount: false,
        verifyError: error.toString(),
      ));
    }
  }

  // ── Submit ─────────────────────────────────────────────────────────────

  Future<void> _onSubmit(
      SubmitApplicationEvent e, Emitter<TherapistApplicationState> emit) async {
    emit(state.copyWith(submitStatus: SubmitStatus.submitting));

    try {
      final payoutResponse = await _repository.savePayout(
        bankCode: state.payout.bankCode!,
        bankName: state.payout.bankName!,
        accountNumber: state.payout.accountNumber,
        sessionRate: int.parse(state.payout.sessionRate),
      );
      emit(state.copyWith(
        payout: state.payout.copyWith(verifiedAt: payoutResponse.verifiedAt),
      ));

      await _repository.submitApplication();
      emit(state.copyWith(submitStatus: SubmitStatus.submitted));
    } catch (error) {
      emit(state.copyWith(
        submitStatus: SubmitStatus.error,
        submitError: error.toString(),
      ));
    }
  }
}
