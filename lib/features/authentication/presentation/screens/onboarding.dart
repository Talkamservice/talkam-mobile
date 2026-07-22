import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/theme/pallets.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/data/session_manager.dart';
import '../../../../gen/assets.gen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Talk freely. Be heard.",
      "description":
          "Join thousands of Nigerians sharing journeys anonymously with support.",
      "image": Assets.images.png.frame1.path,
    },
    {
      "title": "Share safely, no judgement",
      "description":
          "Join a community that understands. Post anonymously and find support.",
      "image": Assets.images.png.frame2.path,
    },
    {
      "title": "Access licensed therapists",
      "description":
          "Find a trusted therapist, start a video or voice call, and track your progress in one place.",
      "image": "", // handled manually via Stack
    }
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Widget _buildStackedCards(String imagePath, int count,
      {double? scale, double? vertical}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate dynamic dimensions based on available space
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // The base width of the largest card (e.g., 70% of available width)
        final baseCardWidth = availableWidth * 0.70;

        // The horizontal gap between cards (e.g., 10% of available width)
        final horizontalGap = availableWidth * 0.10;

        // The vertical step between cards (e.g., 5% of available height)
        final verticalGap = (vertical != null)
            ? availableHeight * vertical
            : availableHeight * 0.10;

        return Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: List.generate(count, (index) {
            // index 0 is the back-most card. index `count - 1` is the front-most card.
            final int reverseIndex = count - 1 - index;

            // Dynamic scale (or use the one passed in)
            final double currentScale = scale ?? (1.0 - (0.07));

            // Centralize the horizontal offset mathematically
            final double offsetX = (index - (count - 1) / 2) * -horizontalGap;

            // Push back-cards up
            final double bottomOffset = verticalGap * reverseIndex;

            return Positioned(
              bottom: bottomOffset,
              // The center of the Stack is 0. We shift left/right from the center.
              left: (availableWidth / 2) - (baseCardWidth / 2) + offsetX,
              child: SizedBox(
                width: baseCardWidth * currentScale,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildImageArea(int index) {
    if (index == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: _buildStackedCards(Assets.images.png.frame1.path, 3),
      );
    } else if (index == 1) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: _buildStackedCards(Assets.images.png.frame2.path, 2,
            vertical: 0.03),
      );
    } else if (index == 2) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Transform.translate(
                offset: Offset(0, -80.h), // Push slightly up from center
                child: Image.asset(
                  Assets.images.png.frame3second.path,
                  width: 250.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                offset: Offset(0, 50.h), // Push slightly down from center
                child: Image.asset(
                  Assets.images.png.frame3.path,
                  width: 250.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w, top: 8.h),
                child: TextButton(
                  onPressed: () {
                    SessionManager().hasOnboarded = true;
                    context.goNamed(PageUrl.getStartedScreen);
                  },
                  child: const TextView(
                    text: "Skip",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Pallets.boldBlack,
                  ),
                ),
              ),
            ),

            // PageView and Stationary Dots
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      final data = _onboardingData[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image Area
                          Expanded(
                            child: _buildImageArea(index),
                          ),

                          60.verticalSpace,

                          // Placeholder for Dots
                          SizedBox(height: 4.h),

                          20.verticalSpace, // Reduced from 40 to bring dots lower

                          // Fixed-height text area to ensure consistent layout
                          SizedBox(
                            height: 150.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  child: TextView(
                                    text: data["title"]!,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Pallets.boldBlackV2,
                                    align: TextAlign.left,
                                  ),
                                ),

                                12.verticalSpace,

                                // Description
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  child: TextView(
                                    text: data["description"]!,
                                    fontSize: 16,
                                    color: Pallets.grey400,
                                    align: TextAlign.left,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // Stationary Dots Overlay
                  Positioned(
                    bottom: 150.h +
                        5.h, // Text height + spacing below dots (matches 20.verticalSpace above)
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingData.length,
                          (dotIndex) => AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            height: 4.h,
                            width: _currentPage == dotIndex ? 24.w : 16.w,
                            decoration: BoxDecoration(
                              color: _currentPage == dotIndex
                                  ? Pallets.blueBubbleColor
                                  : Pallets.grey90,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Continue Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: CustomButton(
                elevation: 0,
                onPressed: () {
                  if (_currentPage == _onboardingData.length - 1) {
                    SessionManager().hasOnboarded = true;
                    context.goNamed(PageUrl.getStartedScreen);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                bgColor: Pallets.blueBubbleColor,
                borderRadius: BorderRadius.circular(14.r),
                padding: EdgeInsets.symmetric(vertical: 17.h),
                child: const TextView(
                  text: "Continue",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),

            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
