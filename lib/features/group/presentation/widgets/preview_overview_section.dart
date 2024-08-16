import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/gen/assets.gen.dart';

class PreviewGroupOverViewSection extends StatelessWidget {
  const PreviewGroupOverViewSection(
      {super.key,
        this.showAbout = true,
        required this.data,
        this.onAboutCLicked});

  final VoidCallback? onAboutCLicked;

  final GroupOverViewData data;

  final bool? showAbout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            ImageWidget(
              imageUrl: data.category.iconImage??"",

              size: 40,
              fit: BoxFit.cover,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: data.category.name,
                    fontSize: 16,
                  ),
                  // 2.verticalSpace,
                  TextView(
                    text: formatFollowersCount(data.totalMembers),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            if (showAbout!)
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Pallets.borderGrey.withOpacity(0.2),
                      shape: const StadiumBorder(
                          side: BorderSide(color: Pallets.borderGrey)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10)),
                  onPressed: () {
                    if (onAboutCLicked != null) {
                      onAboutCLicked!();
                    }

                    // CustomDialogs.showBottomSheet(context, const RulesSheet());
                  },
                  child: Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.infoCircle),
                      10.horizontalSpace,
                      const TextView(
                        text: "About",
                        fontSize: 14,
                        // color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ))
          ],
        ),
        13.verticalSpace,
        TextView(
          text: data.about,
        )
      ],
    );
  }
}

formatFollowersCount(totalMembers) {
  if (totalMembers >= 1000) {
    return '${(totalMembers / 1000).toFixed(1)}k';
  } else if (totalMembers <= 1) {
    return "${totalMembers.toString()} Follower";
  } else {
    return "${totalMembers.toString()} Followers";
  }
}
