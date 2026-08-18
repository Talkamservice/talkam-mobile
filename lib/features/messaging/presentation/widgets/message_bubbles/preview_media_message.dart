import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/theme/pallets.dart';

class PreviewMediaMessage extends StatefulWidget {
  const PreviewMediaMessage(
      {super.key, required this.pickedFile, required this.onRemove});

  final File pickedFile;
  final VoidCallback onRemove;

  @override
  State<PreviewMediaMessage> createState() => _PreviewMediaMessageState();
}

class _PreviewMediaMessageState extends State<PreviewMediaMessage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Helpers.pathIsImage(widget.pickedFile.path)
            ? ImageWidget(
                imageUrl: widget.pickedFile.path,
                height: 110,
                width: 1.sw,
                borderRadius: BorderRadius.circular(15),
                imageType: ImageWidgetType.file,
              )
            : Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Pallets.primary,
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
                        text: Helpers.getFileName(widget.pickedFile),
                        color: Pallets.white,
                        maxLines: 1,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
              ),
        Positioned(
            right: 10,
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Pallets.red,
                    foregroundColor: Pallets.white,
                    padding: const EdgeInsets.all(6),
                    shape: const StadiumBorder()),
                onPressed: widget.onRemove,
                child: const TextView(
                  text: 'Remove',
                  fontWeight: FontWeight.w600,
                )))
      ],
    );
  }
}
