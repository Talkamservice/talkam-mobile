import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';
import 'package:talkam/features/session/data/models/session_model.dart';

class TherapistActionDialogs {
  static void showSessionAcceptedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F8F0),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: const Color(0xFF0F9C5B),
                      size: 40.w,
                    ),
                  ),
                ),
                16.verticalSpace,
                const TextView(
                  text: "Session Accepted",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlack,
                  align: TextAlign.center,
                ),
                8.verticalSpace,
                const TextView(
                  text:
                      "You have accepted a session. You can continue using the service without delay.",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Pallets.grey400,
                  align: TextAlign.center,
                  lineHeight: 1.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSessionDeclinedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBEAEA),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: const Color(0xFFE53935),
                      size: 40.w,
                    ),
                  ),
                ),
                16.verticalSpace,
                const TextView(
                  text: "Session Declined",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlack,
                  align: TextAlign.center,
                ),
                8.verticalSpace,
                const TextView(
                  text: "You have declined your session",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Pallets.grey400,
                  align: TextAlign.center,
                  lineHeight: 1.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showSessionRequestBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) {
        return const _SessionRequestSheet();
      },
    );
  }

  static void showDeclineReasonBottomSheet(BuildContext context, {SessionModel? session}) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) {
        return _DeclineReasonSheet(session: session);
      },
    );
  }
}

class _DeclineReasonSheet extends StatefulWidget {
  final SessionModel? session;

  const _DeclineReasonSheet({this.session});

  @override
  State<_DeclineReasonSheet> createState() => _DeclineReasonSheetState();
}

class _DeclineReasonSheetState extends State<_DeclineReasonSheet> {
  String? selectedReason;

  final reasons = [
    "Personal emergency",
    "Technical issues",
    "Client request",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        top: 16.h,
        left: 24.w,
        right: 24.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Pallets.grey90,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          24.verticalSpace,
          const TextView(
            text: "Cancel this session?",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
          ),
          8.verticalSpace,
          TextView(
            text: widget.session != null
                ? "${widget.session!.therapistName} • ${widget.session!.displayDate} • ${widget.session!.displayTime}"
                : "Ngozi A. • Wed Jul 16 • 10:00AM",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Pallets.grey400,
          ),
          4.verticalSpace,
          const TextView(
            text: "Cancellations within 24h may affect your rating",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Pallets.grey400,
          ),
          24.verticalSpace,
          const TextView(
            text: "REASON FOR CANCELLATION",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Pallets.grey400,
          ),
          12.verticalSpace,
          ...reasons.map((reason) {
            final isSelected = selectedReason == reason;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedReason = reason;
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Pallets.blueBubbleColor : Pallets.grey90,
                    width: isSelected ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  color: isSelected ? Pallets.blueBubbleColor.withValues(alpha: 0.05) : Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextView(
                        text: reason,
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? Pallets.blueBubbleColor : Pallets.boldBlack,
                      ),
                    ),
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected ? Pallets.blueBubbleColor : Pallets.grey90,
                      size: 20.w,
                    ),
                  ],
                ),
              ),
            );
          }),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () => Navigator.pop(context),
                  bgColor: const Color(0xFFF7F7F7),
                  elevation: 0,
                  child: const TextView(
                    text: "Keep session",
                    color: Pallets.boldBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: selectedReason == null
                      ? null
                      : () {
                          Navigator.pop(context);
                          TherapistActionDialogs.showSessionDeclinedDialog(context);
                        },
                  bgColor: const Color(0xFFE53935),
                  elevation: 0,
                  child: const TextView(
                    text: "Yes Cancel",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SessionRequestSheet extends StatelessWidget {
  const _SessionRequestSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        top: 16.h,
        left: 24.w,
        right: 24.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Pallets.grey90,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          24.verticalSpace,
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Pallets.blueBubbleColor,
                  shape: BoxShape.circle,
                ),
              ),
              8.horizontalSpace,
              const TextView(
                text: "New Booking Request",
                color: Pallets.blueBubbleColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ],
          ),
          8.verticalSpace,
          const TextView(
            text: "Session request\nfrom Ngozi A.",
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Pallets.boldBlack,
            lineHeight: 1.2,
          ),
          12.verticalSpace,
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Pallets.lightGrey,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F1FC),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const TextView(
                        text: "N",
                        color: Pallets.blueBubbleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            text: "Ngozi A.",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Pallets.boldBlack,
                          ),
                          4.verticalSpace,
                          const TextView(
                            text: "New client • Anxiety • Work Stress",
                            fontSize: 12,
                            color: Pallets.grey400,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F1FC),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: const TextView(
                        text: "New",
                        color: Pallets.blueBubbleColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                const Divider(color: Pallets.grey90, height: 1),
                16.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageWidget(imageUrl: Assets.images.svgV2.calendarInActive, color: Pallets.blueBubbleColor,),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            text: "Wed, Jul 16 • 10:00AM",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Pallets.boldBlack,
                          ),
                          2.verticalSpace,
                          const TextView(
                            text: "Video session • 50 min",
                            fontSize: 12,
                            color: Pallets.grey400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageWidget(imageUrl: Assets.images.svgV2.dollar2, color: Pallets.blueBubbleColor,),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            text: "₦25,000",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Pallets.boldBlack,
                          ),
                          2.verticalSpace,
                          const TextView(
                            text: "You receive: ₦20,000",
                            fontSize: 12,
                            color: Pallets.grey400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "Client's note",
                        color: Color(0xFFD97706),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      8.verticalSpace,
                      const TextView(
                        text: "“Struggling with work anxiety and can't sleep. Looking for CBT approach.”",
                        color: Pallets.grey400,
                        fontSize: 12,
                        lineHeight: 1.5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    TherapistActionDialogs.showDeclineReasonBottomSheet(context);
                  },
                  borderColor: Pallets.grey90,
                  foregroundColor: Pallets.boldBlack,
                  text: "Decline",
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                    TherapistActionDialogs.showSessionAcceptedDialog(context);
                  },
                  bgColor: Pallets.blueBubbleColor,
                  child: const TextView(
                    text: "Accept Session",
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

