import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupActionSheet extends StatefulWidget {
  const GroupActionSheet({
    super.key,
    required this.group,
  });

  final TalkamGroup group;

  @override
  State<GroupActionSheet> createState() => _GroupActionSheetState();
}

class _GroupActionSheetState extends State<GroupActionSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(
            imagePath: Assets.images.svgs.flag02,
            tittle: "Report Group",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem(
      {super.key,
      required this.imagePath,
      required this.tittle,
      required this.onTap});

  final String imagePath;
  final String tittle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: Row(
              children: [
                ImageWidget(imageUrl: imagePath),
                18.horizontalSpace,
                TextView(
                  text: tittle,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          ),
          const Divider(
              // thickness: 1,
              )
        ],
      ),
    );
  }
}
