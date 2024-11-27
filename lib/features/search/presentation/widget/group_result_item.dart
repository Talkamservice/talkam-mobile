import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/ads/presentation/widgets/ad_indicator.dart';
import 'package:talkam/features/group/presentation/widgets/join_group_button.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupResultItem extends StatelessWidget {
  const GroupResultItem({super.key, required this.group, required this.onJoinStateChanged});

  final TalkamGroup group;

  final Function() onJoinStateChanged;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  ImageWidget(width: 78, height: 54, fit: BoxFit.cover, borderRadius: BorderRadius.circular(2), imageUrl: group.image.toString()),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(



                          crossAxisAlignment: CrossAxisAlignment.start,



                          children: [
                            Container(
                              constraints:  const BoxConstraints(maxWidth:140),

                              child: TextView(
                                maxLines: 1,
                                text: group.name.toString(),
                                fontWeight: FontWeight.w700,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            2.horizontalSpace,

                            if (!group.isPublic)
                              ImageWidget(
                                imageUrl: Assets.images.svgs.keylock,
                                color: Pallets.grey400,
                                size: 16,
                              )
                          ],
                        ),
                        TextView(
                          text: formatMemberCount(group.totalMembers ?? 0),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  JoinGroupButton(
                    group: group,
                    onStateChanged: onJoinStateChanged,
                  )
                ],
              ),
              12.verticalSpace,
              if ( group.isPromoted) 16.verticalSpace,
              Padding(
                padding: EdgeInsets.only(top: 6.0.h),
                child: Container(height: 1, color: Pallets.borderGrey),
              ),


            ],

          ),
        ),
        if (group.isPromoted)
          Positioned(
              left: 0,
              bottom: 6,
              child: AdIndicator(
                promoter: "",
                padding: 4,
              )),
      ],
    );
  }
}

// class JoinGroupButton extends StatelessWidget {
//   const JoinGroupButton({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 16, vertical: 1),
//             shape: const StadiumBorder(),
//             backgroundColor: Pallets.primary,
//             foregroundColor: Pallets.white),
//         onPressed: () {},
//         child: const TextView(text: "Join"));
//   }
// }

formatMemberCount(totalMembers) {
  if (totalMembers >= 1000) {
    return '${(totalMembers / 1000).toFixed(1)}k';
  } else if (totalMembers <= 1) {
    return "${totalMembers.toString()} Member";
  } else {
    return "${totalMembers.toString()} Members";
  }
}
