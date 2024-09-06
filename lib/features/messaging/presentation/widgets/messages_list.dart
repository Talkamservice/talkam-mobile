import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';
import 'package:talkam/features/messaging/presentation/screens/chat_screen.dart';
import 'package:talkam/features/messaging/presentation/widgets/conversation_item.dart';
import 'package:talkam/gen/assets.gen.dart';

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
              title: "No Conversations yet",
              subtitle: "Your conversations will appear here if there are any",
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
          return InkWell(
            onTap: () {
              context.pushNamed(PageUrl.chatScreen, extra: ChatScreenParam(conversation: widget.message[index], user: widget.message[index].otherUser));
            },
            child: ConversationItem(message: widget.message[index]),
          );
        },
        separatorBuilder: (context, _) => const SizedBox(height: 16),
      ),
    );
  }
}
