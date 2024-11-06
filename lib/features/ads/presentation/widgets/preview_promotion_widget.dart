import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/features/ads/presentation/widgets/payment_method_item.dart';
import 'package:talkam/features/ads/presentation/widgets/preview_promotion_item.dart';

class PreviewPromotionWidget extends StatelessWidget {
  const PreviewPromotionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 10),
          child: PreviewPromotionItem(title: "Total", content: "\$250"),
        ),
        15.verticalSpace,
        const Divider(color: Colors.grey),
        16.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your reach", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const PreviewPromotionItem(title: "Location", content: "Nigeria"),
                  const PreviewPromotionItem(title: "Age range", content: "20-60yrs"),
                  const PreviewPromotionItem(title: "Gender", content: "All gender"),
                  10.horizontalSpace
                ],
              ),
            ],
          ),
        ),
        16.verticalSpace,
        const Divider(color: Colors.grey),
        16.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Budget & Duration", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const PreviewPromotionItem(title: "Daily budget", content: "\$16"),
                  100.horizontalSpace,
                  const PreviewPromotionItem(title: "Duration", content: "15 days"),
                  1.horizontalSpace,
                ],
              ),
            ],
          ),
        ),
        16.verticalSpace,
        const Divider(color: Colors.grey),
        16.verticalSpace,
      ],
    );
  }
}
