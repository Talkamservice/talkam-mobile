import 'package:talkam/features/therapist_application/data/models/therapist_application_response.dart';

abstract class TherapistApplicationRepository {
  /// Fetches the overall application status and 5-step completeness map.
  Future<TherapistApplicationStepsResponse> getApplicationStatus();

  /// Step 1 — creates/updates the draft. Session rate is ignored here; it's
  /// collected on the Payout step.
  Future<TherapistApplicationStepsResponse> savePersonal({
    required String credentialType,
    required int yearsExperience,
  });

  /// Step 2 — one document per call; re-uploading the same [type] replaces
  /// it. [expiresAt] is only meaningful for the `licence` type.
  Future<TherapistDocumentResponse> uploadDocument({
    required String type,
    required String filePath,
    required String fileName,
    String? expiresAt,
    void Function(int sent, int total)? onSendProgress,
  });

  Future<void> deleteDocument(String documentId);

  /// Step 3 — [specialtyIds] are interest-topic ids from
  /// `GET /user/interest-topics`.
  Future<TherapistSpecialtiesResponse> saveSpecialties({
    required String bio,
    required List<int> specialtyIds,
  });

  /// Step 4.
  Future<TherapistAvailabilityResponse> saveAvailability({
    required int sessionDuration,
    required int bufferMinutes,
    required List<TherapistDayPayload> days,
  });

  /// Flutterwave bank list, cached 6h server-side.
  Future<List<TherapistBank>> getBanks();

  /// Live Flutterwave resolution — returns the account name, persists
  /// nothing server-side.
  Future<TherapistVerifyAccountResponse> verifyAccount({
    required String bankCode,
    required String accountNumber,
  });

  /// Step 5 — re-verifies the account server-side and saves it with the
  /// session rate. No BVN is collected or stored.
  Future<TherapistPayoutResponse> savePayout({
    required String bankCode,
    required String bankName,
    required String accountNumber,
    required int sessionRate,
  });

  /// Validates all steps are complete and moves the draft to submitted.
  Future<TherapistSubmitResponse> submitApplication();
}
