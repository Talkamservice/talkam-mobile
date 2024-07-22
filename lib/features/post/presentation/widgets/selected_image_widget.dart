import 'dart:io';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/post/presentation/widgets/indicator.dart';
import 'package:talkam/gen/assets.gen.dart';


class SelectedImageWidget extends StatefulWidget {
  const SelectedImageWidget(
      {super.key,
      required this.images,
      required this.onAddImage,
      required this.onDelete});

  final List<File> images;
  final VoidCallback onAddImage;
  final Function(File image) onDelete;

  @override
  State<SelectedImageWidget> createState() => _SelectedImageWidgetState();
}

class _SelectedImageWidgetState extends State<SelectedImageWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: const BoxDecoration(),
        height: 200.h,
        width: 1.sw,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                selectedIndex = value;
                setState(() {});
              },
              children: widget.images
                  .map(
                    (e) => ImageWidget(
                        imageType: ImageWidgetType.file, imageUrl: e.path),
                  )
                  .toList(),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // decoration: BoxDecoration(color: Pallets.black.withOpacity(0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onAddImage();
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Pallets.white,
                        backgroundColor: Pallets.black.withOpacity(0.4),
                        shape: const StadiumBorder()),
                    child: const TextView(
                      text: "Add",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (widget.images.length <= 1) {
                        widget.onDelete(widget.images[0]);
                      } else {
                        widget.onDelete(widget.images[selectedIndex]);
                      }
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Pallets.white,
                        // padding: EdgeInsets.all(16),
                        backgroundColor: Pallets.black.withOpacity(0.4),
                        shape: const CircleBorder()),
                    child: ImageWidget(
                      imageUrl: Assets.images.svgs.trash03,
                      color: Pallets.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 10,
                right: 20,
                child: Indicator(
                    seledtedIndex: selectedIndex,
                    items_count: widget.images.length))
          ],
        ),
      ),
    );
  }
}
