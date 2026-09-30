import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/features/messaging/data/models/get_messages_response.dart';

/// Small pill row under a message bubble aggregating reactions by emoji,
/// e.g. "👍 2  ❤️ 1" — mirrors the reaction list shape documented in
/// CHAT_AND_SESSION_API_REFERENCE.md's `/messaging/messages/list` response.
class ReactionBadgeRow extends StatelessWidget {
  const ReactionBadgeRow({super.key, required this.reactions});

  final List<MessageReaction> reactions;

  @override
  Widget build(BuildContext context) {
    final counts = <String, int>{};
    for (final r in reactions) {
      counts[r.reaction] = (counts[r.reaction] ?? 0) + 1;
    }

    return Wrap(
      spacing: 4,
      children: counts.entries.map((entry) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextView(
            text: entry.value > 1 ? '${entry.key} ${entry.value}' : entry.key,
            fontSize: 12,
          ),
        );
      }).toList(),
    );
  }
}
