import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/screens/group_details_screen.dart';
import 'package:talkam/features/group/presentation/screens/group_info_screen.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupDetailsHeader extends StatefulWidget {
  const GroupDetailsHeader({super.key});

  @override
  State<GroupDetailsHeader> createState() => _GroupDetailsHeaderState();
}

class _GroupDetailsHeaderState extends State<GroupDetailsHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                  style: outlinedButtonStyle(),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageWidget(imageUrl: Assets.images.png.sports.path),
                      10.horizontalSpace,
                      TextView(
                        text: "Dating & Relationship",
                        fontSize: 14,
                        color: context.colorScheme.onSurface,

                        // fontWeight: FontWeight.w600,
                      ),
                    ],
                  )),
              const Spacer(),
              TextButton(
                  style: outlinedButtonStyle(),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.icPersonEdit),
                      10.horizontalSpace,
                      TextView(
                        text: "Edit",
                        fontSize: 14,
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )),
            ],
          ),
          12.verticalSpace,
          const GroupOverViewSection(
            showAbout: false,
          )
        ],
      ),
    );
  }
}
