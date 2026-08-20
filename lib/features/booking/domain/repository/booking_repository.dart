import 'package:talkam/features/booking/data/models/booking_response.dart';
import 'package:talkam/features/booking/data/models/initiate_payment_data.dart';
import 'package:talkam/features/booking/data/models/my_sessions_response.dart';
import 'package:talkam/features/booking/data/models/session_cancel_result.dart';
import 'package:talkam/features/booking/data/models/session_join.dart';
import 'package:talkam/features/booking/data/models/session_receipt.dart';
import 'package:talkam/features/booking/data/models/session_reschedule.dart';
import 'package:talkam/features/booking/data/models/session_request_item.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/booking/data/models/therapist_review_item.dart';
import 'package:talkam/features/booking/data/models/therapist_slots_response.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';

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

  /// POST /user/bookings/request-top-up — employee-side "notify my admin"
  /// action when the org session cap is reached.
  Future<void> requestTopUp();

  /// POST /user/bookings/:id/session-mood — phase is 'pre' or 'post', mood
  /// is an integer within MoodConstants::MIN..MAX.
  Future<void> saveSessionMood(
    int bookingId, {
    required String phase,
    required int mood,
  });

  /// GET /user/bookings/:id/receipt
  Future<SessionReceipt> getReceipt(int bookingId);

  /// POST /user/bookings/:id/cancel
  Future<SessionCancelResult> cancelBooking(int bookingId, {String? reason});

  /// POST /user/bookings/:id/reschedule — reason must be one of
  /// [RescheduleReason.all].
  Future<SessionReschedule> requestReschedule(
    int bookingId, {
    required String newStartsAt,
    required String reason,
  });

  /// POST /reschedules/:id/respond — action is 'accept' or 'decline'.
  Future<SessionReschedule> respondToReschedule(
    int rescheduleId, {
    required String action,
  });

  /// GET /user/bookings/:id/join
  Future<SessionJoinDetails> joinSession(int bookingId);

  /// POST /user/bookings/:id/message — opens (or reuses) the messaging
  /// thread tied to this booking, resolving the counterpart server-side.
  Future<TalkamConversation> startSessionConversation(int bookingId);

  /// GET /user/session-requests — a client's own preferred-time requests
  /// still pending or with a proposed slot awaiting response.
  Future<List<SessionRequestItem>> getSessionRequests();

  /// POST /user/session-requests — submitted when no real slot works yet.
  Future<SessionRequestResult> submitSessionRequest({
    required int therapistId,
    required String format,
    required String preferredAt,
    String? note,
  });

  /// POST /user/session-requests/:id/decline — turns down a therapist's
  /// proposed time; releases the unpaid hold the same way cancelling does.
  Future<SessionRequestResult> declineSessionRequest(int requestId);
}
