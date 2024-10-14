import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/services/network/url_config.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/helper_utils.dart';
import 'package:talkam/features/group/presentation/widgets/join_group_button.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupInfoAppBar extends StatelessWidget {
  const GroupInfoAppBar(
      {super.key, required this.group, required this.onStateChanged});

  final TalkamGroup group;
  final VoidCallback onStateChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
          imageUrl: group.image!,
          width: 1.sw,
          onTap: () {},
          height: 150,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              40.verticalSpace,
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child:
                          ImageWidget(imageUrl: Assets.images.svgs.arrowLeft)),
                  const Spacer(),
                  JoinGroupButton(
                    group: group,
                    onStateChanged: onStateChanged,
                  ),
                  24.horizontalSpace,
                  InkWell(
                    onTap: () {
                      Helpers.share("${UrlConfig.webUrl}group/${group.id}");
                    },
                    child: ImageWidget(
                      imageUrl: Assets.images.svgs.share,
                      color: Pallets.white,
                      onTap: () {
                        Helpers.share("${UrlConfig.webUrl}group/${group.id}");
                      },
                    ),
                  ),
                  24.horizontalSpace,
                  // IconButton(
                  //     style:
                  //         IconButton.styleFrom(foregroundColor: Pallets.white),
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.more_vert_rounded,
                  //       color: Pallets.white,
                  //     ))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _JoinGroupButton extends StatefulWidget {
  const _JoinGroupButton({super.key});

  @override
  State<_JoinGroupButton> createState() => _JoinGroupButtonState();
}

class _JoinGroupButtonState extends State<_JoinGroupButton> {
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
