import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/app.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/screens/ads_flow.dart';

import '../../../../common/widgets/custom_appbar.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "You currently don't have any post promoted",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23
                ),
            ),
            6.verticalSpace,
            const Text(
                "You haven't promoted any post yet. Click on the button below to begin",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
              ),
            ),
            30.verticalSpace,
            GestureDetector(
              onTap: () {
             context.pushNamed(PageUrl.createAdsScreen);
              },
              child: Container(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                width: 230,
                decoration: BoxDecoration(
                  color: Pallets.tabBarBlue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child: Text(
                    "Start promoting",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
