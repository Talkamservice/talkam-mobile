import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/features/ads/presentation/screens/ads_page_screens/budget_page.dart';
import 'package:talkam/features/ads/presentation/screens/ads_page_screens/create_ad_page.dart';
import 'package:talkam/features/ads/presentation/screens/ads_page_screens/preview_promotion_page.dart';

class AdsFlowPage extends StatefulWidget {
  const AdsFlowPage ({super.key});

  @override
  State<AdsFlowPage> createState() => _AdsFlowPageState();
}

class _AdsFlowPageState extends State<AdsFlowPage> {
  int _selectedIndex = 0;

  // Navigating to the page before
  void previousPage() {
    setState(() {
      if (_selectedIndex > 0) {
        _selectedIndex--;
      }
    });
  }

  // to navigate to the next page
  void nextPage() {
    setState(() {
      if (_selectedIndex < _pages.length - 1) {
        _selectedIndex++;
      }
    });
  }

  // List of pages
  final List<Widget> _pages = [
    const CreateAdPage(),
    const BudgetPage(),
    const PreviewPromotionPage(),
  ];


  String getRightButtonText() {
    if (_selectedIndex == _pages.length - 2) {
      return "Review";
    } else if (_selectedIndex == _pages.length - 1 ) {
      return "Create Promotion";
    } else {
      return "Next";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        padding: EdgeInsets.only(right: 10.0),
        tittleText: "Ads",
        centerTile: false,
        showDivider: true,
        actions: [
          Icon(Icons.more_vert)
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.only( right: 15,bottom: 15, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                GestureDetector(
                  onTap: previousPage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: nextPage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      getRightButtonText(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
