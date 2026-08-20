import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/booking/presentation/blocs/booking_cubit/booking_cubit.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/features/session/data/sessions_refresh_signal.dart';
import 'package:talkam/features/session/presentation/widgets/session_action_sheets.dart';
import 'package:talkam/features/therapist/dormain/repository/therapist_repository.dart';
import 'package:talkam/features/therapist/presentation/bloc/therapist_client_cubit/therapist_client_cubit.dart';
import 'package:talkam/gen/assets.gen.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  TherapistClientCubit? _cubit;
  BookingCubit? _bookingCubit;

  bool get _isTherapist => SessionManager.instance.isTherapistAccount;

  @override
  void initState() {
    super.initState();
    if (_isTherapist) {
      _cubit = TherapistClientCubit(injector.get<TherapistRepository>())
        ..getSessions();
    } else {
      _bookingCubit = BookingCubit()..loadMyBookings();
    }
    // This screen sits in a StatefulShellRoute branch that's kept alive
    // across tab switches, so initState only runs once — without this,
    // returning here right after paying for a session would still show
    // whatever list was fetched before the payment.
    SessionsRefreshSignal.value.addListener(_refresh);
  }

  @override
  void dispose() {
    SessionsRefreshSignal.value.removeListener(_refresh);
    _cubit?.close();
    _bookingCubit?.close();
    super.dispose();
  }

  void _refresh() {
    if (_isTherapist) {
      _cubit?.getSessions();
    } else {
      _bookingCubit?.loadMyBookings();
    }
  }

  /// Removes the card immediately (so the screen feels dynamic) and then
  /// reconciles with the server, which moves the cancelled session into
  /// PAST SESSIONS.
  void _onSessionCancelled(String sessionId) {
    if (_isTherapist) {
      _cubit?.removeUpcomingSession(sessionId);
    } else {
      _bookingCubit?.removeUpcomingSession(sessionId);
    }
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    if (_isTherapist) {
      return BlocBuilder<TherapistClientCubit, TherapistClientState>(
        bloc: _cubit,
        builder: (context, state) => _buildScaffold(
          context,
          isTherapist: true,
          loading: state.sessionsStatus == LoadStatus.loading ||
              state.sessionsStatus == LoadStatus.idle,
          error: state.sessionsStatus == LoadStatus.error
              ? state.sessionsError
              : null,
          upcoming:
              state.upcomingSessions.map((e) => e.toSessionModel()).toList(),
          past: state.pastSessions.map((e) => e.toSessionModel()).toList(),
          onRefresh: _refresh,
          onCancelled: _onSessionCancelled,
        ),
      );
    }
    return BlocBuilder<BookingCubit, BookingState>(
      bloc: _bookingCubit,
      builder: (context, state) {
        final loading = state.status == BookingStatus.loading &&
            state.mySessions == null;
        final error = state.status == BookingStatus.error &&
                state.mySessions == null
            ? (state.errorMessage ?? 'Something went wrong')
            : null;
        final upcoming = (state.mySessions?.upcoming ?? [])
            .map((e) => e.toSessionModel())
            .toList();
        final past = (state.mySessions?.past ?? [])
            .map((e) => e.toSessionModel())
            .toList();
        return _buildScaffold(
          context,
          isTherapist: false,
          loading: loading,
          error: error,
          upcoming: upcoming,
          past: past,
          onRefresh: _refresh,
          onCancelled: _onSessionCancelled,
        );
      },
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    required bool isTherapist,
    required bool loading,
    required String? error,
    required List<SessionModel> upcoming,
    required List<SessionModel> past,
    required VoidCallback onRefresh,
    required ValueChanged<String> onCancelled,
  }) {
    final isEmptyState =
        !loading && error == null && upcoming.isEmpty && past.isEmpty;

    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: isTherapist
          ? CustomAppBar(
              titleAlign: TextAlign.start,
              centerTile: false,
              canGoBack: false,
              tittle: isEmptyState
                  ? Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                          ),
                        ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextView(
                              text: "Dr. Adewale K.",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Pallets.boldBlack,
                            ),
                            2.verticalSpace,
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.images.svgV2.checkmarkBadge,
                                  width: 14.w,
                                ),
                                4.horizontalSpace,
                                const TextView(
                                  text: "Verified",
                                  fontSize: 12,
                                  color: Pallets.grey400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : TextView(
                      text: "My sessions",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Pallets.boldBlack,
                    ),
              actions: isEmptyState
                  ? [
                      IconButton(
                        onPressed: () {
                          context.pushNamed(PageUrl.notificationScreen);
                        },
                        icon: Icon(
                          Icons.notifications_none_outlined,
                          color: Pallets.boldBlack,
                          size: 24.w,
                        ),
                      ),
                      12.horizontalSpace,
                    ]
                  : null,
            )
          : CustomAppBar(
              titleAlign: TextAlign.start,
              centerTile: false,
              canGoBack: false,
              tittle: TextView(
                text: "My sessions",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlack,
              ),
            ),
      body: loading
          ? Center(child: CustomDialogs.getLoading(size: 50))
          : error != null
              ? Center(
                  child: TextView(
                    text: error,
                    fontSize: 14,
                    color: Pallets.grey400,
                    align: TextAlign.center,
                  ),
                )
              : isEmptyState
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          // Empty State Box
                          Container(
                            width: 140.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: const Color(0xFFCBD5E1),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.sentiment_dissatisfied_rounded,
                                size: 40.w,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                          20.verticalSpace,
                          const TextView(
                            text: "No sessions yet",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Pallets.boldBlack,
                          ),
                          8.verticalSpace,
                          TextView(
                            text: isTherapist
                                ? "Your profile is live and viable to clients. Bookings will appear here once a client schedules with you"
                                : "Book a session with a therapist and it'll show up here",
                            fontSize: 14,
                            color: Pallets.grey400,
                            align: TextAlign.center,
                            lineHeight: 1.4,
                          ),
                          const Spacer(),

                          // Set Availability (therapist) / Find a Therapist (consumer) Card
                          GestureDetector(
                            onTap: isTherapist
                                ? null
                                : () => context
                                    .pushNamed(PageUrl.therapistListScreen),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                    color: const Color(0xFFF1F5F9)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48.w,
                                    height: 48.w,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF64748B),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isTherapist
                                          ? Icons.calendar_month_outlined
                                          : Icons.search_rounded,
                                      color: Colors.white,
                                      size: 24.w,
                                    ),
                                  ),
                                  14.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: isTherapist
                                              ? "Set your availability"
                                              : "Find a therapist",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Pallets.boldBlack,
                                        ),
                                        4.verticalSpace,
                                        TextView(
                                          text: isTherapist
                                              ? "Clients can only see open slots"
                                              : "Book your first session",
                                          fontSize: 13,
                                          color: Pallets.grey400,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: Pallets.grey400,
                                    size: 24.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          24.verticalSpace,
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.verticalSpace,

                            // UPCOMING Section
                            if (upcoming.isNotEmpty) ...[
                              TextView(
                                text: "UPCOMING",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF475569),
                              ),
                              12.verticalSpace,
                              if (isTherapist)
                                ...upcoming.map((s) => Padding(
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      child: _TherapistUpcomingCard(
                                        session: s,
                                        onRefresh: onRefresh,
                                        onCancelled: onCancelled,
                                      ),
                                    ))
                              else ...[
                                _UpcomingCardOne(
                                  session: upcoming[0],
                                  isTherapist: isTherapist,
                                ),
                                if (upcoming.length > 1) ...[
                                  16.verticalSpace,
                                  _UpcomingCardTwo(
                                    session: upcoming[1],
                                    onRefresh: onRefresh,
                                    onCancelled: onCancelled,
                                  ),
                                ],
                              ],
                              28.verticalSpace,
                            ],

                            // PAST SESSIONS Section
                            if (past.isNotEmpty) ...[
                              TextView(
                                text: "PAST SESSIONS",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF475569),
                              ),
                              12.verticalSpace,
                              ...past.map((s) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: _PastSessionCard(session: s),
                                );
                              }),
                              40.verticalSpace,
                            ],
                          ],
                        ),
                      ),
                    ),
    );
  }
}

