import 'package:flutter/material.dart';
import 'package:talkam/features/messaging/presentation/widgets/new_notification.dart';
import 'package:talkam/gen/assets.gen.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final List<String> names = [
    "7zy13d",
  ];
  final List<String> messages = [
    "replied: @jhness that is not what I meant, look at\n what I said again and you’ll understand",
  ];
  final List<AssetGenImage> images = [
    Assets.images.png.man_shoping,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NewNotificationList(
            name: names,
            message: messages,
            image: images,
          ),
        ),
      ],
    );
  }
}
