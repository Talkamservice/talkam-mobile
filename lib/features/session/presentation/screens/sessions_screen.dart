import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/features/session/presentation/widgets/session_action_sheets.dart';
import 'package:talkam/gen/assets.gen.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTherapist = SessionManager.instance.isTherapistAccount;
    final upcoming = isTherapist
        ? MockSessionData.therapistUpcomingSessions
        : MockSessionData.upcomingSessions;
    final past = isTherapist
        ? MockSessionData.therapistPastSessions
        : MockSessionData.pastSessions;

    final isEmptyState = upcoming.isEmpty && past.isEmpty;

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
      body: isEmptyState
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
                  const TextView(
                    text:
                        "Your profile is live and viable to clients. Bookings will appear here once a client schedules with you",
                    fontSize: 14,
                    color: Pallets.grey400,
                    align: TextAlign.center,
                    lineHeight: 1.4,
                  ),
                  const Spacer(),

                  // Set Availability Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
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
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 24.w,
                          ),
                        ),
                        14.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextView(
                                text: "Set your availability",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Pallets.boldBlack,
                              ),
                              4.verticalSpace,
                              const TextView(
                                text: "Clients can only see open slots",
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
                      _UpcomingCardOne(
                        session: upcoming[0],
                        isTherapist: isTherapist,
                      ),
                      if (upcoming.length > 1) ...[
                        16.verticalSpace,
                        _UpcomingCardTwo(session: upcoming[1]),
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

class _UpcomingCardTwo extends StatelessWidget {
  final SessionModel session;

  const _UpcomingCardTwo({required this.session});

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
                    SessionActionSheets.showCancelSheet(context, session);
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
                    SessionActionSheets.showRescheduleSheet(context, session);
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
                    child: ImageWidget(imageUrl:
                    index < session.rating.floor()
                        ? Assets.images.svgV2.starFilled
                        : Assets.images.svgV2.star
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // View receipt action
                },
                child: TextView(
                  text: "View receipt",
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF059669),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
