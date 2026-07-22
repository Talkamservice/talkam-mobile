import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  State<UserTypeSelectionScreen> createState() =>
      _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  // 0 for "I need support", 1 for "I'm a mental health pro"
  int _selectedType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              // Headline
              const TextView(
                text: "How will you use Talkam",
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Pallets.boldBlackV2,
                align: TextAlign.left,
              ),
              8.verticalSpace,
              // Subtitle
              const TextView(
                text: "Choose your experience to get started",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Pallets.grey400,
                align: TextAlign.left,
              ),
              32.verticalSpace,

              // Option 1: I need support
              _buildSelectionCard(
                index: 0,
                title: "I need support",
                description:
                    "Browse the community anonymously, find a therapist, or book a session.",
                iconAsset: Assets.images.svgs.user3,
              ),

              24.verticalSpace,

              // Option 2: I'm a mental health pro
              _buildSelectionCard(
                index: 1,
                title: "I'm a mental health pro",
                description:
                    "Apply to join our verified therapist network and start seeing clients.",
                iconAsset: Assets.images.svgs.brain,
              ),

              const Spacer(),

              // Continue Button
              CustomButton(
                elevation: 0,
                onPressed: () {
                  // TODO: Handle navigation based on _selectedType
                },
                bgColor: Pallets.blueBubbleColor,
                borderRadius: BorderRadius.circular(24.r),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: TextView(
                  text: _selectedType == 0
                      ? "Continue as User"
                      : "Continue as Pro",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required int index,
    required String title,
    required String description,
    required String iconAsset,
  }) {
    final bool isSelected = _selectedType == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Pallets.blueBubbleColor.withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? Pallets.blueBubbleColor : Pallets.grey90,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon Container
                Container(
                  height: 48.w,
                  width: 48.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Pallets.blueBubbleColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: SvgPicture.asset(
                    iconAsset,
                    colorFilter: const ColorFilter.mode(
                      Pallets.blueBubbleColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                // Radio Button
                Container(
                  height: 24.w,
                  width: 24.w,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color:
                          isSelected ? Pallets.blueBubbleColor : Pallets.grey90,
                      width: isSelected ? 2 : 1.5,
                    ),
                  ),
                  child: isSelected
                      ? Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Pallets.blueBubbleColor,
                          ),
                        )
                      : null,
                ),
              ],
            ),
            16.verticalSpace,
            TextView(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Pallets.boldBlackV2,
              align: TextAlign.left,
            ),
            8.verticalSpace,
            TextView(
              text: description,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Pallets.grey400,
              align: TextAlign.left,
              lineHeight: 1.4,
            ),
          ],
        ),
      ),
    );
  }
}
