import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';

class TalkamTabBar extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool useExpandedAsParent;

  const TalkamTabBar({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    this.useExpandedAsParent = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextView(
            text: title,
            color: isSelected ? Pallets.boldBlackV2 : Pallets.grey400,
            fontWeight: FontWeight.w600,
          ),
          10.verticalSpace,

          Container(
            height: 3.0,
            width: 60.w,
            decoration: BoxDecoration(
              color: isSelected ? Pallets.tabBarBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ],
      ),
    );
  }
}
