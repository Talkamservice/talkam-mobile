import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/session/data/models/session_model.dart';
import 'package:talkam/gen/assets.gen.dart';

class SessionCompleteScreen extends StatefulWidget {
  final SessionModel? session;

  const SessionCompleteScreen({super.key, this.session});

  @override
  State<SessionCompleteScreen> createState() => _SessionCompleteScreenState();
}

class _SessionCompleteScreenState extends State<SessionCompleteScreen> {
  int _rating = 3;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _finish() {
    context.goNamed(PageUrl.calendarScreen);
  }

  @override
  Widget build(BuildContext context) {
    final therapistName = widget.session?.therapistName ?? "Dr. Chioma";

    return Scaffold(
      backgroundColor: Pallets.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        24.verticalSpace,
                        const Spacer(),

                        // Completion Icon Container with Sparkles
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
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
                                  size: 48.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                        24.verticalSpace,

                        // Title & Subtitle
                        TextView(
                          text: "Session Completed",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Pallets.boldBlack,
                        ),
                        8.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              color: Pallets.blueBubbleColor,
                              size: 16.w,
                            ),
                            6.horizontalSpace,
                            Flexible(
                              child: TextView(
                                text: "How was your session with $therapistName",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF475569),
                                align: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        24.verticalSpace,

                        // Interactive Star Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            final starIndex = index + 1;
                            final isSelected = starIndex <= _rating;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _rating = starIndex;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: ImageWidget(
                                  imageUrl: isSelected
                                      ? Assets.images.svgV2.ratingStarFilled
                                      : Assets.images.svgV2.ratingStarOutline,
                                  size: 32.w,
                                ),
                              ),
                            );
                          }),
                        ),
                        28.verticalSpace,

                        // Review Input Box
                        Container(
                          height: 120.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Pallets.white,
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: TextField(
                            controller: _reviewController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText:
                                  "Leave an optional review for $therapistName...",
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF94A3B8),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        const Spacer(),
                        24.verticalSpace,

                        // Submit & Finish Button
                        CustomButton(
                          onPressed: _finish,
                          text: "Submit & Finish",
                        ),
                        16.verticalSpace,

                        // Skip review Link
                        GestureDetector(
                          onTap: _finish,
                          child: TextView(
                            text: "Skip review",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        24.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
