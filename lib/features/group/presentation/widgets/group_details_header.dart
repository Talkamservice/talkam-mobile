import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/screens/group_details_screen.dart';
import 'package:talkam/features/post/data/models/post_test_models.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/gen/assets.gen.dart';

import 'group_overview_section.dart';

class GroupDetailsHeader extends StatefulWidget {
  const GroupDetailsHeader({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<GroupDetailsHeader> createState() => _GroupDetailsHeaderState();
}

class _GroupDetailsHeaderState extends State<GroupDetailsHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextButton(
                  style: outlinedButtonStyle(),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageWidget(imageUrl: widget.group.category?.iconImage),
                      10.horizontalSpace,
                      TextView(
                        text: widget.group.category?.name,
                        fontSize: 14,
                        color: context.colorScheme.onSurface,

                        // fontWeight: FontWeight.w600,
                      ),
                    ],
                  )),
              const Spacer(),

              if(widget.group.isAdmin)
              TextButton(
                  style: outlinedButtonStyle(),
                  onPressed: () {




                    context.pushNamed(PageUrl.createGroupScreen,
                        extra: widget.group);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.icPersonEdit),
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
          12.verticalSpace,
          GroupOverViewSection(
            showAbout: false,
            data: widget.group,
            onPromoted: () {

            },
          )
        ],
      ),
    );
  }
}
