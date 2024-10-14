import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/features/group/presentation/tabs/group_rules_tab.dart';

class AboutGroupItem extends StatelessWidget {
  const AboutGroupItem({super.key, required this.icon, this.descriptionWidget, this.description, required this.tittle});

  final String icon;
  final Widget? descriptionWidget;
  final String? description;
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularBorder(padding: 4, child: ImageWidget(imageUrl: icon)),
        12.horizontalSpace,
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: tittle,
              fontWeight: FontWeight.w700,
            ),
            4.verticalSpace,
            descriptionWidget ??
                TextView(
                  text: description.toString(),
                  fontSize: 16,
                )
          ],
        ))
      ],
    );
  }
}
