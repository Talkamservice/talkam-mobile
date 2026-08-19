import 'package:talkam/features/booking/data/models/booking_response.dart';
import 'package:talkam/features/booking/data/models/initiate_payment_data.dart';
import 'package:talkam/features/booking/data/models/my_sessions_response.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/booking/data/models/therapist_review_item.dart';
import 'package:talkam/features/booking/data/models/therapist_slots_response.dart';

abstract class BookingRepository {
  /// GET /user/therapists
  Future<TherapistDirectoryResponse> getTherapists({
    String? search,
    int? specialtyId,
    String sort = 'rating',
    int page = 1,
  });

  /// GET /user/therapists/:id
  Future<TherapistProfileDetail> getTherapistProfile(int therapistId);

  /// GET /user/therapists/:id/slots?date=Y-m-d
  Future<TherapistSlotsResponse> getTherapistSlots(int therapistId, String date);

  /// GET /user/therapists/:id/reviews
  Future<TherapistReviewsResponse> getTherapistReviews(int therapistId);

  /// POST /user/bookings
  Future<BookingResponse> createBooking({
    required int therapistId,
    required String startsAt,
    required String format,
    String? notes,
  });

  /// GET /user/bookings
  Future<MySessionsResponse> getMyBookings();

  /// GET /user/bookings/:id
  Future<BookingResponse> getBookingDetail(int bookingId);

  /// POST /user/bookings/:id/initiate-payment
  Future<InitiatePaymentData> initiatePayment(int bookingId);

  /// POST /finance/payments/callback
  Future<void> paymentCallback(String reference);

  /// POST /user/bookings/:id/review
  Future<void> reviewSession(
    int bookingId, {
    required int rating,
    String? comment,
  });
}
