import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/mock/mock_home_data.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/time_util.dart';
import 'package:talkam/features/messaging/data/models/get_conversations_response.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';
import 'package:talkam/features/messaging/presentation/widgets/message_bubbles/message_box.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Chat screen for a mock conversation (from [MockHomeData.conversations]) —
/// a self-contained, purely local thread with no Hive/socket/backend calls,
/// since these contacts don't exist on the real backend.
class MockChatScreen extends StatefulWidget {
  const MockChatScreen({super.key, required this.conversation});

  final TalkamConversation conversation;

  @override
  State<MockChatScreen> createState() => _MockChatScreenState();
}

class _MockChatScreenState extends State<MockChatScreen> {
  final _controller = TextEditingController();
  late final List<AppMessageModel> _messages;

  @override
  void initState() {
    super.initState();
    final thread = MockHomeData.chatThread(widget.conversation);
    _messages = [
      ...thread.reversed,
      AppMessageModel(
        content: "Today ${TimeUtil.formatTime(thread.first.time!)}",
        iAmSender: false,
        messageType: "divider",
        receiverId: '',
        conversationId: widget.conversation.id.toString(),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.insert(
        0,
        AppMessageModel(
          content: text,
          iAmSender: true,
          sendingState: SendingState.success,
          time: DateTime.now(),
          receiverId: widget.conversation.otherUser.id.toString(),
          messageType: "Text",
          conversationId: widget.conversation.id.toString(),
        ),
      );
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final other = widget.conversation.otherUser;
    final isVerified = MockHomeData.verifiedContactIds.contains(other.id);

    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 25,
        tittle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(
              width: 32,
              height: 32,
              shape: BoxShape.circle,
              imageUrl: other.avatar ?? Assets.images.svgs.dummyUser,
            ),
            11.horizontalSpace,
            TextView(
              text: other.name,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            if (isVerified) ...[
              6.horizontalSpace,
              const Icon(Icons.verified, size: 16, color: Colors.orange),
            ],
          ],
        ),
        centerTile: false,
        actions: [
          IconButton(
            onPressed: () => CustomDialogs.showToast("Coming soon"),
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: _messages.length,
              itemBuilder: (context, index) => ChatMessageBox(
                message: _messages[index],
                onRetryMessage: () {},
              ),
            ),
          ),
          _MockChatInputBar(controller: _controller, onSend: _send),
        ],
      ),
    );
  }
}

class _MockChatInputBar extends StatelessWidget {
  const _MockChatInputBar({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  void _comingSoon() => CustomDialogs.showToast("Coming soon");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Pallets.grey90),
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        minLines: 1,
                        maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: "Type your message here",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _comingSoon,
                      child: ImageWidget(
                          imageUrl: Assets.images.svgV2.addImageIcon, size: 20),
                    ),
                    10.horizontalSpace,
                    InkWell(
                      onTap: _comingSoon,
                      child: ImageWidget(
                        imageUrl: Assets.images.svgV2.attachment02,
                        size: 20,
                        color: Pallets.grey60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.horizontalSpace,
            InkWell(
              onTap: onSend,
              customBorder: const CircleBorder(),
              child: Container(
                width: 44.w,
                height: 44.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Pallets.blueBubbleColor, shape: BoxShape.circle),
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
    );
  }
}
