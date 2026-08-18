import 'dart:io';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/filled_textfield.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/services/data/session_manager.dart';
import 'package:talkam/core/services/image_manipulation/image_manager.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/presentation/widgets/chat_emoji_widget.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/preview_media_message.dart';
import 'package:talkam/features/messaging/presentation/widgets/pending_conversation_action.dart';
import 'package:talkam/gen/assets.gen.dart';

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
  State<ConversationActionsWidget> createState() =>
      _ConversationActionsWidgetState();
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
  final bool isApple = [TargetPlatform.iOS, TargetPlatform.macOS]
      .contains(foundation.defaultTargetPlatform);

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
    if (widget.currentConversation?.userBlocked ?? false) {
      return Column(
        children: [
          20.verticalSpace,
          TextView(
            text:
                "@${widget.currentConversation?.otherUser.username} is Blocked",
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          10.verticalSpace,
          const TextView(text: "Unblock them to send them messages"),
          60.verticalSpace
        ],
      );
    }

    if (widget.currentConversation?.userBanned ?? false) {
      return Column(
        children: [
          20.verticalSpace,
          TextView(
            text:
                "@${widget.currentConversation?.otherUser.username} is Banned",
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          10.verticalSpace,
          const TextView(
              text:
                  "You can view their profile when their account is re-activated"),
          60.verticalSpace
        ],
      );
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

    return _buildMessageInputArea(context);
  }

  Widget _buildMessageInputArea(BuildContext context) {
    return Column(
      children: [
        if (pickedFile != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: PreviewMediaMessage(
              pickedFile: pickedFile!,
              onRemove: () {
                pickedFile = null;
                setState(() {});
              },
            ),
          ),
        SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Pallets.grey90),
                      borderRadius: BorderRadius.circular(28.r),
                      color: pickedFile != null
                          ? const Color(0xFFEEEEEE)
                          : Colors.transparent,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: GestureDetector(
                            onTap: switchEmojiView,
                            child: Icon(
                              _emojiShowing
                                  ? Icons.keyboard
                                  : Icons.emoji_emotions_outlined,
                              size: 20,
                              color: Pallets.grey,
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: TextField(
                            controller: controller,
                            focusNode: _focusNode,
                            minLines: 1,
                            maxLines: 4,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              hintText: "Type your message here",
                              border: InputBorder.none,
                            ),
                            onSubmitted: (text) {
                              if (text.isNotEmpty || pickedFile != null) {
                                widget.onSendMessage(text,
                                    file: pickedFile?.path);
                                pickedFile = null;
                                controller.clear();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: InkWell(
                            onTap: sendImage,
                            child: ImageWidget(
                                imageUrl: Assets.images.svgV2.addImageIcon,
                                size: 20),
                          ),
                        ),
                        10.horizontalSpace,
                        Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: InkWell(
                            onTap: sendImage,
                            child: ImageWidget(
                              imageUrl: Assets.images.svgV2.attachment02,
                              size: 20,
                              color: Pallets.grey60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                10.horizontalSpace,
                InkWell(
                  onTap: () {
                    final text = controller.text.trim();
                    if (text.isNotEmpty || pickedFile != null) {
                      widget.onSendMessage(text, file: pickedFile?.path);
                      pickedFile = null;
                      controller.clear();
                    }
                  },
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Pallets.blueBubbleColor,
                      shape: BoxShape.circle,
                    ),
                    child: ImageWidget(
                      imageUrl: Assets.images.svgV2.sent,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Offstage(
          offstage: !_emojiShowing,
          child: CustomEmojiPicker(
              textEditingController: controller,
              scrollController: _scrollController),
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
    var image = await ImageManager().fetchFiles(
        fileType: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png',
          'gif',
          'bmp',
          'webp',
          'pdf',
          'doc',
          'docx'
        ],
        checkSize: false);
    if (image.isNotEmpty) {
      pickedFile = File(image.first);
      setState(() {});
    }
  }

  bool get conversationIsNotYetFetched => widget.currentConversation == null;

  bool get isAPendingRequest {
    return widget.currentConversation?.status == "Awaiting_Response" &&
        (!SessionManager().isMe(
            widget.currentConversation!.requestedBy?.id.toString() ?? ''));
  }
}
