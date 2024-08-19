import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/gen/assets.gen.dart';

class NewNotificationList extends StatefulWidget {
  final List<String> name;
  final List<String> message;
  final List<AssetGenImage> image;

  const NewNotificationList({
    super.key,
    required this.name,
    required this.message,
    required this.image,
  });

  @override
  State<NewNotificationList> createState() => _NewNotificationListState();
}

class _NewNotificationListState extends State<NewNotificationList> {
  @override
  Widget build(BuildContext context) {
    int itemCount = widget.name.length;
    int imageCount = widget.image.length;

    final List<AssetGenImage> defaultImages = [
      Assets.images.png.woman_driving,
      Assets.images.png.man_shoping,
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index >= widget.name.length || index >= widget.message.length) {
          return SizedBox.shrink();
        }

        String messageTime = "45 mins ago";

        AssetGenImage image = index < imageCount
            ? widget.image[index]
            : defaultImages[index % defaultImages.length];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextView(
                        text: widget.name[index],
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 200,
                        child: TextView(
                          text: widget.message[index],
                          color: const Color(0xff000000),
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  TextView(
                    text: messageTime,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff444444),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 48,
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image.image(fit: BoxFit.cover),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, _) => const SizedBox(height: 16),
    );
  }
}
