import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/messaging/dormain/models/app_message_model.dart';

class MediaItem extends StatelessWidget {
  const MediaItem({super.key, required this.messageModel});

  final AppMessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Helpers.openDocument(messageModel.assetUrl!, context);
      },
      child: Column(
        crossAxisAlignment: messageModel.iAmSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (messageModel.messageType.toLowerCase() == "media")
            ImageWidget(
                canPreview: true,
                height: 150,
                width: 1.sw,
                borderRadius: BorderRadius.circular(6),
                imageType: !messageModel.assetUrl!.isURL
                    ? ImageWidgetType.file
                    : ImageWidgetType.network,
                imageUrl: messageModel.assetUrl.toString()),

          if (messageModel.messageType.toLowerCase() == "file")
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Pallets.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    const Icon(
                      Icons.file_present_rounded,
                      size: 29,
                      color: Pallets.white,
                    ),
                    5.horizontalSpace,
                    TextView(
                      text: messageModel.assetUrl!.isURL
                          ? "view file"
                          : "file sent",
                      color: Pallets.white,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ),
            ),
          // if(messageModel.iAmSender)
          5.verticalSpace,

          // TextView(
          //   text: TimeUtil.formatTime(messageModel.time!),
          //   color: messageModel.iAmSender ? const Color(0xFF666666) : Pallets.white,
          //   fontSize: 13,
          //   fontWeight: FontWeight.w600,
          // )
        ],
      ),
    );
  }
}
