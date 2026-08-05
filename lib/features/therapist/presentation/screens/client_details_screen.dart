import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/therapist/data/models/client_model.dart';
import 'package:talkam/gen/assets.gen.dart';

class ClientDetailsScreen extends StatelessWidget {
  final ClientModel client;

  const ClientDetailsScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.white,
      appBar: CustomAppBar(
        titleAlign: TextAlign.center,
        centerTile: true,
        canGoBack: true,
        tittle: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: ImageWidget(imageUrl: Assets.images.svgV2.messageIcon)
            // Icon(
            //   Icons.chat_outlined,
            //   color: Pallets.boldBlack,
            //   size: 24.w,
            // ),
          ),
          12.horizontalSpace,
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [ 
                  Container(
                    width: 60.r,
                    height: 60.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F9FF),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ImageWidget(
                        imageUrl: Assets.images.svgV2.userInActive,
                        size: 24,
                        color: Pallets.blueBubbleColor,
                      )
                    ),
                  ),
                  16.verticalSpace,
                  TextView(
                    text: client.name,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Pallets.boldBlack,
                  ),
                  4.verticalSpace,
                  TextView(
                    text: "Client since ${client.joinedDate} • ${client.diagnosis.split(' • ').first}",
                    fontSize: 14,
                    color: Pallets.grey400,
                  ),
                ],
              ),
            ),
            32.verticalSpace,

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    value: client.totalSessions.toString(),
                    label: "Sessions",
                  ),
                ),
                Container(
                  width: 1,
                  height: 40.h,
                  color: Pallets.grey90,
                ),
                Expanded(
                  child: _buildStatItem(
                    value: "4", // Mock plan total
                    label: "Plan total",
                  ),
                ),
                Container(
                  width: 1,
                  height: 40.h,
                  color: Pallets.grey90,
                ),
                Expanded(
                  child: _buildStatItem(
                    value: client.progress,
                    label: "Progress",
                    valueColor: const Color(0xFF0F9D58), // Green
                  ),
                ),
              ],
            ),
            32.verticalSpace,

            // Treatment Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextView(
                  text: "Treatment Progress",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlackV2,
                ),
                TextView(
                  text: "3/8 sessions",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Pallets.primary,
                ),
              ],
            ),
            8.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                value: 3 / 8,
                backgroundColor: const Color(0xFFF1F5F9),
                valueColor: const AlwaysStoppedAnimation<Color>(Pallets.primary),
                minHeight: 8.h,
              ),
            ),
            24.verticalSpace,

            // View Notes Card
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F9FF),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    color: Pallets.primary,
                    size: 24.w,
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: "View Notes for previous session",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Pallets.primary,
                        ),
                        2.verticalSpace,
                        TextView(
                          text: "${client.diagnosis.split(' • ').first} • 30 min",
                          fontSize: 12,
                          color: Pallets.grey400,
                        ),
                      ],
                    ),
                  ),
                  8.horizontalSpace,
                  CustomButton(
                    onPressed: () {},
                    isExpanded: false,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    borderRadius: BorderRadius.circular(20.r),
                    child: const TextView(
                      text: "View",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Pallets.white,
                    ),
                  ),
                ],
              ),
            ),
            32.verticalSpace,

            // Session History
            const TextView(
              text: "SESSION HISTORY",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Pallets.grey,
            ),
            16.verticalSpace,
            _buildSessionHistoryItem(
              title: "Session 3 - Jul 9",
              subtitle: "Sleep improvement • CBT journaling assigned",
            ),
            12.verticalSpace,
            _buildSessionHistoryItem(
              title: "Session 2 - Jul 2",
              subtitle: "Stress management tips • Mindfulness exercises",
            ),
            12.verticalSpace,
            _buildSessionHistoryItem(
              title: "Session 1 - Jul 25",
              subtitle: "Nutrition-sleep link • Diet changes suggested",
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    Color? valueColor,
  }) {
    return Column(
      children: [
        TextView(
          text: value,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: valueColor ?? Pallets.boldBlack,
        ),
        4.verticalSpace,
        TextView(
          text: label,
          fontSize: 12,
          color: Pallets.grey400,
        ),
      ],
    );
  }

  Widget _buildSessionHistoryItem({
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF6FBFF),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: const BoxDecoration(
              color: Pallets.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: const Color(0xFF0F9D58),
              size: 16.w,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Pallets.boldBlack,
                ),
                4.verticalSpace,
                TextView(
                  text: subtitle,
                  fontSize: 12,
                  color: Pallets.grey400,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Pallets.grey400,
            size: 24.w,
          ),
        ],
      ),
    );
  }
}
