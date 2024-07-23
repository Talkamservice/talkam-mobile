import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class ProfileCommentTile extends StatelessWidget {
  const ProfileCommentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(
              imageUrl: Assets.images.png.woman.path,
              size: 36,
            ),
            12.horizontalSpace,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextView(
                        text: "daphne322",
                        fontSize: 14.sp,
                        color: Pallets.boldBlackV2,
                        fontWeight: FontWeight.w700,
                      ),
                      14.horizontalSpace,
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFF96C40), width: 1.33),
                        ),
                      ),
                      14.horizontalSpace,
                      TextView(
                        text: "13hrs",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Pallets.primary400,
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  TextView(
                    text:
                        "I have been building PCs for 25 years. I have the latest tech in my gaming rig, but I also have a PC with Pentium 4 and Windows XP with service pack 3. It plays my music and videos just as well as any PC today.",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Pallets.boldBlackV2,
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
