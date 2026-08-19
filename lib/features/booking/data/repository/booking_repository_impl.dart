import 'package:dio/dio.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/booking/data/models/booking_response.dart';
import 'package:talkam/features/booking/data/models/initiate_payment_data.dart';
import 'package:talkam/features/booking/data/models/my_sessions_response.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/booking/data/models/therapist_review_item.dart';
import 'package:talkam/features/booking/data/models/therapist_slots_response.dart';
import 'package:talkam/features/booking/domain/repository/booking_repository.dart';

class BookingRepositoryImpl extends BookingRepository {
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  Options get _formOptions => Options(headers: {'Accept': 'application/json'});

  @override
  Future<TherapistDirectoryResponse> getTherapists({
    String? search,
    int? specialtyId,
    String sort = 'rating',
    int page = 1,
  }) async {
    final response = await _v2.call(
      UrlConfigV2.therapistDirectory,
      RequestMethod.get,
      queryParams: {
        if (search != null && search.isNotEmpty) 'search': search,
        if (specialtyId != null) 'specialty_id': specialtyId,
        'sort': sort,
        'page': page,
      },
    );
    final dataMap = response.data['data'] is Map
        ? Map<String, dynamic>.from(response.data['data'] as Map)
        : <String, dynamic>{};
    return TherapistDirectoryResponse.fromJson(dataMap);
  }

  @override
  Future<TherapistProfileDetail> getTherapistProfile(int therapistId) async {
    final response = await _v2.call(
      UrlConfigV2.therapistProfile(therapistId),
      RequestMethod.get,
    );
    final dataMap = response.data['data'] is Map
        ? Map<String, dynamic>.from(response.data['data'] as Map)
        : <String, dynamic>{};
    return TherapistProfileDetail.fromJson(dataMap);
  }

  @override
  Future<TherapistSlotsResponse> getTherapistSlots(
      int therapistId, String date) async {
    final response = await _v2.call(
      UrlConfigV2.therapistSlots(therapistId),
      RequestMethod.get,
      queryParams: {'date': date},
    );
    final dataMap = response.data['data'] is Map
        ? Map<String, dynamic>.from(response.data['data'] as Map)
        : <String, dynamic>{};
    return TherapistSlotsResponse.fromJson(dataMap);
  }

  @override
  Future<TherapistReviewsResponse> getTherapistReviews(int therapistId) async {
    final response = await _v2.call(
      UrlConfigV2.therapistReviews(therapistId),
      RequestMethod.get,
    );
    final dataMap = response.data is Map
        ? Map<String, dynamic>.from(response.data as Map)
        : <String, dynamic>{};
    return TherapistReviewsResponse.fromJson(dataMap);
  }

  @override
  Future<BookingResponse> createBooking({
    required int therapistId,
    required String startsAt,
    required String format,
    String? notes,
  }) async {
    final response = await _v2.call(
      UrlConfigV2.bookings,
      RequestMethod.post,
      formData: FormData.fromMap({
        'therapist_id': therapistId,
        'starts_at': startsAt,
        'format': format,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      }),
      options: _formOptions,
    );
    final dataMap = response.data['data'] is Map
        ? Map<String, dynamic>.from(response.data['data'] as Map)
        : <String, dynamic>{};
    return BookingResponse.fromJson(dataMap);
  }

  @override
  Future<MySessionsResponse> getMyBookings() async {
    final response = await _v2.call(UrlConfigV2.bookings, RequestMethod.get);
    final dataMap = response.data['data'] is Map
        ? Map<String, dynamic>.from(response.data['data'] as Map)
        : <String, dynamic>{};
    return MySessionsResponse.fromJson(dataMap);
  }

  @override
  Future<BookingResponse> getBookingDetail(int bookingId) async {
    final response = await _v2.call(
      UrlConfigV2.bookingDetail(bookingId),
      RequestMethod.get,
    );
    final dataMap = response.data['data'] is Map
        ? Map<String, dynamic>.from(response.data['data'] as Map)
        : <String, dynamic>{};
    return BookingResponse.fromJson(dataMap);
  }

  @override
  Future<InitiatePaymentData> initiatePayment(int bookingId) async {
    final response = await _v2.call(
      UrlConfigV2.initiatePayment(bookingId),
      RequestMethod.post,
    );
    final dataMap = response.data['data'] is Map
        ? Map<String, dynamic>.from(response.data['data'] as Map)
        : <String, dynamic>{};
    return InitiatePaymentData.fromJson(dataMap);
  }

  @override
  Future<void> paymentCallback(String reference) async {
    // Verifies the transaction server-side via Flutterwave. Errors are
    // logged, not rethrown — the caller determines success/failure from the
    // booking's own status (via getBookingDetail) regardless of whether this
    // call itself succeeds.
    try {
      final response = await _v2.call(
        UrlConfigV2.paymentCallback,
        RequestMethod.post,
        formData: FormData.fromMap({'reference': reference}),
        options: _formOptions,
      );
      logger.i('paymentCallback($reference) -> ${response.statusCode}: ${response.data}');
    } catch (e) {
      logger.e('paymentCallback($reference) failed: $e');
    }
  }

  @override
  Future<void> reviewSession(
    int bookingId, {
    required int rating,
    String? comment,
  }) async {
    await _v2.call(
      UrlConfigV2.reviewBooking(bookingId),
      RequestMethod.post,
      formData: FormData.fromMap({
        'rating': rating,
        if (comment != null && comment.isNotEmpty) 'comment': comment,
      }),
      options: _formOptions,
    );
  }
}
