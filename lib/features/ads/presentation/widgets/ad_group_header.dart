import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class AdGroupHeader extends StatelessWidget {
  const AdGroupHeader({super.key, required this.group, required this.onStateChanged, this.imageRadius});

  final TalkamGroup group;
  final VoidCallback onStateChanged;
  final BorderRadius? imageRadius;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
          imageUrl: group.image!,
          width: 1.sw,
          borderRadius: imageRadius,
          onTap: () {},
          height: 106,
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Container(
            decoration: BoxDecoration(color: Pallets.white, border: Border.all(color: Pallets.borderGrey), borderRadius: BorderRadius.circular(36)),
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
            child: Row(
              children: [

                ImageWidget(
                  imageUrl: group.category!.postCategoryImage,
                  size: 20,
                ),
                4.horizontalSpace,
                TextView(text: group.category?.name,fontSize: 14,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
