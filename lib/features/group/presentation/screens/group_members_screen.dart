import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_appbar.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/core/utils/extensions/context_extension.dart';
import 'package:talkam/features/group/presentation/blocs/group_members_cubit/group_members_cubit.dart';
import 'package:talkam/features/group/presentation/widgets/group_member_item.dart';
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
    return DefaultTabController(
      length: 4,
      initialIndex: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          tittleText: widget.group.name ?? "Group Members",
          titleAlign: TextAlign.left,
          centerTile: false,
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
              labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: "Verified Followers"),
                Tab(text: "Subscribed"),
                Tab(text: "Following"),
                Tab(text: "Followers"),
              ],
            ),
            Expanded(
              child: BlocConsumer<GroupMembersCubit, GroupMembersState>(
                bloc: bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    getGroupMembersLoading: () => Center(child: CustomDialogs.getLoading(size: 40)),
                    getGroupMembersSuccess: (response) {
                      // We only have owner, admin, member from API
                      // Let's combine them for the tabs to have some visual mock data
                      final allMembers = [
                        ...response.data.owner,
                        ...response.data.admin,
                        ...response.data.member
                      ];
                      
                      final emptyList = const Center(child: TextView(text: "No members found"));
                      
                      return TabBarView(
                        children: [
                          allMembers.isEmpty ? emptyList : ListView.builder(
                            itemCount: allMembers.length,
                            itemBuilder: (context, index) {
                              return GroupMemberItem(
                                member: allMembers[index],
                                group: widget.group,
                                onActionSuccess: () => bloc.getGroupMembers(widget.group.id.toString()),
                              );
                            },
                          ),
                          allMembers.isEmpty ? emptyList : ListView.builder(
                            itemCount: allMembers.length,
                            itemBuilder: (context, index) {
                              return GroupMemberItem(
                                member: allMembers[index],
                                group: widget.group,
                                onActionSuccess: () => bloc.getGroupMembers(widget.group.id.toString()),
                              );
                            },
                          ),
                          allMembers.isEmpty ? emptyList : ListView.builder(
                            itemCount: allMembers.length,
                            itemBuilder: (context, index) {
                              return GroupMemberItem(
                                member: allMembers[index],
                                group: widget.group,
                                isFollowing: true, // Visual mock for "Following" tab
                                onActionSuccess: () => bloc.getGroupMembers(widget.group.id.toString()),
                              );
                            },
                          ),
                          allMembers.isEmpty ? emptyList : ListView.builder(
                            itemCount: allMembers.length,
                            itemBuilder: (context, index) {
                              return GroupMemberItem(
                                member: allMembers[index],
                                group: widget.group,
                                onActionSuccess: () => bloc.getGroupMembers(widget.group.id.toString()),
                              );
                            },
                          ),
                        ],
                      );
                    },
                    getGroupMembersFailure: (error) => AppErrorWidget(
                      onTap: () => bloc.getGroupMembers(widget.group.id.toString()),
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
