import 'package:dio/dio.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/therapist_application/data/models/therapist_application_response.dart';
import 'package:talkam/features/therapist_application/dormain/repository/therapist_application_repository.dart';

class TherapistApplicationRepositoryImpl
    extends TherapistApplicationRepository {
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  /// Form-data requests must build their own [Options] so Dio can infer the
  /// multipart content type (the default options force `application/json`).
  /// The Authorization header is automatically injected by the network
  /// service's auth interceptor.
  Options get _formOptions => Options(headers: {
        "Accept": "application/json",
      });

  @override
  Future<TherapistApplicationStepsResponse> getApplicationStatus() async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistApplicationStatus,
        RequestMethod.get,
      );

      return TherapistApplicationStepsResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistApplicationStepsResponse> savePersonal({
    required String credentialType,
    required int yearsExperience,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistApplicationPersonal,
        RequestMethod.post,
        formData: FormData.fromMap({
          "credential_type": credentialType,
          "years_experience": yearsExperience,
        }),
        options: _formOptions,
      );

      return TherapistApplicationStepsResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistDocumentResponse> uploadDocument({
    required String type,
    required String filePath,
    required String fileName,
    String? expiresAt,
    void Function(int sent, int total)? onSendProgress,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistApplicationDocuments,
        RequestMethod.upload,
        formData: FormData.fromMap({
          "type": type,
          "file": await MultipartFile.fromFile(filePath, filename: fileName),
          if (expiresAt != null) "expires_at": expiresAt,
        }),
        options: _formOptions,
        onSendProgress: onSendProgress,
      );

      return TherapistDocumentResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteDocument(String documentId) async {
    try {
      await _v2.call(
        UrlConfigV2.therapistApplicationDocument(documentId),
        RequestMethod.delete,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistSpecialtiesResponse> saveSpecialties({
    required String bio,
    required List<int> specialtyIds,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistApplicationSpecialties,
        RequestMethod.post,
        data: {
          "bio": bio,
          "specialties": specialtyIds,
        },
      );

      return TherapistSpecialtiesResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistAvailabilityResponse> saveAvailability({
    required int sessionDuration,
    required int bufferMinutes,
    required List<TherapistDayPayload> days,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistApplicationAvailability,
        RequestMethod.post,
        data: {
          "session_duration": sessionDuration,
          "buffer_minutes": bufferMinutes,
          "days": days.map((d) => d.toJson()).toList(),
        },
      );

      return TherapistAvailabilityResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TherapistBank>> getBanks() async {
    try {
      final response =
          await _v2.call(UrlConfigV2.therapistBanks, RequestMethod.get);

      return List<TherapistBank>.from((response.data['data'] as List)
          .map((b) => TherapistBank.fromJson(b)));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistVerifyAccountResponse> verifyAccount({
    required String bankCode,
    required String accountNumber,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistVerifyAccount,
        RequestMethod.post,
        formData: FormData.fromMap({
          "bank_code": bankCode,
          "account_number": accountNumber,
        }),
        options: _formOptions,
      );

      return TherapistVerifyAccountResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistPayoutResponse> savePayout({
    required String bankCode,
    required String bankName,
    required String accountNumber,
    required int sessionRate,
  }) async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistApplicationPayout,
        RequestMethod.post,
        formData: FormData.fromMap({
          "bank_code": bankCode,
          "bank_name": bankName,
          "account_number": accountNumber,
          "session_rate": sessionRate,
        }),
        options: _formOptions,
      );

      return TherapistPayoutResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TherapistSubmitResponse> submitApplication() async {
    try {
      final response = await _v2.call(
        UrlConfigV2.therapistApplicationSubmit,
        RequestMethod.post,
      );

      return TherapistSubmitResponse.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
