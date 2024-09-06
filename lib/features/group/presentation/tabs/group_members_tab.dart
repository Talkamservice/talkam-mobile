import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/features/group/data/models/get_group_members_response.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/group/presentation/widgets/group_member_item.dart';
import 'package:talkam/features/group/presentation/widgets/pending_requests_button.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupMembersTab extends StatefulWidget {
  const GroupMembersTab({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<GroupMembersTab> createState() => _GroupMembersTabState();
}

final bloc = GroupMembersCubit(injector.get());

class _GroupMembersTabState extends State<GroupMembersTab> {
  @override
  initState() {
    bloc.getGroupMembers(widget.group.id.toString());
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
              if (response.data.member.isEmpty &&
                  response.data.owner.isEmpty &&
                  response.data.admin.isEmpty) {
                return const SizedBox(
                    height: 300,

                    child: Center(
                        child: TextView(text: "No members in this group")));
              }
              return GroupMembersList(
                reponse: response,
                group: widget.group,
                onActionSuccess: () {
                  bloc.getGroupMembers(widget.group.id.toString());
                },
              );
            },
            getGroupMembersFailure: (error) {
              return AppErrorWidget(
                onTap: () {
                  bloc.getGroupMembers(widget.group.id.toString());
                },
              );
            },
          );
        },
      ),
    );
  }

// List<TalkamGroupMemberInfo> getOwner(GetGroupMembersResponse response) {
//   return response.data.owner
//       .map(
//         (e) => e.toTalkamGroupMemberInfo(),
//       )
//       .toList();
// }
}

class GroupMembersList extends StatelessWidget {
  const GroupMembersList({
    super.key,
    required this.reponse,
    required this.group,
    required this.onActionSuccess,
  });

  final GetGroupMembersResponse reponse;
  final TalkamGroup group;
  final VoidCallback onActionSuccess;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GroupMembersComponent(
          members: reponse.data.admin,
          tittle: "Administrator/Creator",
          group: group,
          showPendingRequest: reponse.data.admin.isNotEmpty,
          onActionSuccess: onActionSuccess,
        ),
        GroupMembersComponent(
          members: reponse.data.owner,
          tittle: "Owner",
          group: group,
          showPendingRequest: reponse.data.admin.isEmpty,
          onActionSuccess: onActionSuccess,
        ),
        GroupMembersComponent(
          members: reponse.data.member,
          tittle: "All Members",
          group: group,

          onActionSuccess: onActionSuccess,
        ),
      ],
    );
  }
}

class GroupMembersComponent extends StatefulWidget {
  const GroupMembersComponent(
      {super.key,
      required this.members,
      required this.tittle,
      this.showPendingRequest = false,
      required this.group,
      required this.onActionSuccess});

  final List<GroupMemberDetails> members;
  final String tittle;
  final bool showPendingRequest;
  final TalkamGroup group;
  final VoidCallback onActionSuccess;

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
          Row(
            children: [
              TextView(
                text: widget.tittle,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              if (canViewRequests)
                PendingRequestsButton(
                  group: widget.group,
                )
            ],
          ),
          10.verticalSpace,
          ...List.generate(
            widget.members.length,
            (index) => GroupMemberItem(
              member: widget.members[index],
              group: widget.group,
              onActionSuccess: widget.onActionSuccess,
            ),
          ),
        ],
      );
    }
    return 0.verticalSpace;
  }

  bool get canViewRequests {
    return widget.showPendingRequest &&
        (widget.group.userRole == "Owner" || widget.group.userRole == "Admin");
  }
}
