import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/gen/assets.gen.dart';

enum NotificationItemType { radio, switchType }

class NotificationSettingItem extends StatelessWidget {
  const NotificationSettingItem(
      {super.key,
      this.trailing,
      required this.notificationItemType,
      required this.tittle,
      required this.subtittle,
      required this.selected,
      required this.onTap});

  final Widget? trailing;
  final NotificationItemType notificationItemType;
  final String tittle;
  final String subtittle;
  final bool selected;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: tittle,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                if(subtittle.isNotEmpty)
                TextView(
                  text: subtittle,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          24.horizontalSpace,
          switch (notificationItemType) {
            NotificationItemType.radio => AnimatedCrossFade(
                firstChild: ImageWidget(imageUrl: Assets.images.svgs.radioActive),
                secondChild:
                    ImageWidget(imageUrl: Assets.images.svgs.radioInactive),
                crossFadeState: selected
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300)),
            NotificationItemType.switchType => CupertinoSwitch(
                activeColor: Pallets.primary,
                value: selected,
                onChanged: (value) {

                  onTap();
                },
              ),
          }
        ],
      ),
    );
  }
}
