import 'dart:io';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/messaging/presentation/screens/mock_chat_screen.dart';
import 'package:talkam/features/messaging/presentation/widgets/conversation_item.dart';

class MessagesList extends StatefulWidget {
  final List<TalkamConversation> message;

  const MessagesList({
    super.key,
    required this.message,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  File? image;

  @override
  Widget build(BuildContext context) {
    if (widget.message.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          injector.get<ConversationsCubit>().getConversations();
        },
        child: ListView(
          children: [
            100.verticalSpace,
            const EmptyState(
              title: "You are all caught up",
              subtitle:
                  "No messages yet. Start a conversation to see your messages here.",
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        injector.get<ConversationsCubit>().getConversations();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.message.length,
        itemBuilder: (BuildContext context, index) {
          final conversation = widget.message[index];
          return InkWell(
            onTap: () {
              if (MockHomeData.isMockConversationId(conversation.id)) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MockChatScreen(conversation: conversation),
                ));
              } else {
                context.pushNamed(PageUrl.chatScreen,
                    extra: ChatScreenParam(
                        conversation: conversation,
                        user: conversation.otherUser));
              }
            },
            child: ConversationItem(message: conversation),
          );
        },
        separatorBuilder: (context, _) => const SizedBox(height: 24),
      ),
    );
  }
}
