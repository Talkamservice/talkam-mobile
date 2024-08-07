import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupResultItem extends StatelessWidget {
  const GroupResultItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              ImageWidget(
                  width: 78,
                  height: 54,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(2),
                  imageUrl: Assets.images.png.woman.path),
              12.horizontalSpace,
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "UEFA Chamions League",
                      fontWeight: FontWeight.w700,
                    ),
                    TextView(
                      text: "32k Members",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 1),
                      shape: const StadiumBorder(),
                      backgroundColor: Pallets.primary,
                      foregroundColor: Pallets.white),
                  onPressed: () {},
                  child: const TextView(text: "Join"))
            ],
          ),
          12.verticalSpace,
          Padding(
            padding: EdgeInsets.only(top: 6.0.h),
            child: Container(height: 1, color: Pallets.borderGrey),
          ),
        ],
      ),
    );
  }
}
