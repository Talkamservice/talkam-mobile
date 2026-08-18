import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/blocs/conversations/conversations_cubit.dart';

/// Mute/Archive/Star quick actions for a conversation row — long-press on
/// [ConversationItem] opens this. Mirrors [GroupActionSheet]'s layout.
class ConversationStateActionSheet extends StatelessWidget {
  const ConversationStateActionSheet({super.key, required this.conversation});

  final TalkamConversation conversation;

  @override
  Widget build(BuildContext context) {
    final cubit = injector.get<ConversationsCubit>();
    final id = conversation.id.toString();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ConversationAction(
            title: conversation.isMuted ? "Unmute" : "Mute",
            onTap: () {
              context.pop();
              conversation.isMuted
                  ? cubit.unmuteConversation(id)
                  : cubit.muteConversation(id);
            },
          ),
          _ConversationAction(
            title: conversation.starredAt != null ? "Unstar" : "Star",
            onTap: () {
              context.pop();
              conversation.starredAt != null
                  ? cubit.unstarConversation(id)
                  : cubit.starConversation(id);
            },
          ),
          _ConversationAction(
            title: conversation.archivedAt != null ? "Unarchive" : "Archive",
            onTap: () {
              context.pop();
              conversation.archivedAt != null
                  ? cubit.unarchiveConversation(id)
                  : cubit.archiveConversation(id);
            },
          ),
        ],
      ),
    );
  }
}

class _ConversationAction extends StatelessWidget {
  const _ConversationAction({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: SizedBox(
          width: double.infinity,
          child: TextView(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
