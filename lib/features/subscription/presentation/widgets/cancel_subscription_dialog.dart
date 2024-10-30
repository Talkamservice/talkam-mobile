import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/core/theme/pallets.dart';

class CancelSubscriptionDialog extends StatelessWidget {
  const CancelSubscriptionDialog({super.key, required this.onCancel});

  final VoidCallback onCancel;

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
              text: "Cancel subscription",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              align: TextAlign.center,
            ),
            6.verticalSpace,
            const TextView(
              text:
                  "By canceling your subscription, kindly ensure you have read the Cancellation Policy outline. Are you sure you want to cancel Subscription?",
              fontSize: 12,
              color: Pallets.grey,
              align: TextAlign.center,
            ),
            25.verticalSpace,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomOutlinedButton(
                    radius: 50,
                    child: const TextView(text: "Close"),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  flex: 3,
                  child: CustomButton(
                    bgColor: Pallets.buttonred,

                    // padding: const EdgeInsets.symmetric(vertical: 5),
                    borderRadius: BorderRadius.circular(50),
                    onPressed: () {
                      context.pop();
                      onCancel();
                    },
                    elevation: 0,
                    text: "Yes, cancel subscription",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
