import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/custom_button.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

class AppPromptWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final String? retryText;
  final VoidCallback? onTap;
  final String? imagePath;
  final bool? isSvgResource;
  final bool? canTryAgain;
  final Color? textColor;
  final Color? retryTextColor;

  const AppPromptWidget({
    Key? key,
    this.message =
        'Ooops something went wrong ensure you have a good network and retry.',
    this.title,
    this.onTap,
    this.imagePath,
    this.isSvgResource = false,
    this.canTryAgain = true,
    this.retryText = 'Try again',
    this.textColor,
    this.retryTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (imagePath != null)
          Image.asset(
            imagePath ?? Assets.images.svgs.sorry,
            height: 150,
          ),
          if (title != null)
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor ??
                          Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          if (message != null)
            Column(
              children: [
                TextView(
                  text: message!,
                  align: TextAlign.center,
                  fontSize: 14,
                  style: TextStyle(
                      color: textColor ?? context.colorScheme.onSurface),
                ),
                // const SizedBox(
                //   height: 16,
                // ),
              ],
            ),
          if (canTryAgain!)
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  // text: retryText,
                  // expanded: false,

                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: const StadiumBorder(
                          side: BorderSide(color: Pallets.primary))),
                  onPressed: onTap ?? () {},
                  child: TextView(text: retryText ?? "Retry"),
                ),
              ],
            )
        ],
      )),
    );
  }
}