class _UpcomingCardOne extends StatelessWidget {
  final SessionModel session;
  final bool isTherapist;

  const _UpcomingCardOne({required this.session, this.isTherapist = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBF5FB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextView(
                    text: session.initial,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallets.blueBubbleColor,
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: session.therapistName,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Pallets.boldBlack,
                    ),
                    4.verticalSpace,
                    TextView(
                      text: "${session.displayDate} • ${session.displayTime}",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          CustomButton(
            onPressed: () {
              if (isTherapist) {
                context.pushNamed(
                  PageUrl.sessionPrepScreen,
                  extra: session,
                );
              } else {
                context.pushNamed(
                  PageUrl.sessionRoomScreen,
                  extra: session,
                );
              }
            },
            text: isTherapist ? "Join session" : "View session",
          ),
        ],
      ),
    );
  }
}

/// One upcoming session row for the therapist's own list — unlike the
/// consumer mock (which only ever shows two hand-picked cards), a therapist
/// can have any number of upcoming sessions, so every item gets the same
/// consistent card instead of a position-based variant.
class _TherapistUpcomingCard extends StatelessWidget {
  final SessionModel session;
  final VoidCallback onRefresh;
  final ValueChanged<String> onCancelled;

  const _TherapistUpcomingCard({
    required this.session,
    required this.onRefresh,
    required this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    final canJoin = session.status == 'confirmed';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBF5FB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextView(
                    text: session.initial,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallets.blueBubbleColor,
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: session.therapistName,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Pallets.boldBlack,
                    ),
                    4.verticalSpace,
                    TextView(
                      text: "${session.displayDate} • ${session.displayTime}",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
              if (!canJoin)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: TextView(
                    text: session.status ?? '',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFD97706),
                  ),
                ),
            ],
          ),
          16.verticalSpace,
          if (canJoin)
            CustomButton(
              onPressed: () {
                context.pushNamed(PageUrl.sessionPrepScreen, extra: session);
              },
              text: "Join session",
            ),
          if (canJoin) 12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    SessionActionSheets.showCancelSheet(
                      context,
                      session,
                      onSuccess: () => onCancelled(session.id),
                    );
                  },
                  bgColor: const Color(0xFFF8FAFC),
                  child: TextView(
                    text: "Cancel",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    SessionActionSheets.showRescheduleSheet(
                      context,
                      session,
                      onSuccess: onRefresh,
                    );
                  },
                  text: "Reschedule",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpcomingCardTwo extends StatelessWidget {
  final SessionModel session;
  final VoidCallback onRefresh;
  final ValueChanged<String> onCancelled;

  const _UpcomingCardTwo({
    required this.session,
    required this.onRefresh,
    required this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBF5FB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextView(
                    text: session.initial,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallets.blueBubbleColor,
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: session.therapistName,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Pallets.boldBlack,
                    ),
                    4.verticalSpace,
                    TextView(
                      text: "${session.displayDate} • ${session.displayTime}",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    SessionActionSheets.showCancelSheet(
                      context,
                      session,
                      onSuccess: () => onCancelled(session.id),
                    );
                  },
                  bgColor: const Color(0xFFF8FAFC),
                  child: TextView(
                    text: "Cancel",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    SessionActionSheets.showRescheduleSheet(
                      context,
                      session,
                      onSuccess: onRefresh,
                    );
                  },
                  text: "Reschedule",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PastSessionCard extends StatelessWidget {
  final SessionModel session;

  const _PastSessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final isUnpaid = session.status == 'pending_payment';
    final priceStr =
        "₦${session.price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}";

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBF5FB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextView(
                    text: session.initial,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Pallets.blueBubbleColor,
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: session.therapistName,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Pallets.boldBlack,
                    ),
                    4.verticalSpace,
                    TextView(
                      text: "${session.displayDate} • ${session.format}",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),
              TextView(
                text: priceStr,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlack,
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: ImageWidget(
                          imageUrl: index < session.rating.floor()
                              ? Assets.images.svgV2.starFilled
                              : Assets.images.svgV2.star)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (isUnpaid) {
                    SessionActionSheets.showCompletePaymentSheet(context, session);
                  } else {
                    SessionActionSheets.showReceiptSheet(context, session);
                  }
                },
                child: TextView(
                  text: isUnpaid ? "Complete payment" : "View receipt",
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isUnpaid ? const Color(0xFFD97706) : const Color(0xFF059669),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
