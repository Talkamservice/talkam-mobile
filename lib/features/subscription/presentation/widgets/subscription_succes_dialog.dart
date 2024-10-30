import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/subscription/data/models/get_plans_response.dart';

class SubscriptionSucessDialog extends StatelessWidget {
  const SubscriptionSucessDialog({super.key, required this.duration});

  final TalkamPlanDuration duration;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(color: Pallets.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const TextView(
              text: "Congratulations, you have subscribed to TalkAM plus",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              align: TextAlign.center,
            ),
            6.verticalSpace,
            const TextView(
              text: "We are glad to have you onboard, enjoy seamless interactions and engagements. Your next renewal date is",
              fontSize: 12,
              color: Pallets.grey,
              align: TextAlign.center,
            ),
            TextView(
              text: TimeUtil.formatDate(DateTime.now().add(Duration(days: int.parse(duration.duration))).toString()),
              fontWeight: FontWeight.w700,
              fontSize: 12,
              align: TextAlign.center,
            ),
            25.verticalSpace,
            CustomButton(
              bgColor: Pallets.blueBubbleColor,
              borderRadius: BorderRadius.circular(50),
              elevation: 0,
              onPressed: () {
                context.pop();
              },
              padding: const EdgeInsets.all(13),
              text: "Continue",
            )
          ],
        ),
      ),
    );
  }
}
