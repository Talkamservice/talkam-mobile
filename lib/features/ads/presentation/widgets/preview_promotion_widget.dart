import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/ads/data/models/create_promotion_payload.dart';
import 'package:talkam/features/ads/data/models/initiate_payment_response.dart';
import 'package:talkam/features/ads/presentation/widgets/payment_method_item.dart';
import 'package:talkam/features/ads/presentation/widgets/preview_promotion_item.dart';
import 'package:talkam/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class PreviewPromotionWidget extends StatelessWidget {
  const PreviewPromotionWidget({super.key, required this.payload, required this.paymentInfo});

  final CreatePromotionPayload payload;
  final InitiatePaymentResponse paymentInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, right: 10),
          child: PreviewPromotionItem(title: "Total", content: "${injector.get<ProfileBloc>().appUser?.currency.toString().getCurrencySymbol}${paymentInfo.data.amount}"),
        ),
        15.verticalSpace,
        const Divider(color: Colors.grey),
        16.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your reach",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PreviewPromotionItem(title: "Location", content: payload.country?.first!.name ?? ""),
                  5.horizontalSpace,
                  PreviewPromotionItem(title: "Age range", content: "${payload.minAge}-${payload.maxAge}yrs"),
                  5.horizontalSpace,
                  PreviewPromotionItem(title: "Gender", content: "${payload.gender}"),
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
              const Text(
                "Budget & Duration",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PreviewPromotionItem(title: "Daily budget", content: "${injector.get<ProfileBloc>().appUser?.currency.toString().getCurrencySymbol}${payload.dailyBudget}"),
                  100.horizontalSpace,
                  PreviewPromotionItem(title: "Duration", content: "${payload.duration} days"),
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
