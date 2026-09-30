import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/services/data/chat_local_store.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/blocs/messaging/messaging_cubit.dart';

const _quickReactions = ['👍', '❤️', '😂', '😮', '😢', '🙏'];

/// Long-press context menu for a message bubble — edit/delete (own
/// messages only), forward, pin/unpin, and quick reactions. All wired
/// through [MessagingCubit]'s message-action methods, which call an
/// UNVERIFIED (guessed) backend endpoint — errors here most likely mean
/// that guess needs correcting, not a real user-facing failure.
Future<void> showMessageActionSheet(
  BuildContext context, {
  required MessagingCubit messagingCubit,
  required AppMessageModel message,
}) {
  return CustomDialogs.showBottomSheet(
    context,
    _MessageActionSheet(messagingCubit: messagingCubit, message: message),
  );
}

class _MessageActionSheet extends StatelessWidget {
  const _MessageActionSheet(
      {required this.messagingCubit, required this.message});

  final MessagingCubit messagingCubit;
  final AppMessageModel message;

  int get _myUserId =>
      int.tryParse(SessionManager().usersData["id"].toString()) ?? -1;

  String? get _myReaction {
    final mine = message.reactions.where((r) => r.userId == _myUserId);
    return mine.isEmpty ? null : mine.first.reaction;
  }

  @override
  Widget build(BuildContext context) {
    // Captured once, up front, and reused for every "close the action
    // sheet" pop below — NOT re-derived via a fresh Navigator.of(context)
    // later. Popping the sheet before opening a follow-up dialog/sheet on
    // top of it deactivates this context, and any later Navigator.of(context)
    // lookup against a deactivated context throws ("Looking up a
    // deactivated widget's ancestor is unsafe") — this is exactly why the
    // delete confirmation's own buttons were failing.
    final sheetNavigator = Navigator.of(context);

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _quickReactions.map((emoji) {
              final selected = _myReaction == emoji;
              return InkWell(
                onTap: () async {
                  sheetNavigator.pop();
                  try {
                    if (selected) {
                      await messagingCubit.removeReaction(message.id);
                    } else {
                      await messagingCubit.addReaction(message.id, emoji);
                    }
                  } catch (e) {
                    CustomDialogs.error(e.toString());
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? Pallets.blueBubbleColor.withValues(alpha: 0.15)
                        : Colors.transparent,
                  ),
                  child: Text(emoji, style: const TextStyle(fontSize: 22)),
                ),
              );
            }).toList(),
          ),
          const Divider(height: 24, thickness: 1),
          _actionRow(
            icon: Icons.forward_outlined,
            text: 'Forward',
            // Deliberately doesn't pop the sheet first — the picker opens
            // on top of it and needs this context (and this sheet's own
            // route) to still be live.
            onTap: () => _showForwardPicker(context, sheetNavigator),
          ),
          _actionRow(
            icon: message.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
            text: message.isPinned ? 'Unpin' : 'Pin',
            onTap: () async {
              sheetNavigator.pop();
              try {
                await messagingCubit.togglePin(message.id);
              } catch (e) {
                CustomDialogs.error(e.toString());
              }
            },
          ),
          if (message.iAmSender && !message.isDeleted) ...[
            _actionRow(
              icon: Icons.edit_outlined,
              text: 'Edit',
              onTap: () => _showEditDialog(context, sheetNavigator),
            ),
            _actionRow(
              icon: Icons.delete_outline,
              text: 'Delete',
              color: Pallets.red,
              onTap: () => _confirmDelete(context, sheetNavigator),
            ),
          ],
        ],
      ),
    );
  }

  Widget _actionRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 22, color: color ?? const Color(0xff212121)),
            const SizedBox(width: 16),
            TextView(
              text: text,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: color ?? const Color(0xff212121),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, NavigatorState sheetNavigator) {
    final controller = TextEditingController(text: message.content ?? '');
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const TextView(text: 'Edit message'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 4,
          minLines: 1,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              sheetNavigator.pop();
            },
            child: const TextView(text: 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newContent = controller.text.trim();
              Navigator.of(dialogContext).pop();
              sheetNavigator.pop();
              if (newContent.isEmpty || newContent == message.content) return;
              try {
                await messagingCubit.editMessage(message.id, newContent);
              } catch (e) {
                CustomDialogs.error(e.toString());
              }
            },
            child: const TextView(text: 'Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, NavigatorState sheetNavigator) {
    // `context` here is still this sheet's own (not yet popped) context —
    // CustomDialogs.showConfirmDialog pushes its dialog on top of it via
    // that same context, so Navigator.of(context) below resolves to
    // whichever route is currently on top (the confirm dialog), while
    // sheetNavigator (captured before any of this) reaches the sheet
    // underneath it.
    CustomDialogs.showConfirmDialog(
      context,
      tittle: 'Delete message?',
      message: 'This can\'t be undone.',
      confirmText: 'Delete',
      confirmButtonBgColor: Pallets.red,
      onCancel: () {
        Navigator.of(context).pop();
        sheetNavigator.pop();
      },
      onYes: () async {
        Navigator.of(context).pop();
        sheetNavigator.pop();
        try {
          await messagingCubit.deleteMessage(message.id);
        } catch (e) {
          CustomDialogs.error(e.toString());
        }
      },
    );
  }

  void _showForwardPicker(BuildContext context, NavigatorState sheetNavigator) {
    // Reads the persisted conversations-list cache directly rather than
    // ConversationsCubit's current reactive state — by the time a chat
    // screen is open, that cubit has usually already been flipped into a
    // *different* state arm (conversationStateSuccess, from the
    // markConversationSeen() call that fires on opening this chat), so
    // matching on getConversationsListSuccess here would silently return
    // nothing even though the list was loaded moments earlier.
    final cached = ChatLocalStore.instance.getCachedConversationsList();
    final conversations = (cached?['conversations'] as List<dynamic>?)
            ?.map((e) =>
                TalkamConversation.fromJson(Map<String, dynamic>.from(e)))
            .toList() ??
        const <TalkamConversation>[];

    CustomDialogs.showBottomSheet(
      context,
      Container(
        decoration: const BoxDecoration(color: Colors.white),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextView(
              text: 'Forward to',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 12),
            Flexible(
              child: conversations.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: TextView(text: 'No conversations to forward to'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: conversations.length,
                      itemBuilder: (pickerContext, index) {
                        final conversation = conversations[index];
                        return InkWell(
                          onTap: () async {
                            Navigator.of(pickerContext).pop();
                            sheetNavigator.pop();
                            try {
                              await messagingCubit.forwardMessage(
                                  message.id, [conversation.id.toString()]);
                              CustomDialogs.showToast('Message forwarded');
                            } catch (e) {
                              CustomDialogs.error(e.toString());
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                ImageWidget(
                                  width: 36,
                                  height: 36,
                                  shape: BoxShape.circle,
                                  imageUrl: conversation.otherUser.avatar ?? '',
                                ),
                                const SizedBox(width: 12),
                                TextView(
                                  text: conversation.otherUser.username,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
