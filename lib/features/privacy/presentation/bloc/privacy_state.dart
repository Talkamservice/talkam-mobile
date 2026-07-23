part of 'privacy_bloc.dart';

abstract class PrivacyState extends Equatable {
  const PrivacyState();

  @override
  List<Object?> get props => [];
}

class PrivacyInitial extends PrivacyState {
  const PrivacyInitial();
}

class ConsentsLoading extends PrivacyState {
  const ConsentsLoading();
}

/// Current selection, re-emitted on every toggle.
class ConsentsLoaded extends PrivacyState {
  const ConsentsLoaded(this.settings);

  final ConsentSettings settings;

  @override
  List<Object?> get props => [settings];
}

class ConsentsSaving extends PrivacyState {
  const ConsentsSaving();
}

class ConsentsSaved extends PrivacyState {
  const ConsentsSaved(this.settings);

  final ConsentSettings settings;

  @override
  List<Object?> get props => [settings];
}

class ConsentsFailure extends PrivacyState {
  const ConsentsFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
