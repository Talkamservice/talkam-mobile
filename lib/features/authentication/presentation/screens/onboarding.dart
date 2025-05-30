
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/theme/pallets.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../gen/assets.gen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Post, comment and chat",
      "description": "Join a group, share your view, comment on current events and have conversations with friends, families and loved ones.",
      "bgColor": "#0365A1",
      "image1": Assets.images.png.splash2.path,
    },
    {
      "title": "Stay updated & keep busy",
      "description": "There are no dull moments, stay updated with current events, join communities based on your interests and have meaningful engagements.",
      "bgColor": "#0365A1",
      "image1": Assets.images.png.splash1.path,
    }
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
  double progress = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          20.verticalSpace,
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                         Container(
                           width: 168,
                           height: 5,
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: _currentPage == 0 ? Color(0xFF0365A1) : Colors.grey.shade300,
                           ),
                         ),
                         12.horizontalSpace,
                          Container(
                            width: 168,
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: _currentPage == 1 ? Color(0xFF0365A1) : Colors.grey.shade300,

                            ), 
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white,   // fully opaque at the very top
                                    Colors.white,   // continue fully opaque until 80%
                                    Colors.transparent, // fade out from 80% to bottom
                                  ],
                                  stops: [0.0, 0.3, 1.0],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dstIn,
                              child: ImageWidget(
                                width: 375,
                                height: 753,
                                imageUrl: _onboardingData[index]["image1"]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        children: [
                          TextView(
                            text: _onboardingData[index]["title"]!,
                            align: TextAlign.center, color: Pallets.boldBlackV2,
                            fontSize: 24, fontWeight: FontWeight.w700,
                          ),
                          const SizedBox(height: 10),
                          TextView(
                            text: _onboardingData[index]["description"]!,
                            align: TextAlign.center,
                            fontSize: 16, color: Pallets.grey400,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          30.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
               CustomButton(onPressed: (){
                 context.pushNamed(
                          PageUrl.onboardingIntro);
               },
               bgColor: Color(0xFF0365A1),
                child: const Center(
                    child: TextView(text: 
                      "Continue",
                      fontSize: 16, color: Colors.white,
                    ),
                  )),
                const SizedBox(height: 10),
                ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToNextScree(){
    
  }
}
