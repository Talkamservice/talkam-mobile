import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/step_progress_bar.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

class BookingFailedScreen extends StatelessWidget {
  final String? errorMessage;
  final String? doctorName;
  final String? time;

  const BookingFailedScreen({
    super.key,
    this.errorMessage,
    this.doctorName,
    this.time,
  });

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
      body: Padding(
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
            40.verticalSpace,

            // Red X Circle Icon
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFE4E6),
                  width: 6.w,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.close_rounded,
                  color: const Color(0xFFEF4444),
                  size: 48.w,
                ),
              ),
            ),
            24.verticalSpace,

            // Title: Booking Failed
            TextView(
              text: "Booking Failed",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlack,
            ),
            12.verticalSpace,

            // Rich Description
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF475569),
                  height: 1.4,
                ),
                children: [
                  const TextSpan(text: "Booking with "),
                  TextSpan(
                    text: doctorName ?? "Dr. Amaka Osei",
                    style: const TextStyle(
                      color: Pallets.blueBubbleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: " for "),
                  TextSpan(
                    text: time ?? "9:00 AM",
                    style: const TextStyle(
                      color: Pallets.blueBubbleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(
                    text: " today failed.\nPlease retry or contact support.",
                  ),
                ],
              ),
            ),
            32.verticalSpace,

            // Buttons
            CustomButton(
              onPressed: () {
                context.pop();
              },
              text: "Retry",
            ),
            16.verticalSpace,
            GestureDetector(
              onTap: () {
                // Contact support handler
              },
              child: TextView(
                text: "Contact Support",
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
