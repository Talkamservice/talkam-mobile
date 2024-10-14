import 'dart:io';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/filled_textfield.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/widgets/chat_emoji_widget.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/preview_media_message.dart';
import 'package:talkam/features/messaging/presentation/widgets/pending_conversation_action.dart';

class ConversationActionsWidget extends StatefulWidget {
  final ConversationUser user; // Assuming a user class or model
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isPendingRequest;
  final Function(String message, {String? file}) onSendMessage;
  final TalkamConversation? currentConversation;

  const ConversationActionsWidget({
    Key? key,
    required this.user,
    required this.onAccept,
    required this.onReject,
    required this.onSendMessage,
    required this.currentConversation,
    required this.isPendingRequest,
  }) : super(key: key);

  @override
  State<ConversationActionsWidget> createState() => _ConversationActionsWidgetState();
}

class _ConversationActionsWidgetState extends State<ConversationActionsWidget> {
  final TextEditingController controller = TextEditingController();
  bool _emojiShowing = false;
  File? pickedFile;

  final _utils = EmojiPickerUtils();
  late final EmojiTextEditingController _controller;
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;
  late final TextStyle _textStyle;
  final bool isApple = [TargetPlatform.iOS, TargetPlatform.macOS].contains(foundation.defaultTargetPlatform);

  @override
  void initState() {
    final fontSize = 24 * (isApple ? 1.2 : 1.0);
    // Define Custom Emoji Font & Text Style
    _textStyle = DefaultEmojiTextStyle.copyWith(
      fontFamily: GoogleFonts.notoColorEmoji().fontFamily,
      fontSize: fontSize,
    );

    _controller = EmojiTextEditingController(emojiTextStyle: _textStyle);
    _scrollController = ScrollController();
    _focusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (conversationIsNotYetFetched) {
          return 0.verticalSpace;
        } else {
          if(widget.currentConversation?.userBlocked??false){
            return Column(children: [
              20.verticalSpace,
              TextView(
                text: "@${widget.currentConversation?.otherUser.username} is Blocked",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              10.verticalSpace,
              const TextView(text: "Unblock them to send them messages"),
              60.verticalSpace

            ],);
          }

          if(widget.currentConversation!.userBanned){

            return Column(children: [
              20.verticalSpace,
              TextView(
                text: "@${widget.currentConversation?.otherUser.username} is Banned",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              10.verticalSpace,
              const TextView(text: "You can view their profile when their account is re-activated"),
              60.verticalSpace

            ],);
          }
          if (widget.isPendingRequest) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: PendingConversationActions(
                user: widget.user,
                onAccept: widget.onAccept,
                onReject: widget.onReject,
              ),
            );
          }
        }

        return _buildMessageInputArea(context);
      },
    );
  }

  Widget _buildMessageInputArea(BuildContext context) {
// Assuming pickedFile is managed elsewhere
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: pickedFile != null ? const Color(0xFFEEEEEE) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              if (pickedFile != null)
                PreviewMediaMessage(
                  pickedFile: pickedFile!,
                  onRemove: () {
                    pickedFile = null;
                    setState(() {

                    });
                  },
                ),
              const SizedBox(height: 8),
              FilledTextField(
                focusNode: _focusNode,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => sendImage(),
                      child: const Icon(Icons.attach_file, size: 20, color: Pallets.grey),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        logger.w(pickedFile?.path);

                        widget.onSendMessage(controller.text, file: pickedFile?.path);
                        pickedFile = null;
                        controller.clear();
                      },
                      child: const Icon(Icons.send, size: 20, color: Pallets.grey),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
                hint: 'Type your message here ...',
                onFieldSubmitted: (text) {
                  if (text != null) {
                    widget.onSendMessage(text);
                    pickedFile = null;
                    controller.clear();
                  }
                },
                preffix: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: GestureDetector(
                    onTap: () {
                      switchEmojiView();
                    },
                    child: Icon(_emojiShowing ? Icons.keyboard : Icons.emoji_emotions_outlined, size: 20, color: Pallets.grey),
                  ),
                ),
                controller: controller,
                hasBorder: true,
                radius: 30,
                minLine: 1,
                maxLine: 5,
              ),

            ],
          ),
        ),
        Offstage(
          offstage: !_emojiShowing,
          child: CustomEmojiPicker(textEditingController: controller, scrollController: _scrollController),
        )
      ],
    );
  }

  void switchEmojiView() {
    setState(() {
      _emojiShowing = !_emojiShowing;
      if (!_emojiShowing) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _focusNode.requestFocus();
        });
      } else {
        _focusNode.unfocus();
      }
    });
  }

  void sendImage() async {
    var image = await ImageManager()
        .fetchFiles(fileType: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'pdf', 'doc', 'docx'], checkSize: false);
    if (image.isNotEmpty) {
      pickedFile = File(image.first);
      setState(() {});
    }
  }

  bool get conversationIsNotYetFetched => widget.currentConversation == null;

  bool get isAPendingRequest {
    return widget.currentConversation?.status == "Awaiting_Response" && (!SessionManager().isMe(widget.currentConversation!.requestedBy.id.toString()));
  }
}
