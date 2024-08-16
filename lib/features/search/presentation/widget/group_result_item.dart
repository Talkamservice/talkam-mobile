import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/image_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupResultItem extends StatelessWidget {
  const GroupResultItem({super.key, required this.group});

  final TalkamGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              ImageWidget(
                  width: 78,
                  height: 54,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(2),
                  imageUrl: group.image.toString()),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: group.name.toString(),
                      fontWeight: FontWeight.w700,
                    ),
                    TextView(
                      text: formatMemberCount(group.totalMembers ?? 0),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 1),
                      shape: const StadiumBorder(),
                      backgroundColor: Pallets.primary,
                      foregroundColor: Pallets.white),
                  onPressed: () {},
                  child: const TextView(text: "Join"))
            ],
          ),
          12.verticalSpace,
          Padding(
            padding: EdgeInsets.only(top: 6.0.h),
            child: Container(height: 1, color: Pallets.borderGrey),
          ),
        ],
      ),
    );
  }


}

formatMemberCount(totalMembers) {
  if (totalMembers >= 1000) {
    return '${(totalMembers / 1000).toFixed(1)}k';
  } else if (totalMembers <= 1) {
    return "${totalMembers.toString()} Member";
  } else {
    return "${totalMembers.toString()} Members";
  }
}
