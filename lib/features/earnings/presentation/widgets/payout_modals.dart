import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';

/// [stillPending] is true when the payout hadn't resolved by the time the
/// client stopped polling — the ledger debit already happened and the
/// transfer is genuinely in flight, so this still reads as a success state,
/// just with adjusted copy rather than a hard "done".
void showSuccessModal(BuildContext context, {bool stillPending = false}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96.w,
                height: 96.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0FDF4),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: const Color(0xFF0F9D58),
                    size: 48.w,
                  ),
                ),
              ),
              24.verticalSpace,
              TextView(
                text: stillPending
                    ? "Payout Initiated"
                    : "Transaction Successful",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlackV2,
              ),
              8.verticalSpace,
              const TextView(
                text: "You'll receive your payment shortly",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
              ),
              32.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                    context.pop(); // Go back to Earnings Screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallets.primary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: const TextView(
                    text: "Back to home",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// [onRetry] re-initiates the withdrawal — a failed payout reverses the
/// ledger debit server-side, so retrying is just withdrawing again.
void showFailedModal(BuildContext context, {required VoidCallback onRetry}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96.w,
                height: 96.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF2F2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: const Color(0xFFEF4444),
                    size: 48.w,
                  ),
                ),
              ),
              24.verticalSpace,
              const TextView(
                text: "Transaction Failed",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Pallets.boldBlackV2,
              ),
              8.verticalSpace,
              const TextView(
                text: "Your balance has been restored. You can try again.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
              ),
              32.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                    onRetry();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: const TextView(
                    text: "Try again",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
