import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/features/session/presentation/widgets/session_action_sheets.dart';
import 'package:talkam/gen/assets.gen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final upcoming = MockSessionData.upcomingSessions;
    final past = MockSessionData.pastSessions;

    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: CustomAppBar(
        titleAlign: TextAlign.start,
        centerTile: false,
        tittle: TextView(
          text: "My sessions",
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Pallets.boldBlack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,

              // UPCOMING Section
              TextView(
                text: "UPCOMING",
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF475569),
              ),
              12.verticalSpace,

              // Upcoming Session 1
              _UpcomingCardOne(session: upcoming[0]),
              16.verticalSpace,

              // Upcoming Session 2
              _UpcomingCardTwo(session: upcoming[1]),
              28.verticalSpace,

              // PAST SESSIONS Section
              TextView(
                text: "PAST SESSIONS",
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF475569),
              ),
              12.verticalSpace,

              // Past Sessions List
              ...past.map((s) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _PastSessionCard(session: s),
                );
              }),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingCardOne extends StatelessWidget {
  final SessionModel session;

  const _UpcomingCardOne({required this.session});

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
              context.pushNamed(
                PageUrl.sessionRoomScreen,
                extra: session,
              );
            },
            text: "View session",
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
