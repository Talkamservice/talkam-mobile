import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Circular avatar with an edit badge and a "Change Photo" action beneath.
///
/// Shared by the member and therapist Edit Profile screens — the two forms are
/// otherwise unrelated, but this block is identical in both.
class EditAvatar extends StatelessWidget {
  const EditAvatar({
    super.key,
    required this.imageUrl,
    required this.onTap,
    this.diameter = 100,
  });

  /// Empty falls back to the default person glyph.
  final String? imageUrl;

  final VoidCallback onTap;

  /// Logical diameter before ScreenUtil scaling.
  final double diameter;

  @override
  Widget build(BuildContext context) {
    final resolved = (imageUrl == null || imageUrl!.isEmpty)
        ? Assets.images.svgs.user
        : imageUrl!;

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ImageWidget(
                  size: diameter,
                  shape: BoxShape.circle,
                  imageUrl: resolved,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Pallets.blueBubbleColor,
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 14.r,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          8.verticalSpace,
          TextView(
            text: "Change Photo",
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Pallets.grey400,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
