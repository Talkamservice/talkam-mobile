import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/app.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow_screens/create_ad_page.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screens/closed_ads_screen.dart';
import 'package:talkam/features/ads/presentation/screens/ads_review_screens/running_ads_screen.dart';
import 'package:talkam/features/ads/presentation/widgets/post_ad_item.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';
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

  final List<Widget> _pages = [
    const RunningAdsScreen(),
    const ClosedAdsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        padding: EdgeInsets.only(right: 10.0),
        tittleText: "Ads",
        centerTile: false,
        showDivider: true,
        actions: [
          Icon(Icons.more_vert),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 17),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Column(
                    children: [
                      if (_selectedIndex == 0)
                      const Text(
                        "Running ads",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      )
                      else const Text(
                        "Running ads",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey
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
                  },
                  child: Column(
                    children: [
                      if (_selectedIndex == 1)
                      const Text(
                        "Closed ads",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      )
                      else const Text(
                        "Closed ads",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdsFlowPage(pageIndex: 0)),
                  ),
                  child: const TextView(
                    text: "Create new Ad",
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.7)),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}




