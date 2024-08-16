import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/_core.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/group/presentation/widgets/about_group_item.dart';
import 'package:talkam/gen/assets.gen.dart';



class PreviewGroupsAboutTab extends StatefulWidget {
  const PreviewGroupsAboutTab({super.key, required this.data});

  final GroupAboutData data;

  @override
  State<PreviewGroupsAboutTab> createState() => _PreviewGroupsAboutTabState();
}

class _PreviewGroupsAboutTabState extends State<PreviewGroupsAboutTab> {
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
            TextView(text: widget.data.about),
            18.verticalSpace,
            AboutGroupItem(
              icon: Assets.images.svgs.calender,
              tittle: "Inception",
              descriptionWidget: RichText(
                  text: TextSpan(
                      style: GoogleFonts.nunito(
                          color: context.colorScheme.onSurface),
                      children: [
                        TextSpan(

                            text:
                            "The group was created on the ${TimeUtil.formatDate(widget.data.createdAt.toString())} by "),
                        TextSpan(
                            text: widget.data.creator.username,
                            style: const TextStyle(
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


