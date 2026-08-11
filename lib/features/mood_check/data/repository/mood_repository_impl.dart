import 'package:dio/dio.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/mood_check/data/models/mood_checkin_response.dart';
import 'package:talkam/features/mood_check/dormain/repository/mood_repository.dart';

class MoodRepositoryImpl extends MoodRepository {
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  /// The Authorization header is automatically injected by [_AuthInterceptor].
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

  @override
  Future<MoodCheckinResponse> recordMoodCheckin(int mood) async {
    final response = await _v2.call(
      UrlConfigV2.moodCheckins,
      RequestMethod.post,
      formData: FormData.fromMap({"mood": mood}),
      options: _formOptions,
    );

    return MoodCheckinResponse.fromJson(response.data);
  }
}
