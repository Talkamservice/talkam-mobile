import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupInfoAppBar extends StatelessWidget {
  const GroupInfoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
          imageUrl: Assets.images.jpegs.football.path,
          width: 1.sw,
          onTap: () {},
          height: 150,
        ),
        Column(
          children: [
            40.verticalSpace,
            Row(
              children: [
                InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: ImageWidget(imageUrl: Assets.images.svgs.arrowLeft)),
                const Spacer(),
                const JoinGroupButton(),
                24.horizontalSpace,
                ImageWidget(
                  imageUrl: Assets.images.svgs.share,
                  color: Pallets.white,
                ),
                24.horizontalSpace,
                IconButton(
                    style: IconButton.styleFrom(foregroundColor: Pallets.white),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Pallets.white,
                    ))
              ],
            )
          ],
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
        onPressed: () {
          // var userInterests =
          //     injector.get<ProfileBloc>().appUser!.interests;
          // bloc.add(UpdateInterestEvent(widget.category.id.toString()));
        },
        child: Builder(builder: (context) {
          // if (state is UpdateInterestLoadingState) {
          //   return const SizedBox(
          //     height: 20,
          //     width: 20,
          //     child: CircularProgressIndicator(
          //       color: Pallets.white,
          //     ),
          //   );
          // }

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
