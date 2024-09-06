import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class ConversationItem extends StatefulWidget {
  const ConversationItem({super.key, required this.message});

  final TalkamConversation message;

  @override
  State<ConversationItem> createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageWidget(height: 44, width: 44, shape: BoxShape.circle, imageUrl: widget.message.otherUser.avatar ?? Assets.images.svgs.blockedUser),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: widget.message.otherUser.username,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  if (widget.message.lastMessage != null)
                    TextView(
                      text: TimeUtil.formatTime(widget.message.lastMessage!.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff888888),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
              if (widget.message.lastMessage != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextView(
                        text: widget.message.lastMessage!.message,
                        color: const Color(0xff666666),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    MessageIndicator(lastMessage: widget.message.lastMessage!)
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class MessageIndicator extends StatelessWidget {
  const MessageIndicator({
    super.key,
    required this.lastMessage,
  });

  final LastMessage lastMessage;

  @override
  Widget build(BuildContext context) {
    
    return SessionManager().isMe(lastMessage.senderId.toString())
        ? ImageWidget(imageUrl: lastMessage.read ? Assets.images.svgs.messageRead : Assets.images.svgs.messageSent)
        : 0.verticalSpace;
  }
}
