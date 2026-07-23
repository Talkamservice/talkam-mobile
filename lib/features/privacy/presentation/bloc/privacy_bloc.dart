import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/privacy/data/models/consent_settings.dart';

part 'privacy_event.dart';
part 'privacy_state.dart';

/// Holds the Data & Privacy consent selections.
///
/// Consents are persisted on-device for now. There is no consent endpoint yet —
/// when one lands, swap the SessionManager reads/writes for a repository call
/// and keep the events/states as they are.
class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  PrivacyBloc() : super(const PrivacyInitial()) {
    on<LoadConsentsEvent>(_onLoadConsents);
    on<ToggleConsentEvent>(_onToggleConsent);
    on<SaveConsentsEvent>(_onSaveConsents);
  }

  ConsentSettings _settings = const ConsentSettings();

  ConsentSettings get settings => _settings;

  void _onLoadConsents(LoadConsentsEvent event, Emitter<PrivacyState> emit) {
    emit(const ConsentsLoading());
    try {
      final stored = SessionManager.instance.consentSettings;
      _settings =
          stored.isEmpty ? const ConsentSettings() : ConsentSettings.decode(stored);
      emit(ConsentsLoaded(_settings));
    } catch (error) {
      _settings = const ConsentSettings();
      emit(ConsentsLoaded(_settings));
    }
  }

  void _onToggleConsent(ToggleConsentEvent event, Emitter<PrivacyState> emit) {
    _settings = _settings.withValue(event.type, event.value);
    emit(ConsentsLoaded(_settings));
  }

  void _onSaveConsents(SaveConsentsEvent event, Emitter<PrivacyState> emit) {
    emit(const ConsentsSaving());
    try {
      SessionManager.instance.consentSettings = _settings.encode();
      emit(ConsentsSaved(_settings));
    } catch (error) {
      emit(ConsentsFailure(error.toString()));
    }
  }
}
