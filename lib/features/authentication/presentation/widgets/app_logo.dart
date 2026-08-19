import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkam/gen/assets.gen.dart';

/// Static TalkAM logo — icon beside the "talkAM" / "TECH SERVICES" wordmark.
///
/// Layout mirrors the brand logo:
///   [icon]  [talkAM text      ]
///           [TECH SERVICES text]
class AppLogoWidget extends StatelessWidget {
  /// Height of the icon SVG. Text SVGs are given a matching fixed width.
  final double iconHeight;

  const AppLogoWidget({
    super.key,
    this.iconHeight = 64,
  });

  @override
  Widget build(BuildContext context) {
    final double iconH = iconHeight;

    // Both text SVGs share the same width so they align perfectly. The SVGs
    // scale with BoxFit.contain, so each keeps its own aspect ratio.
    final double textWidth = iconH * 1.7;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.images.svgs.appIcon,
          height: iconH,
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.images.svgs.appIconTalkamText,
              width: textWidth,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 3),
            SvgPicture.asset(
              Assets.images.svgs.appIconTechServiceText,
              width: textWidth,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ],
    );
  }
}
