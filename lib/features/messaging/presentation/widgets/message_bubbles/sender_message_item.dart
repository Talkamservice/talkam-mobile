import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/link_recognizing_text.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/media_item.dart';

class SenderMessageItem extends StatelessWidget {
  final AppMessageModel message;
  final VoidCallback onRetryMessage;

  const SenderMessageItem({
    Key? key,
    required this.message,
    required this.onRetryMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isShortMessage = message.content.toString().length <= 20;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: EdgeInsets.symmetric(
              vertical: messageIsMedia ? 4 : 8.0,
              horizontal: messageIsMedia ? 4 : 8.0,
            ),
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
                ? const BoxConstraints(minHeight: 20, maxWidth: 280)
                : const BoxConstraints(maxWidth: 280),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (messageIsMedia) MediaItem(messageModel: message),
                TextMessageWidget(
                  message: message,
                  isShortMessage: isShortMessage,
                  onRetryMessage: onRetryMessage,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool get messageIsMedia {
    return message.messageType.toLowerCase() == "media" ||
        message.messageType.toLowerCase() == "file";
  }
}

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({
    Key? key,
    required this.message,
    required this.isShortMessage,
    required this.onRetryMessage,
  }) : super(key: key);

  final AppMessageModel message;
  final bool isShortMessage;
  final VoidCallback onRetryMessage;

  static const double _timeWidth = 58;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // message text with right padding to make room for the timestamp
        Padding(
          padding: const EdgeInsets.only(right: _timeWidth, bottom: 2),
          child: message.content != null
              ? LinkRecognizingText(
                  text: message.content.toString(),
                  mainTextColor: const Color(0xFF444444),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  linkColor: Pallets.adIndicator,
                )
              : const SizedBox.shrink(),
        ),
        // timestamp pinned to bottom-right, raised into the last line
        Positioned(
          bottom: 0,
          right: 0,
          child: _buildMessageStatus(context),
        ),
      ],
    );
  }

  bool get messageIsMedia {
    return message.messageType.toLowerCase() == "media" ||
        message.messageType.toLowerCase() == "file";
  }

  Widget _buildMessageStatus(BuildContext context) {
    switch (message.sendingState) {
      case null:
      case SendingState.loading:
      case SendingState.success:
        return TextView(
          text: TimeUtil.formatTime(message.time!),
          color: const Color(0xFF888888),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        );
      case SendingState.failed:
        return TextButton(
          onPressed: onRetryMessage,
          child: const TextView(text: "Retry"),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
