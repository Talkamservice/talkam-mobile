import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/features/ads/data/models/ad_analytics_response.dart';

import '../../../../core/theme/pallets.dart';
import 'impressions_info_item.dart';

class ImpressionsInfoWidget extends StatelessWidget {
  const ImpressionsInfoWidget({super.key, required this.analyticsInfo});

  final AnalyticsInfo analyticsInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImpressionsInfoItem(
              header: "Impressions",
              number: analyticsInfo.impressions.toString(),
            ),
            ImpressionsInfoItem(
              header: "Engagements Rate",
              number: "%${analyticsInfo.engagements.round().toString()}",
            ),
            ImpressionsInfoItem(
              header: "New followers",
              number: analyticsInfo.followers.toString(),
            ),
          ],
        ),
        15.verticalSpace,
        const Divider(
          thickness: 1,
          color: Pallets.buttonGrey,
        ),
        15.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImpressionsInfoItem(header: "Profile visit", number: analyticsInfo.profileVisits.toString()),
            ImpressionsInfoItem(header: "Clicks", number: analyticsInfo.clicks.toString()),
            // 5.horizontalSpace,
            // ImpressionsInfoItem(header: "Profile visit", number: analyticsInfo.impressions),
            // 1.horizontalSpace
          ],
        ),
        15.verticalSpace,
        const Divider(
          thickness: 1,
          color: Pallets.buttonGrey,
        ),
        15.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImpressionsInfoItem(header: "Max time spent on post", number: "${analyticsInfo.maxTimeSpent} sec"),
            ImpressionsInfoItem(header: "Min time spent on post", number: "${analyticsInfo.minTimeSpent} sec"),
          ],
        ),
      ],
    );
  }
}
