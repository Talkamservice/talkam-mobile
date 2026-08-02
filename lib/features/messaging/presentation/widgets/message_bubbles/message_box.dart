import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/reciver_message_item.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/sender_message_item.dart';

class ChatMessageBox extends StatefulWidget {
  const ChatMessageBox({
    Key? key,
    required this.message,
    this.child, required this.onRetryMessage,
  }) : super(key: key);

  final AppMessageModel message;
  final Widget? child;
  final VoidCallback onRetryMessage;

  @override
  State<ChatMessageBox> createState() => _ChatMessageBoxState();
}

class _ChatMessageBoxState extends State<ChatMessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints:  BoxConstraints(minWidth: 10 ),
        alignment: widget.message.messageType == "divider"
            ? Alignment.center
            : widget.message.iAmSender
                ? Alignment.centerLeft
                : Alignment.centerRight,
        child: widget.message.messageType == "divider"
            ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  decoration: BoxDecoration(
                      border: Border.all(color: context.colorScheme.onSurface.withValues(alpha: 0.2)),
                      borderRadius: BorderRadius.circular(100),
                    color: context.colorScheme.onSurface.withValues(alpha: 0.05),
                  ),
                  child: TextView(text: widget.message.content!,fontSize: 13,),
                ),
            )
            : widget.message.iAmSender
                ? SenderMessageItem(
                    message: widget.message, onRetryMessage: widget.onRetryMessage,
                  )
                : ReceiverMessageItem(
                    message: widget.message,
                  ));
  }

// bool get isSender => true;
}
