part of 'privacy_bloc.dart';

abstract class PrivacyEvent extends Equatable {
  const PrivacyEvent();
}

/// Reads the stored consents, or an all-off default on first run.
class LoadConsentsEvent extends PrivacyEvent {
  const LoadConsentsEvent();

  @override
  List<Object?> get props => [];
}

/// Flips a single consent without persisting it.
class ToggleConsentEvent extends PrivacyEvent {
  const ToggleConsentEvent(this.type, this.value);

  final ConsentType type;
  final bool value;

  @override
  List<Object?> get props => [type, value];
}

/// Persists the current selection.
class SaveConsentsEvent extends PrivacyEvent {
  const SaveConsentsEvent();

  @override
  List<Object?> get props => [];
}
