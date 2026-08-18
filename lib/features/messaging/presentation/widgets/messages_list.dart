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
  final ScrollController? controller;
  final bool isLoadingMore;
  final VoidCallback? onRefresh;
  final ValueChanged<TalkamConversation>? onLongPress;

  const MessagesList({
    super.key,
    required this.message,
    this.controller,
    this.isLoadingMore = false,
    this.onRefresh,
    this.onLongPress,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final onRefresh = widget.onRefresh ??
        () => injector.get<ConversationsCubit>().getConversations();

    if (widget.message.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => onRefresh(),
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
      onRefresh: () async => onRefresh(),
      child: ListView.separated(
        controller: widget.controller,
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.message.length + (widget.isLoadingMore ? 1 : 0),
        itemBuilder: (BuildContext context, index) {
          if (index >= widget.message.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }

          final conversation = widget.message[index];
          return InkWell(
            onTap: () {
              if (MockHomeData.isMockConversationId(conversation.id)) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MockChatScreen(conversation: conversation),
                ));
              } else {
                injector
                    .get<ConversationsCubit>()
                    .markConversationSeen(conversation.id.toString());
                context.pushNamed(PageUrl.chatScreen,
                    extra: ChatScreenParam(
                        conversation: conversation,
                        user: conversation.otherUser));
              }
            },
            onLongPress: widget.onLongPress == null
                ? null
                : () => widget.onLongPress!(conversation),
            child: ConversationItem(message: conversation),
          );
        },
        separatorBuilder: (context, _) => const SizedBox(height: 24),
      ),
    );
  }
}
