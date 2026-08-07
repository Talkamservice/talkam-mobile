import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/privacy/data/models/consent_settings.dart';
import 'package:talkam/features/privacy/dormain/repository/privacy_repository.dart';

class PrivacyRepositoryImpl extends PrivacyRepository {
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  @override
  Future<ConsentSettings> getConsents() async {
    final response = await _v2.call(UrlConfigV2.getConsents, RequestMethod.get);
    return ConsentSettings.fromApiJson(response.data['data']);
  }

  @override
  Future<ConsentSettings> updateConsents(
    ConsentSettings settings, {
    required String policyVersion,
  }) async {
    final response = await _v2.call(
      UrlConfigV2.updateConsents,
      RequestMethod.post,
      data: {
        "consents": settings.toJson(),
        "policy_version": policyVersion,
      },
    );
    return ConsentSettings.fromApiJson(response.data['data']);
  }

  @override
  Future<String> getPrivacyPolicy() async {
    final response =
        await _v2.call(UrlConfigV2.privacyPolicies, RequestMethod.get);
    return response.data['data']['body'] ?? '';
  }
}
