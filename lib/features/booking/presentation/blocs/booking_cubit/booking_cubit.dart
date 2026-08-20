import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/flutterwave/flutterwave_payment_helper.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/features/booking/data/models/booking_response.dart';
import 'package:talkam/features/booking/data/models/my_sessions_response.dart';
import 'package:talkam/features/booking/data/models/session_cancel_result.dart';
import 'package:talkam/features/booking/data/models/session_join.dart';
import 'package:talkam/features/booking/data/models/session_receipt.dart';
import 'package:talkam/features/booking/data/models/session_reschedule.dart';
import 'package:talkam/features/booking/data/models/session_request_item.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/booking/data/models/therapist_review_item.dart';
import 'package:talkam/features/booking/data/models/therapist_slots_response.dart';
import 'package:talkam/features/booking/domain/repository/booking_repository.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/session/data/sessions_refresh_signal.dart';

part 'booking_state.dart';

String _getErrorMessage(dynamic e) {
  if (e is ApiError) {
    return e.errorDescription ?? 'An error occurred';
  }
  return e.toString();
}

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _repo;

  BookingCubit({BookingRepository? repo})
      : _repo = repo ?? injector<BookingRepository>(),
        super(const BookingState());

  // ─── Therapist Directory ───────────────────────────────────────────────────

  Future<void> loadTherapists({
    String? search,
    int? specialtyId,
    String sort = 'rating',
    bool refresh = true,
  }) async {
    if (refresh) emit(state.copyWith(status: BookingStatus.loading));
    try {
      final page = refresh ? 1 : state.currentPage + 1;
      final result = await _repo.getTherapists(
        search: search,
        specialtyId: specialtyId,
        sort: sort,
        page: page,
      );
      final existing =
          refresh ? <TherapistDirectoryItem>[] : (state.therapists ?? []);
      emit(state.copyWith(
        status: BookingStatus.directoryLoaded,
        therapists: [...existing, ...result.data],
        canLoadMore: result.paginationMeta.canLoadMore,
        currentPage: result.paginationMeta.currentPage,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Therapist Profile ─────────────────────────────────────────────────────

  Future<void> loadTherapistProfile(int therapistId) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final profile = await _repo.getTherapistProfile(therapistId);
      emit(state.copyWith(
        status: BookingStatus.profileLoaded,
        profile: profile,
        // Reset slot/format selection when loading a new profile — the user
        // must explicitly pick a format, there is no default.
        slotsResponse: null,
        selectedSlot: null,
        resetSelectedFormat: true,
      ));
      // Load reviews in the background (non-blocking)
      _loadReviews(therapistId);
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  Future<void> _loadReviews(int therapistId) async {
    try {
      final reviews = await _repo.getTherapistReviews(therapistId);
      emit(state.copyWith(reviews: reviews));
    } catch (_) {
      // Reviews are non-critical — silently fail
    }
  }

  // ─── Slots ─────────────────────────────────────────────────────────────────

  Future<void> loadSlots(int therapistId, String date) async {
    emit(state.copyWith(status: BookingStatus.loading, selectedSlot: null));
    try {
      final slots = await _repo.getTherapistSlots(therapistId, date);
      emit(state.copyWith(
        status: BookingStatus.slotsLoaded,
        slotsResponse: slots,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  void selectSlot(TherapistSlot slot) {
    emit(state.copyWith(selectedSlot: slot));
  }

  void selectFormat(String format) {
    emit(state.copyWith(selectedFormat: format));
  }

  void updateNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  // ─── Booking Creation & Payment ────────────────────────────────────────────

  Future<void> createBooking({
    required int therapistId,
    required String startsAt,
    required String format,
    String? notes,
  }) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final booking = await _repo.createBooking(
        therapistId: therapistId,
        startsAt: startsAt,
        format: format,
        notes: notes,
      );
      emit(state.copyWith(
        status: BookingStatus.bookingCreated,
        booking: booking,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  /// Initiates payment and launches the Flutterwave sheet.
  /// On success → emits [BookingStatus.paymentSuccess] with updated booking.
  /// On failure → emits [BookingStatus.paymentFailed].
  Future<void> initiateAndPay(int bookingId, BuildContext context) async {
    emit(state.copyWith(status: BookingStatus.paymentInitiated));
    try {
      final paymentData = await _repo.initiatePayment(bookingId);

      if (!context.mounted) return;

      final chargeResponse = await PaymentHelper().makePayment(
        context,
        FlutterRequirements(
          amount: paymentData.numericAmount,
          currency: paymentData.currency,
          referenceNumber: paymentData.reference,
          email: paymentData.customer.email,
          fullName: paymentData.customer.name,
          meta: paymentData.meta,
          description: 'TalkAm Therapy Session',
        ),
      );

      // Always verify with the server, regardless of the Flutterwave SDK's
      // local `success` flag — that flag depends on its in-app WebView
      // reaching a redirect page, which can hang or misreport even when the
      // charge went through. The booking's own status (refreshed below) is
      // the source of truth.
      await _repo.paymentCallback(paymentData.reference);
      final updated = await _repo.getBookingDetail(bookingId);

      if (updated.isConfirmed || updated.isCompleted) {
        emit(state.copyWith(
          status: BookingStatus.paymentSuccess,
          booking: updated,
          errorMessage: null,
        ));
        SessionsRefreshSignal.ping();
      } else {
        emit(state.copyWith(
          status: BookingStatus.paymentFailed,
          booking: updated,
          errorMessage: chargeResponse?.success == true
              ? 'Payment is still being confirmed. Please check back shortly.'
              : 'Payment was not completed.',
        ));
      }
    } catch (e) {
      logger.e('Payment error: $e');
      emit(state.copyWith(
        status: BookingStatus.paymentFailed,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  /// Retry payment for a failed booking (re-initiates & re-launches Flutterwave).
  Future<void> retryPayment(int bookingId, BuildContext context) =>
      initiateAndPay(bookingId, context);

  // ─── My Sessions ───────────────────────────────────────────────────────────

  Future<void> loadMyBookings() async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final sessions = await _repo.getMyBookings();
      emit(state.copyWith(
        status: BookingStatus.mySessionsLoaded,
        mySessions: sessions,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  /// Drops a session from the upcoming list right away, so a cancelled
  /// card disappears without waiting on the follow-up [loadMyBookings] refetch.
  void removeUpcomingSession(String sessionId) {
    final id = int.tryParse(sessionId);
    final sessions = state.mySessions;
    if (id == null || sessions == null) return;
    emit(state.copyWith(
      mySessions: MySessionsResponse(
        upcoming: sessions.upcoming.where((s) => s.id != id).toList(),
        past: sessions.past,
        summary: sessions.summary,
      ),
    ));
  }

  // ─── Reviews ───────────────────────────────────────────────────────────────

  Future<void> submitReview(
    int bookingId, {
    required int rating,
    String? comment,
  }) async {
    try {
      await _repo.reviewSession(bookingId, rating: rating, comment: comment);
      // Refresh my sessions so the review CTA disappears
      await loadMyBookings();
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Top-up (employee cap reached) ─────────────────────────────────────────

  Future<void> requestTopUp() async {
    try {
      await _repo.requestTopUp();
      emit(state.copyWith(status: BookingStatus.topUpRequested, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Session mood ──────────────────────────────────────────────────────────

  Future<void> saveSessionMood(
    int bookingId, {
    required String phase,
    required int mood,
  }) async {
    try {
      await _repo.saveSessionMood(bookingId, phase: phase, mood: mood);
      emit(state.copyWith(status: BookingStatus.moodSaved, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Receipt ───────────────────────────────────────────────────────────────

  Future<void> loadReceipt(int bookingId) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final receipt = await _repo.getReceipt(bookingId);
      emit(state.copyWith(
        status: BookingStatus.receiptLoaded,
        receipt: receipt,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Cancel ────────────────────────────────────────────────────────────────

  Future<void> cancelBooking(int bookingId, {String? reason}) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final result = await _repo.cancelBooking(bookingId, reason: reason);
      emit(state.copyWith(
        status: BookingStatus.cancelled,
        cancelResult: result,
        errorMessage: null,
      ));
      // Refresh my sessions so the cancelled booking's new status shows up.
      await loadMyBookings();
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Reschedule ────────────────────────────────────────────────────────────

  Future<void> requestReschedule(
    int bookingId, {
    required String newStartsAt,
    required String reason,
  }) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final reschedule = await _repo.requestReschedule(
        bookingId,
        newStartsAt: newStartsAt,
        reason: reason,
      );
      emit(state.copyWith(
        status: BookingStatus.rescheduleRequested,
        reschedule: reschedule,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  /// [rescheduleId] is the SessionReschedule id (not the booking id) —
  /// it's whatever id came back from [requestReschedule] or a notification.
  Future<void> respondToReschedule(
    int rescheduleId, {
    required String action,
  }) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final reschedule =
          await _repo.respondToReschedule(rescheduleId, action: action);
      emit(state.copyWith(
        status: BookingStatus.rescheduleResponded,
        reschedule: reschedule,
        errorMessage: null,
      ));
      if (action == 'accept') await loadMyBookings();
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Join & message ────────────────────────────────────────────────────────

  Future<void> joinSession(int bookingId) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final details = await _repo.joinSession(bookingId);
      emit(state.copyWith(
        status: BookingStatus.joinReady,
        joinDetails: details,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  Future<void> startSessionConversation(int bookingId) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final conversation = await _repo.startSessionConversation(bookingId);
      emit(state.copyWith(
        status: BookingStatus.conversationReady,
        conversation: conversation,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Session requests (preferred time, no slot fits yet) ──────────────────

  Future<void> loadSessionRequests() async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final requests = await _repo.getSessionRequests();
      emit(state.copyWith(
        status: BookingStatus.sessionRequestsLoaded,
        sessionRequests: requests,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  Future<void> submitSessionRequest({
    required int therapistId,
    required String format,
    required String preferredAt,
    String? note,
  }) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      await _repo.submitSessionRequest(
        therapistId: therapistId,
        format: format,
        preferredAt: preferredAt,
        note: note,
      );
      emit(state.copyWith(
        status: BookingStatus.sessionRequestSubmitted,
        errorMessage: null,
      ));
      await loadSessionRequests();
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  Future<void> declineSessionRequest(int requestId) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      await _repo.declineSessionRequest(requestId);
      emit(state.copyWith(
        status: BookingStatus.sessionRequestDeclined,
        errorMessage: null,
      ));
      await loadSessionRequests();
    } catch (e) {
      emit(state.copyWith(
        status: BookingStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    }
  }

  // ─── Reset ─────────────────────────────────────────────────────────────────

  void reset() => emit(const BookingState());
}
