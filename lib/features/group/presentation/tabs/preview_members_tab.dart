import 'package:flutter/material.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/group/presentation/tabs/group_members_tab.dart';

class PreviewGroupMembersTab extends StatefulWidget {
  const PreviewGroupMembersTab({super.key, required this.data});

  final GroupMembersTabData data;

  @override
  State<PreviewGroupMembersTab> createState() => _PreviewGroupMembersTabState();
}

final bloc = GroupMembersCubit(injector.get());

class _PreviewGroupMembersTabState extends State<PreviewGroupMembersTab> {
  @override
  initState() {
    super.initState;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GroupMembersList(
        data: widget.data,
      ),
    );
  }
}
