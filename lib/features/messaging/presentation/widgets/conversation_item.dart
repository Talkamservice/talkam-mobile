import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({super.key, required this.message});

  final TalkamConversation message;

  @override
  Widget build(BuildContext context) {
    final lastMessage = message.lastMessage;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageWidget(
          height: 44,
          width: 44,
          shape: BoxShape.circle,
          imageUrl: message.otherUser.avatar ?? Assets.images.svgs.blockedUser,
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextView(
                      text: message.otherUser.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (MockHomeData.verifiedContactIds
                      .contains(message.otherUser.id)) ...[
                    6.horizontalSpace,
                    const Icon(Icons.verified, size: 16, color: Colors.orange),
                  ],
                  if (message.starredAt != null) ...[
                    6.horizontalSpace,
                    const Icon(Icons.star_rounded,
                        size: 16, color: Pallets.noticeAmber),
                  ],
                  if (message.isMuted) ...[
                    6.horizontalSpace,
                    const Icon(Icons.notifications_off_rounded,
                        size: 14, color: Pallets.grey60),
                  ],
                ],
              ),
              if (lastMessage != null) ...[
                2.verticalSpace,
                TextView(
                  text: lastMessage.message,
                  color: Pallets.grey400,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  fontSize: 14,
                ),
              ],
            ],
          ),
        ),
        12.horizontalSpace,
        if (lastMessage != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextView(
                text: TimeUtil.getTimeAgo(lastMessage.createdAt.toString()),
                fontSize: 12,
                color: Pallets.grey60,
              ),
              6.verticalSpace,
              MessageIndicator(lastMessage: lastMessage),
            ],
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
    if (SessionManager().isMe(lastMessage.senderId.toString())) {
      return ImageWidget(
        imageUrl: lastMessage.read
            ? Assets.images.svgs.messageRead
            : Assets.images.svgs.messageSent,
        size: 14,
      );
    }

    return lastMessage.read
        ? 0.verticalSpace
        : Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
                color: Pallets.blueBubbleColor, shape: BoxShape.circle),
          );
  }
}
