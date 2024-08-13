import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupMemberItem extends StatelessWidget {
  const GroupMemberItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageWidget(imageUrl: Assets.images.svgs.member),
        10.horizontalSpace,
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "u/ougqd9uh0qess",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              TextView(
                text: "Member since Dec, 2022",
                fontSize: 12,
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: context.colorScheme.onSurface,
                )))
      ],
    );
  }
}
