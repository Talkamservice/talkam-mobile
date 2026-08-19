import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/flutterwave/flutterwave_payment_helper.dart';
import 'package:talkam/core/services/network/api_error.dart';
import 'package:talkam/features/booking/data/models/booking_response.dart';
import 'package:talkam/features/booking/data/models/my_sessions_response.dart';
import 'package:talkam/features/booking/data/models/therapist_directory_response.dart';
import 'package:talkam/features/booking/data/models/therapist_review_item.dart';
import 'package:talkam/features/booking/data/models/therapist_slots_response.dart';
import 'package:talkam/features/booking/domain/repository/booking_repository.dart';

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

      if (chargeResponse?.success == true) {
        // Notify server — best effort
        await _repo.paymentCallback(paymentData.reference);
        // Fetch updated booking
        final updated = await _repo.getBookingDetail(bookingId);
        emit(state.copyWith(
          status: BookingStatus.paymentSuccess,
          booking: updated,
          errorMessage: null,
        ));
      } else {
        final updated = await _repo.getBookingDetail(bookingId);
        emit(state.copyWith(
          status: BookingStatus.paymentFailed,
          booking: updated,
          errorMessage: 'Payment was not completed.',
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

  // ─── Reset ─────────────────────────────────────────────────────────────────

  void reset() => emit(const BookingState());
}
