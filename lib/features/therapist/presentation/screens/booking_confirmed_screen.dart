import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: AppBar(
        backgroundColor: Pallets.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Pallets.boldBlack,
            size: 20.w,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              10.verticalSpace,
              // Step Progress Bar
              const StepProgressBar(
                step: 3,
                totalSteps: 3,
                label: "CONFIRMED",
                customPercentage: 1.0,
              ),
              28.verticalSpace,

              // Green Check Circle Icon
              Container(
                width: 90.w,
                height: 90.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F9F0),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFDCFCE7),
                    width: 6.w,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check_rounded,
                    color: const Color(0xFF10B981),
                    size: 46.w,
                  ),
                ),
              ),
              20.verticalSpace,

              // Title: Booking Confirmed
              TextView(
                text: "Booking Confirmed",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlack,
              ),
              8.verticalSpace,

              // Rich Subtitle
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF475569),
                    height: 1.4,
                  ),
                  children: const [
                    TextSpan(text: "Your session with "),
                    TextSpan(
                      text: "Dr. Amaka Osei",
                      style: TextStyle(
                        color: Pallets.blueBubbleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: " is confirmed for "),
                    TextSpan(
                      text: "Today at 9:00AM",
                      style: TextStyle(
                        color: Pallets.blueBubbleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

              // Summary Box Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4FBFF),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: const [
                    _SummaryRow(label: "Therapist", value: "Dr Amaka Osei"),
                    _SummaryRow(label: "Date", value: "Today, 2 july"),
                    _SummaryRow(label: "Time", value: "9:00 AM"),
                    _SummaryRow(label: "Format", value: "Video call"),
                    _SummaryRow(label: "Duration", value: "50 minutes"),
                    _SummaryRow(label: "Amount Paid", value: "₦15,000"),
                    _SummaryRow(
                      label: "Transaction ID",
                      value: "#FLW-TK-29471",
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              16.verticalSpace,

              // Notice Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFF59E0B)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: const Color(0xFFD97706),
                      size: 20.w,
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: TextView(
                        text:
                            "You'll get a push reminder 30 minutes before your session",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFD97706),
                        lineHeight: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

              // Buttons
              CustomButton(
                onPressed: () {
                  context.pop();
                },
                text: "View my sessions",
              ),
              16.verticalSpace,
              GestureDetector(
                onTap: () {
                  context.goNamed(PageUrl.homeScreen);
                },
                child: TextView(
                  text: "Back to home",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: label,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
              TextView(
                text: value,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ],
          ),
        ),
        if (showDivider)
          Container(
            height: 1,
            color: const Color(0xFFE2E8F0),
          ),
      ],
    );
  }
}
