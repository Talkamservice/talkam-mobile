import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupsRulesTab extends StatelessWidget {
  const GroupsRulesTab({super.key, required this.data});

  final TalkamGroup data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      itemCount: 4, // Mock rules
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "Rule ${index + 1}: Be Respectful",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              8.verticalSpace,
              TextView(
                text: "Please treat everyone with respect and kindness. No bullying, harassment, or hate speech will be tolerated.",
                fontSize: 14,
                color: Pallets.darkGrey,
              ),
              12.verticalSpace,
              Divider(color: Colors.grey.shade300),
            ],
          ),
        );
      },
    );
  }
}
