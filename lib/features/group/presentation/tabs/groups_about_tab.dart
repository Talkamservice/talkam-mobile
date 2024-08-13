import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/gen/assets.gen.dart';

import 'group_rules_tab.dart';

class GroupsAboutTab extends StatefulWidget {
  const GroupsAboutTab({super.key});

  @override
  State<GroupsAboutTab> createState() => _GroupsAboutTabState();
}

class _GroupsAboutTabState extends State<GroupsAboutTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            14.verticalSpace,
            const TextView(
              text: groupRuleIntro,
            ),
            16.verticalSpace,
            const TextView(
                text: "This is a group for dating and relationship advice."),
            18.verticalSpace,
            AboutGroupItem(
              icon: Assets.images.svgs.calender,
              tittle: "Inception",
              descriptionWidget: RichText(
                  text: TextSpan(
                      style: GoogleFonts.nunito(
                          color: context.colorScheme.onSurface),
                      children: const [
                    TextSpan(
                        text: "The group was created on the 13th Jan, 2024 by"),
                    TextSpan(
                        text: " u/ougqd9uh0qess",
                        style: TextStyle(
                            color: Pallets.primary,
                            fontWeight: FontWeight.w700)),
                  ])),
            ),
            16.verticalSpace,
            AboutGroupItem(
              icon: Assets.images.svgs.keylock,
              tittle: "Discoverability",
              description:
                  "The group is publicly open to everyone. Members can join without approval",
            ),
            16.verticalSpace,
            AboutGroupItem(
              icon: Assets.images.svgs.add,
              tittle: "Posts",
              description:
                  "Only members who have joined can post to this group.",
            ),
            16.verticalSpace
          ],
        ),
      ),
    );
  }
}

class AboutGroupItem extends StatelessWidget {
  const AboutGroupItem(
      {super.key,
      required this.icon,
      this.descriptionWidget,
      this.description,
      required this.tittle});

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
            descriptionWidget ?? const TextView(text: groupRuleIntro)
          ],
        ))
      ],
    );
  }
}
