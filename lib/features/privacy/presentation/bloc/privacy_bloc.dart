import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/features/privacy/data/models/consent_settings.dart';
import 'package:talkam/features/privacy/dormain/repository/privacy_repository.dart';

part 'privacy_event.dart';
part 'privacy_state.dart';

/// Holds the Data & Privacy consent selections.
///
/// The current policy version sent with every save — there's no live source
/// for this yet (the privacy-policy content endpoint doesn't expose one), so
/// it's hardcoded until the backend adds a way to look it up.
const String _kPolicyVersion = '2026-07';

/// Backed by the real `/user/consents` endpoint. Falls back to the last
/// locally-cached selection if the fetch fails (e.g. offline), and mirrors
/// every successful save into that same local cache.
class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  final PrivacyRepository _privacyRepository;

  PrivacyBloc(this._privacyRepository) : super(const PrivacyInitial()) {
    on<LoadConsentsEvent>(_onLoadConsents);
    on<ToggleConsentEvent>(_onToggleConsent);
    on<SaveConsentsEvent>(_onSaveConsents);
  }

  ConsentSettings _settings = const ConsentSettings();

  ConsentSettings get settings => _settings;

  Future<void> _onLoadConsents(
      LoadConsentsEvent event, Emitter<PrivacyState> emit) async {
    emit(const ConsentsLoading());
    try {
      _settings = await _privacyRepository.getConsents();
      emit(ConsentsLoaded(_settings));
    } catch (error) {
      final stored = SessionManager.instance.consentSettings;
      _settings = stored.isEmpty
          ? const ConsentSettings()
          : ConsentSettings.decode(stored);
      emit(ConsentsLoaded(_settings));
    }
  }

  void _onToggleConsent(ToggleConsentEvent event, Emitter<PrivacyState> emit) {
    _settings = _settings.withValue(event.type, event.value);
    emit(ConsentsLoaded(_settings));
  }

  Future<void> _onSaveConsents(
      SaveConsentsEvent event, Emitter<PrivacyState> emit) async {
    emit(const ConsentsSaving());
    try {
      _settings = await _privacyRepository.updateConsents(
        _settings,
        policyVersion: _kPolicyVersion,
      );
      SessionManager.instance.consentSettings = _settings.encode();
      emit(ConsentsSaved(_settings));
    } catch (error) {
      emit(ConsentsFailure(error.toString()));
    }
  }
}
