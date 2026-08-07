import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/section_label.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

/// A labelled group of [SettingsTile]s inside a single rounded surface, as used
/// by the user profile and therapist profile settings tabs.
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.tiles,
  });

  final String title;
  final List<SettingsTile> tiles;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.r);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(title),
        12.verticalSpace,
        // Clipped so the first and last tile's ink ripple stays inside the
        // rounded surface on both platforms.
        ClipRRect(
          borderRadius: radius,
          child: Material(
            color: Pallets.bgLight.withValues(alpha: 0.5),
            child: Column(children: tiles),
          ),
        ),
      ],
    );
  }
}

/// One tappable row: circular icon, title, optional subtitle, optional chevron.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.iconBackground = Pallets.iconSurface,
    this.titleColor,
    this.showChevron = true,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final String? subtitle;
  final Color iconBackground;
  final Color? titleColor;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              child: ImageWidget(
                imageUrl: iconPath,
                size: 22.w,
              ),
            ),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: title,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: titleColor ?? Pallets.boldBlackV2,
                  ),
                  if (subtitle != null) ...[
                    4.verticalSpace,
                    TextView(
                      text: subtitle!,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Pallets.grey400,
                    ),
                  ],
                ],
              ),
            ),
            if (showChevron)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.w,
                color: Pallets.grey400,
              ),
          ],
        ),
      ),
    );
  }
}
