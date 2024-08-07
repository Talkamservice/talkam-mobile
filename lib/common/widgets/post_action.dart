import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';

class PostActionWidget extends StatelessWidget {
  const PostActionWidget({
    super.key,
    required this.imagePath,
    required this.tittle,
    required this.onTap,
    this.textColor,
  });

  final String imagePath;
  final String tittle;
  final VoidCallback onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: Row(
              children: [
                ImageWidget(imageUrl: imagePath),
                18.horizontalSpace,
                TextView(
                  text: tittle,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                )
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
