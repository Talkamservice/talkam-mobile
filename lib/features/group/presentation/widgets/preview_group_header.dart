import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

class PreviewGroupHeader extends StatefulWidget {
  const PreviewGroupHeader({super.key, required this.onSubmitted, this.banner});

  final Function() onSubmitted;
  final String? banner;

  @override
  State<PreviewGroupHeader> createState() => _PreviewGroupHeaderState();
}

class _PreviewGroupHeaderState extends State<PreviewGroupHeader> {
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
                    8.horizontalSpace,
                    const TextView(
                      text: "Preview Group",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    const Spacer(),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Pallets.white,
                            foregroundColor: context.colorScheme.onSurface,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          widget.onSubmitted();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                            ),
                            8.horizontalSpace,
                            const TextView(text: "Finish and Create")
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
