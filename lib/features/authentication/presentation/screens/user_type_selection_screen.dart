import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  State<UserTypeSelectionScreen> createState() =>
      _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  static const int _typeUser = 0;
  static const int _typeTherapist = 1;

  /// Null until the user picks — the Continue button stays disabled.
  int? _selectedType;

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
              // Headline
              const TextView(
                text: "How will you use Talkam",
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Pallets.boldBlackV2,
                align: TextAlign.left,
              ),
              4.verticalSpace,
              // Subtitle
              const TextView(
                text: "Choose your experience to get started",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Pallets.grey400,
                align: TextAlign.left,
              ),
              24.verticalSpace,

              // Option 1: I need support
              _buildSelectionCard(
                index: _typeUser,
                title: "I need support",
                description:
                    "Browse the community anonymously, find a therapist, or book a session.",
                iconAsset: Assets.images.svgs.user3,
              ),

              12.verticalSpace,

              // Option 2: I'm a mental health pro
              _buildSelectionCard(
                index: _typeTherapist,
                title: "I'm a mental health pro",
                description:
                    "Apply to join our verified therapist network and start seeing clients.",
                iconAsset: Assets.images.svgs.brain,
              ),

              24.verticalSpace,

              // Continue Button
              CustomButton(
                elevation: 0,
                onPressed: _selectedType == null ? null : _continue,
                child: TextView(
                  text: _selectedType == _typeTherapist
                      ? "Continue as Therapist"
                      : "Continue as User",
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

  void _continue() {
    if (_selectedType == _typeUser) {
      context.pushNamed(PageUrl.interestsScreen);
      return;
    }

    context.pushNamed(PageUrl.therapistOnboardingScreen);
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
          borderRadius: BorderRadius.circular(35.r),
          border: Border.all(
            color: isSelected ? Pallets.blueBubbleColor : Pallets.grey90,
            width: 1.0,
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
                  child: ImageWidget(
                    imageUrl: iconAsset,
                    size: 24.w,
                    color: Pallets.blueBubbleColor,
                  ),
                ),
                // Radio Button
                Container(
                  height: 34.w,
                  width: 34.w,
                  padding: EdgeInsets.all(6.w),
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
