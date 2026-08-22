import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/presentation/widgets/chat_emoji_widget.dart';

/// Reuses the same emoji picker already real and working in messaging
/// (`CustomEmojiPicker`), just presented as a bottom sheet for the post/
/// comment composers.
void showEmojiComposerSheet(
    BuildContext context, TextEditingController controller) {
  CustomDialogs.showBottomSheet(
    context,
    SizedBox(
      height: 300,
      child: CustomEmojiPicker(
        textEditingController: controller,
        scrollController: ScrollController(),
        backgroundColor: Colors.white,
        dividerColor: Pallets.grey90,
      ),
    ),
  );
}
