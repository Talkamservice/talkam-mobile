import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/pallets.dart';
import 'impressions_info_item.dart';

class ImpressionsInfoWidget extends StatelessWidget {
  const ImpressionsInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImpressionsInfoItem(header: "Impressions", number: "1000",),
            ImpressionsInfoItem(header: "Engagements", number: "40",),
            ImpressionsInfoItem(header: "New followers", number: "20",),
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
            const ImpressionsInfoItem(header: "Profile visit", number: "600"),
            const ImpressionsInfoItem(header: "Clicks", number: "200"),
            5.horizontalSpace,
            const ImpressionsInfoItem(header: "Profile visit", number: "600"),
            1.horizontalSpace
          ],
        ),
        15.verticalSpace,
        const Divider(
          thickness: 1,
          color: Pallets.buttonGrey,
        ),
        15.verticalSpace,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImpressionsInfoItem(header: "Min time spent on post", number: "0.2 sec"),
            ImpressionsInfoItem(header: "Min time spent on post", number: "0.2 sec"),
          ],
        ),
      ],
    );
  }
}
