import 'package:flutter/material.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/features/group/presentation/widgets/group_member_item.dart';

class GroupMembersTab extends StatefulWidget {
  const GroupMembersTab({super.key});

  @override
  State<GroupMembersTab> createState() => _GroupMembersTabState();
}

class _GroupMembersTabState extends State<GroupMembersTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          const TextView(
            text: "Administrator/Creator",
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: GroupMemberItem(),
            ),
          ))
        ],
      ),
    );
  }
}
