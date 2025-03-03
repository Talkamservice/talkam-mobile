import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/app.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screens/closed_ads_screen.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screens/running_ads_screen.dart';
import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/theme/pallets.dart';

class AdsReviewScreen extends StatefulWidget {
  const AdsReviewScreen({super.key});

  @override
  State<AdsReviewScreen> createState() => _AdsReviewScreenState();
}

class _AdsReviewScreenState extends State<AdsReviewScreen> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        padding: EdgeInsets.only(right: 10.0),
        tittleText: "Ads",
        centerTile: false,
        showDivider: true,
        // actions: [
        //   Icon(Icons.more_vert),
        // ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 17, bottom: 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          "Running ads",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                            color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                      5.verticalSpace,
                      if (_selectedIndex == 0)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 4,
                          width: 85,
                          color: Pallets.blueBubbleColor,
                        ),
                    ],
                  ),
                ),
                20.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          "Closed ads",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                            color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                      5.verticalSpace,
                      if (_selectedIndex == 1)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 4,
                          width: 85,
                          color: Pallets.blueBubbleColor,
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    foregroundColor: Pallets.white,
                    backgroundColor: Pallets.blueBubbleColor,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    context.pushNamed(PageUrl.createAdsScreen);
                  },
                  child: const TextView(
                    text: "Create new Ad",
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: Colors.grey.withOpacity(0.7)),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                RunningAdsScreen(),
                ClosedAdsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
