import 'package:flutter/material.dart';
import 'package:talkam/features/messaging/presentation/widgets/new_notification.dart';
import 'package:talkam/gen/assets.gen.dart';

class AllTab extends StatefulWidget {
  const AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  final List<String> names = [
    "hamdkos",
    "hamdkos",
    "7zy13d",
    'xyw589mds',
    'wcnrout '
  ];

  final List<String> messages = [
    "and 20 others replied to your post",
    "and 4 others liked your comment",
    "replied: @jhness that is not what I meant, look at\n what I said again and you’ll understand",
    "and 2 others replied to your post",
    'wcnrout and 20 others liked your post'
  ];

  final List<AssetGenImage> images = [
    Assets.images.png.woman_driving,
    Assets.images.png.man_shoping,
    Assets.images.png.woman_driving,
    Assets.images.png.man_shoping,
    Assets.images.png.woman_driving,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: NewNotificationList(
              name: names,
              message: messages,
              image: images,
            ),
          ),
        ],
      ),
    );
  }
}
