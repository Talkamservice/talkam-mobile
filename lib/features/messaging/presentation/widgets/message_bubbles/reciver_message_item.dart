import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/media_item.dart';

class ReceiverMessageItem extends StatelessWidget {
  final AppMessageModel message;

  const ReceiverMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isShortMessage = message.content.toString().length <= 20;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding:  EdgeInsets.symmetric(vertical:  messageIsMedia ?4: 8.0,horizontal:  messageIsMedia ?5: 8.0),
            decoration: const BoxDecoration(
              color: Pallets.blueBubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            constraints: isShortMessage
                ? const BoxConstraints(

                    minHeight: 20,
                    maxWidth: 280,
                  )
                : const BoxConstraints(maxWidth: 280),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              if(messageIsMedia)
                MediaItem(messageModel: message),
               _TextMessageWidget(
                  message: message, isShortMessage: isShortMessage)
            ],),
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

class _TextMessageWidget extends StatelessWidget {
  const _TextMessageWidget(
      {Key? key, required this.message, required this.isShortMessage})
      : super(key: key);

  final AppMessageModel message;
  final bool isShortMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      (isShortMessage || (messageIsMedia)) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        if(message.content!= null)
        TextView(
          text: message.content.toString(),
          color: const Color(0xFFFFFFFF),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        if(message.content!= null)
        const SizedBox(height: 5.0),
        // if(message.messageType.toLowerCase()== "text")
        TextView(
          text: TimeUtil.formatTime(message.time!),
          color: const Color(0xFFFFFFFF),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  bool get messageIsMedia {
    return message.messageType.toLowerCase() == "media" || message.messageType.toLowerCase() == "file";
  }
}
