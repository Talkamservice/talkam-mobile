import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/group/presentation/screens/group_details_screen.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

class GroupRulesTab extends StatefulWidget {
  const GroupRulesTab({super.key, this.isPreview = false, required this.data});

  final bool? isPreview;
  final TalkamGroup data;

  @override
  State<GroupRulesTab> createState() => _GroupRulesTabState();
}

class _GroupRulesTabState extends State<GroupRulesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Row(
              children: [
                CircularBorder(
                    child: ImageWidget(
                      imageUrl: Assets.images.svgs.rules,
                      color: context.colorScheme.onSurface,
                    )),
                8.horizontalSpace,
                const Expanded(
                  child: TextView(
                    text: "Group Rules",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // if (!widget.isPreview!)

                if (false)
                  TextButton(
                      style: outlinedButtonStyle(),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageWidget(
                              imageUrl: Assets.images.svgs.icPersonEdit),
                          10.horizontalSpace,
                          TextView(
                            text: "Edit",
                            fontSize: 14,
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      )),
              ],
            ),
            14.verticalSpace,
            const TextView(
              text: groupRuleIntro,
            ),
            16.verticalSpace,
            TextView(text: widget.data.description.toString()),
            18.verticalSpace,
            ...List.generate(
                widget.data.guidelines!.length,
                    (index) => GroupRuleItem(
                  index: index + 1,
                  guidline: widget.data.guidelines![index],
                )),
          ],
        ),
      ),
    );
  }
}

class CircularBorder extends StatelessWidget {
  const CircularBorder({super.key, required this.child, this.padding = 8});

  final Widget child;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Pallets.grey75), shape: BoxShape.circle),
      child: child,
    );
  }
}

class GroupRuleItem extends StatelessWidget {
  const GroupRuleItem({super.key, required this.index, required this.guidline});

  final GroupGuideline guidline;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularBorder(padding: 4, child: TextView(text: index.toString())),
        12.horizontalSpace,
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: guidline.title.toString(),
                  fontWeight: FontWeight.w700,
                ),
                4.verticalSpace,
                TextView(text: guidline.description.toString())
              ],
            ))
      ],
    );
  }
}
