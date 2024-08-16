import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupInfoAppBar extends StatelessWidget {
  const GroupInfoAppBar({super.key, required this.data});

  final GroupAppBarData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
          imageUrl: data.banner,
          width: 1.sw,
          onTap: () {},
          height: 150,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              40.verticalSpace,
              if (data.isPreview)
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: ImageWidget(
                            imageUrl: Assets.images.svgs.arrowLeft)),
                    const Spacer(),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Pallets.white,
                            shape: const StadiumBorder()),
                        onPressed: () {},
                        child: Row(
                          children: [
                            const TextView(
                              text: "Finish and Create",
                              color: Pallets.black,
                            ),
                            5.horizontalSpace,
                            const Icon(
                              Icons.add,
                              color: Pallets.black,
                            )
                          ],
                        ))
                  ],
                ),
              if (!data.isPreview)
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: ImageWidget(
                            imageUrl: Assets.images.svgs.arrowLeft)),
                    const Spacer(),
                    const JoinGroupButton(),
                    24.horizontalSpace,
                    ImageWidget(
                      imageUrl: Assets.images.svgs.share,
                      color: Pallets.white,
                    ),
                    24.horizontalSpace,
                    IconButton(
                        style: IconButton.styleFrom(
                            foregroundColor: Pallets.white),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert_rounded,
                          color: Pallets.white,
                        ))
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class JoinGroupButton extends StatefulWidget {
  const JoinGroupButton({super.key});

  @override
  State<JoinGroupButton> createState() => _JoinGroupButtonState();
}

class _JoinGroupButtonState extends State<JoinGroupButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Pallets.primary,
            foregroundColor: Pallets.white,
            shape: const StadiumBorder()),
        onPressed: () {},
        child: Builder(builder: (context) {
          return Row(
            children: [
              // if (!widget.category.isFollowing)
              const Icon(
                Icons.add,
                color: Pallets.white,
              ),
              5.horizontalSpace,
              // TextView(
              //     text:
              //     widget.category.isFollowing ? "Unfollow" : "Follow"),
              const TextView(text: "Join"),
            ],
          );
          // CustomDialogs.success("");
        }));
  }
}
