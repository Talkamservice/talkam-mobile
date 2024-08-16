import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/dormain/model/group_overview_data.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/group/presentation/widgets/group_member_item.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupMembersTab extends StatefulWidget {
  const GroupMembersTab({super.key, required this.data});

  final TalkamGroup data;

  @override
  State<GroupMembersTab> createState() => _GroupMembersTabState();
}

final bloc = GroupMembersCubit(injector.get());

class _GroupMembersTabState extends State<GroupMembersTab> {
  @override
  initState() {
    bloc.getGroupMembers(widget.data.id.toString());
    super.initState;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocConsumer<GroupMembersCubit, GroupMembersState>(
        bloc: bloc,
        listener: (context, state) {},
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => 0.verticalSpace,
            getGroupMembersLoading: () => SizedBox(
              height: 200,
              child: Center(
                child: CustomDialogs.getLoading(size: 50),
              ),
            ),
            getGroupMembersSuccess: (response) {
              return GroupMembersList(
                data: GroupMembersTabData(
                    admin: response.data.admin
                        .map(
                          (e) => e.toTalkamGroupMemberInfo(),
                        )
                        .toList(),
                    members: response.data.member
                        .map(
                          (e) => e.toTalkamGroupMemberInfo(),
                        )
                        .toList(),
                    owner: response.data.owner
                        .map(
                          (e) => e.toTalkamGroupMemberInfo(),
                        )
                        .toList(),
                    groupId: widget.data.id.toString(),
                    iPreview: false),
              );
            },
            getGroupMembersFailure: (error) {
              return AppErrorWidget(
                onTap: () {
                  bloc.getGroupMembers(widget.data.id.toString());
                },
              );
            },
          );
        },
      ),
    );
  }
}

class GroupMembersList extends StatelessWidget {
  const GroupMembersList({
    super.key,
    required this.data,
  });

  final GroupMembersTabData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GroupMembersComponent(
            members: data.admin, tittle: "Administrator/Creator"),
        GroupMembersComponent(members: data.owner, tittle: "Owner"),
        GroupMembersComponent(members: data.members, tittle: "All Members"),
      ],
    );
  }
}

class GroupMembersComponent extends StatefulWidget {
  const GroupMembersComponent(
      {super.key, required this.members, required this.tittle});

  final List<TalkamGroupMemberInfo> members;
  final String tittle;

  @override
  State<GroupMembersComponent> createState() => _GroupMembersComponentState();
}

class _GroupMembersComponentState extends State<GroupMembersComponent> {
  @override
  Widget build(BuildContext context) {
    if (widget.members.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          TextView(
            text: widget.tittle,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          10.verticalSpace,
          ...List.generate(
            widget.members.length,
            (index) => GroupMemberItem(
              member: widget.members[index],
            ),
          ),
        ],
      );
    }
    return 0.verticalSpace;
  }
}
