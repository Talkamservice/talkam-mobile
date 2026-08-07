import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

class TalkamTabBar extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool useExpandedAsParent;

  /// Logical width of the selected-tab underline. Pass `null` to make it hug
  /// the label instead, which keeps tabs of differing word lengths
  /// ("Profile" vs "Settings") looking balanced.
  final double? indicatorWidth;

  const TalkamTabBar({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    this.useExpandedAsParent = true,
    this.indicatorWidth = 60,
  });

  @override
  Widget build(BuildContext context) {
    final hugsLabel = indicatorWidth == null;

    final column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // The underline has no child, so it only has a width to stretch to when
      // the cross axis stretches. Without this it would collapse to zero.
      crossAxisAlignment:
          hugsLabel ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
      children: [
        TextView(
          text: title,
          color: isSelected ? Pallets.boldBlackV2 : Pallets.grey400,
          fontWeight: FontWeight.w600,
          align: hugsLabel ? TextAlign.center : TextAlign.left,
        ),
        10.verticalSpace,
        Container(
          height: 3.0,
          width: indicatorWidth?.w,
          decoration: BoxDecoration(
            color: isSelected ? Pallets.tabBarBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ],
    );

    return InkWell(
      onTap: onTap,
      // IntrinsicWidth sizes the column to the label so the stretched
      // underline ends up exactly as wide as the text.
      child: hugsLabel ? IntrinsicWidth(child: column) : column,
    );
  }
}
