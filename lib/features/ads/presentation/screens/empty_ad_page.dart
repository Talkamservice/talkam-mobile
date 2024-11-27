import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';

class EmptyAdPage extends StatelessWidget {
  const EmptyAdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,

      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You currently don't have any post promoted",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            6.verticalSpace,
            const Text(
              "You haven't promoted any post yet. Click on the button below to begin",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            30.verticalSpace,
            GestureDetector(
              onTap: () {
                context.pushNamed(PageUrl.createAdsScreen);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                width: 230,
                decoration: BoxDecoration(
                  color: Pallets.tabBarBlue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child: Text(
                    "Start promoting",
                    style: TextStyle(color: Colors.white, fontSize: 15),
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
