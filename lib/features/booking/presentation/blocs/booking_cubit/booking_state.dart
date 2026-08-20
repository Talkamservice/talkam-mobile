part of 'booking_cubit.dart';

enum BookingStatus {
  initial,
  loading,
  directoryLoaded,
  profileLoaded,
  slotsLoaded,
  bookingCreated,
  paymentInitiated,
  paymentSuccess,
  paymentFailed,
  mySessionsLoaded,
  topUpRequested,
  moodSaved,
  receiptLoaded,
  cancelled,
  rescheduleRequested,
  rescheduleResponded,
  joinReady,
  conversationReady,
  sessionRequestsLoaded,
  sessionRequestSubmitted,
  sessionRequestDeclined,
  error,
}

class BookingState {
  final BookingStatus status;
  final String? errorMessage;

  // Directory
  final List<TherapistDirectoryItem>? therapists;
  final bool canLoadMore;
  final int currentPage;

  // Profile & slots
  final TherapistProfileDetail? profile;
  final TherapistSlotsResponse? slotsResponse;
  final TherapistReviewsResponse? reviews;

  // Selected slot & format (carries through step 1 → review)
  final TherapistSlot? selectedSlot;

  /// Null until the user explicitly picks one — there is no default format.
  final String? selectedFormat;
  final String? notes;

  // Created booking
  final BookingResponse? booking;

  // My sessions
  final MySessionsResponse? mySessions;

  // Session detail actions
  final SessionReceipt? receipt;
  final SessionCancelResult? cancelResult;
  final SessionReschedule? reschedule;
  final SessionJoinDetails? joinDetails;
  final TalkamConversation? conversation;

  // Session requests (preferred-time asks)
  final List<SessionRequestItem>? sessionRequests;

  const BookingState({
    this.status = BookingStatus.initial,
    this.errorMessage,
    this.therapists,
    this.canLoadMore = false,
    this.currentPage = 1,
    this.profile,
    this.slotsResponse,
    this.reviews,
    this.selectedSlot,
    this.selectedFormat,
    this.notes,
    this.booking,
    this.mySessions,
    this.receipt,
    this.cancelResult,
    this.reschedule,
    this.joinDetails,
    this.conversation,
    this.sessionRequests,
  });

  BookingState copyWith({
    BookingStatus? status,
    String? errorMessage,
    List<TherapistDirectoryItem>? therapists,
    bool? canLoadMore,
    int? currentPage,
    TherapistProfileDetail? profile,
    TherapistSlotsResponse? slotsResponse,
    TherapistReviewsResponse? reviews,
    TherapistSlot? selectedSlot,
    String? selectedFormat,
    bool resetSelectedFormat = false,
    String? notes,
    BookingResponse? booking,
    MySessionsResponse? mySessions,
    SessionReceipt? receipt,
    SessionCancelResult? cancelResult,
    SessionReschedule? reschedule,
    SessionJoinDetails? joinDetails,
    TalkamConversation? conversation,
    List<SessionRequestItem>? sessionRequests,
  }) =>
      BookingState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        therapists: therapists ?? this.therapists,
        canLoadMore: canLoadMore ?? this.canLoadMore,
        currentPage: currentPage ?? this.currentPage,
        profile: profile ?? this.profile,
        slotsResponse: slotsResponse ?? this.slotsResponse,
        reviews: reviews ?? this.reviews,
        selectedSlot: selectedSlot ?? this.selectedSlot,
        selectedFormat:
            resetSelectedFormat ? null : selectedFormat ?? this.selectedFormat,
        notes: notes ?? this.notes,
        booking: booking ?? this.booking,
        mySessions: mySessions ?? this.mySessions,
        receipt: receipt ?? this.receipt,
        cancelResult: cancelResult ?? this.cancelResult,
        reschedule: reschedule ?? this.reschedule,
        joinDetails: joinDetails ?? this.joinDetails,
        conversation: conversation ?? this.conversation,
        sessionRequests: sessionRequests ?? this.sessionRequests,
      );
}
