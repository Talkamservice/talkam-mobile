import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

class CreateGroupHeader extends StatefulWidget {
  const CreateGroupHeader(
      {super.key, required this.onBannerUpdated, this.banner});

  final Function(String bannerImage) onBannerUpdated;
  final String? banner;

  @override
  State<CreateGroupHeader> createState() => _CreateGroupHeaderState();
}

class _CreateGroupHeaderState extends State<CreateGroupHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(
        children: [
          ImageWidget(
            height: 130,
            width: 1.sw,
            imageUrl: widget.banner ?? Assets.images.jpegs.football.path,
          ),
          Column(
            children: [
              40.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
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
                            foregroundColor: context.colorScheme.onSurface,
                            shape: const StadiumBorder()),
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                            ),
                            8.horizontalSpace,
                            const TextView(text: "Add banner")
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
