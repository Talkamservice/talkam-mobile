import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/media_item.dart';

class SenderMessageItem extends StatelessWidget {
  final AppMessageModel message;

  const SenderMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if the message is short or long
          bool isShortMessage = message.content.toString().length <= 20;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: EdgeInsets.symmetric(vertical: messageIsMedia ? 4 : 8.0, horizontal: messageIsMedia ? 4 : 8.0),
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            constraints: isShortMessage
                ? const BoxConstraints(
                    // minWidth: 60,
                    minHeight: 20,
                    maxWidth: 280,
                  )
                : const BoxConstraints(maxWidth: 280),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [if (messageIsMedia) MediaItem(messageModel: message), TextMessageWidget(message: message, isShortMessage: isShortMessage)],
            ),
          );
        },
      ),
    );
  }

  bool get messageIsMedia {
    return message.messageType.toLowerCase() == "media" || message.messageType.toLowerCase() == "file";
  }
}

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({Key? key, required this.message, required this.isShortMessage}) : super(key: key);

  final AppMessageModel message;
  final bool isShortMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: (isShortMessage || (messageIsMedia)) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (message.content != null)
          TextView(
            text: message.content.toString(),
            color: const Color(0xFF444444),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),

        if (message.content != null) const SizedBox(height: 5.0),
        _buildMessageStatus(context),
      ],
    );
  }

  bool get messageIsMedia {
    return message.messageType.toLowerCase() == "media" || message.messageType.toLowerCase() == "file";
  }

  Widget _buildMessageStatus(BuildContext context) {
    switch (message.sendingState) {
      case null:
      case SendingState.loading:
      case SendingState.success:
        return TextView(
          text: TimeUtil.formatTime(message.time!),
          color: const Color(0xFF666666),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        );
      case SendingState.failed:
        return TextButton(
          onPressed: () {
// TODO: Implement retry logic
          },
          child: const TextView(text: "Retry"),
        );
      default:
        return const SizedBox.shrink(); // Or handle other states as needed
    }
  }
}
