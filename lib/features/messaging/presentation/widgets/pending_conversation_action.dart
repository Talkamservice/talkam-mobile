import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/custom_outlined_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';

class PendingConversationActions extends StatelessWidget {
  const PendingConversationActions(
      {super.key,
      required this.user,
      required this.onAccept,
      required this.onReject});

  final ConversationUser user;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        50.verticalSpace,
        Center(
          child: TextView(
            color: const Color(0xff212121),
            text:
                '${user.username} is sending you a message to\nconnect. Do you want to accept their request to\n send and receive messages?',
            fontSize: 16,
            align: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
        ),
        33.verticalSpace,
        Row(
          children: [
            Expanded(
              child: CustomOutlinedButton(
                radius: 8,
                outlinedColr: Pallets.red,
                foreGroundColor: Pallets.red,
                onPressed: onReject,
                child: const TextView(
                  color: Color(0xFFEE1414),
                  text: 'Reject',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            11.horizontalSpace,
            Expanded(
              child: CustomButton(
                borderRadius: BorderRadius.circular(8),
                bgColor: Pallets.buttonBlack,
                onPressed: onAccept,
                text: "Accept",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
