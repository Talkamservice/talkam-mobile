import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/group/presentation/widgets/group_member_item.dart';
import 'package:talkam/features/group/presentation/widgets/pending_requests_button.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';

class GroupMembersScreen extends StatefulWidget {
  const GroupMembersScreen({super.key, required this.group});

  final TalkamGroup group;

  @override
  State<GroupMembersScreen> createState() => _GroupMembersScreenState();
}

class _GroupMembersScreenState extends State<GroupMembersScreen> {
  final bloc = GroupMembersCubit(injector.get());

  @override
  void initState() {
    super.initState();
    bloc.getGroupMembers(widget.group.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    bool canViewRequests = widget.group.isAdmin;

    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          tittleText: widget.group.name ?? "Group Members",
          titleAlign: TextAlign.left,
          centerTile: false,
          actions: [
            if (canViewRequests)
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Center(
                  child: PendingRequestsButton(group: widget.group),
                ),
              ),
          ],
        ),
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: Pallets.blueBubbleColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              labelColor: context.colorScheme.onSurface,
              unselectedLabelColor: Pallets.darkGrey,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: "Administrators"),
                Tab(text: "Moderators"),
                Tab(text: "All Members"),
              ],
            ),
            Expanded(
              child: BlocConsumer<GroupMembersCubit, GroupMembersState>(
                bloc: bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    getGroupMembersLoading: () =>
                        Center(child: CustomDialogs.getLoading(size: 40)),
                    getGroupMembersSuccess: (response) {
                      final owners = response.data.owner;
                      final admins = response.data.admin;
                      final members = response.data.member;
                      final administrators = [...owners, ...admins];

                      return TabBarView(
                        children: [
                          // Tab 1: Administrators
                          administrators.isEmpty
                              ? const Center(
                                  child:
                                      TextView(text: "No administrators found"))
                              : RefreshIndicator(
                                  onRefresh: () => bloc.getGroupMembers(
                                      widget.group.id.toString()),
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: administrators.length,
                                    itemBuilder: (context, index) {
                                      return GroupMemberItem(
                                        member: administrators[index],
                                        group: widget.group,
                                        currentUserIsAdmin:
                                            widget.group.isAdmin,
                                        onActionSuccess: () =>
                                            bloc.getGroupMembers(
                                                widget.group.id.toString()),
                                      );
                                    },
                                  ),
                                ),
                          // Tab 2: Moderators
                          admins.isEmpty
                              ? const Center(
                                  child: TextView(text: "No moderators found"))
                              : RefreshIndicator(
                                  onRefresh: () => bloc.getGroupMembers(
                                      widget.group.id.toString()),
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: admins.length,
                                    itemBuilder: (context, index) {
                                      return GroupMemberItem(
                                        member: admins[index],
                                        group: widget.group,
                                        currentUserIsAdmin:
                                            widget.group.isAdmin,
                                        onActionSuccess: () =>
                                            bloc.getGroupMembers(
                                                widget.group.id.toString()),
                                      );
                                    },
                                  ),
                                ),
                          // Tab 3: All Members
                          members.isEmpty
                              ? const Center(
                                  child: TextView(text: "No members found"))
                              : RefreshIndicator(
                                  onRefresh: () => bloc.getGroupMembers(
                                      widget.group.id.toString()),
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: members.length,
                                    itemBuilder: (context, index) {
                                      return GroupMemberItem(
                                        member: members[index],
                                        group: widget.group,
                                        currentUserIsAdmin:
                                            widget.group.isAdmin,
                                        onActionSuccess: () =>
                                            bloc.getGroupMembers(
                                                widget.group.id.toString()),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      );
                    },
                    getGroupMembersFailure: (error) => AppErrorWidget(
                      onTap: () =>
                          bloc.getGroupMembers(widget.group.id.toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
