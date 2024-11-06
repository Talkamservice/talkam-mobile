import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/mixins/returning_user_mixin.dart';
import 'package:talkam/core/theme/pallets.dart';

class CancelAdDialog extends StatelessWidget {
  const CancelAdDialog({super.key, required this.onCancel});

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
              text: "Close a running Ad",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              align: TextAlign.center,
            ),
            6.verticalSpace,
            const TextView(
              text: "You are about to close a running ad, and all information related to the ad will be permanently lost. Please note that this action is irreversible, and no refunds will be provided. Are you sure you want to proceed?",
              fontSize: 12,
              color: Pallets.grey,
              align: TextAlign.center,
            ),
            25.verticalSpace,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomOutlinedButton(
                    radius: 30,
                    child: const TextView(text: "Cancel"),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    bgColor: Pallets.tabBarBlue,

                    // padding: const EdgeInsets.symmetric(vertical: 5),
                    borderRadius: BorderRadius.circular(30),
                    onPressed: () {
                      context.pop();
                      onCancel();
                    },
                    elevation: 0,
                    text: "Yes, proceed",
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
