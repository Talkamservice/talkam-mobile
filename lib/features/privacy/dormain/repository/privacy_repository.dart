import 'package:talkam/features/privacy/data/models/consent_settings.dart';

abstract class PrivacyRepository {
  Future<ConsentSettings> getConsents();

  Future<ConsentSettings> updateConsents(
    ConsentSettings settings, {
    required String policyVersion,
  });

  /// Returns the privacy policy body (raw HTML from the backend).
  Future<String> getPrivacyPolicy();
}
