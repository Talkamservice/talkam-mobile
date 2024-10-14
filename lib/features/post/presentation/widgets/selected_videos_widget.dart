import 'dart:io';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:path/path.dart' as p;
import 'package:talkam/core/theme/pallets.dart';

class SelectedVideosWidget extends StatefulWidget {
  const SelectedVideosWidget({super.key, required this.images, required this.onAddImage, required this.onDelete});

  final List<File> images;
  final VoidCallback onAddImage;
  final Function(File image) onDelete;

  @override
  State<SelectedVideosWidget> createState() => _SelectedVideosWidgetState();
}

class _SelectedVideosWidgetState extends State<SelectedVideosWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            width: 1.sw,
            child: Wrap(
              spacing: 10,
              children: widget.images
                  .map(
                    (e) => Chip(
                        onDeleted: () {
                          widget.onDelete(e);
                        },
                        label: TextView(text: p.basename(e.path))),
                  )
                  .toList(),
            ),
          ),
          5.verticalSpace,
          TextButton(
              style: TextButton.styleFrom(
                  shape: const StadiumBorder(
                    side: BorderSide(color: Pallets.primary),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16)),
              onPressed: () {
                widget.onAddImage();
              },
              child: const TextView(text: "Add Video"))
        ],
      ),
    );
  }
}
