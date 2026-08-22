import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/empty_state.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/core/constants/dialog_texts.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/features/group/presentation/blocs/recent_groups_cubit/recent_groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/group/presentation/widgets/group_loading_shimmer.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';

/// `GET /user/recents/fetch?sort=group` (v2) — groups the user recently
/// viewed or interacted with.
class GroupRecentTab extends StatefulWidget {
  const GroupRecentTab({super.key, this.selectedCategory});

  final PostCategory? selectedCategory;

  @override
  State<GroupRecentTab> createState() => _GroupRecentTabState();
}

class _GroupRecentTabState extends State<GroupRecentTab>
    with AutomaticKeepAliveClientMixin {
  final cubit = RecentGroupsCubit(injector.get());

  @override
  void initState() {
    super.initState();
    cubit.getRecentGroups();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshGroupListener(
      onRefresh: () => cubit.getRecentGroups(),
      child: BlocBuilder<RecentGroupsCubit, RecentGroupsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.status == LoadStatus.loading && state.groups.isEmpty) {
            return const Center(child: GroupLoadingShimmer());
          }
          if (state.status == LoadStatus.error && state.groups.isEmpty) {
            return AppErrorWidget(onTap: () => cubit.getRecentGroups());
          }

          final allGroups = state.groups;
          final groups = widget.selectedCategory == null
              ? allGroups
              : allGroups
                  .where((group) =>
                      group.category?.id == widget.selectedCategory!.id)
                  .toList();

          if (groups.isEmpty) {
            return const EmptyState(
              title: "No recent groups",
              subtitle: "Groups you view or interact with will show up here.",
            );
          }

          return RefreshIndicator(
            onRefresh: () => cubit.getRecentGroups(),
            child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (group.isSuspended ?? false) {
                          CustomDialogs.error(
                              "You have been suspended from this group");
                        } else if (!group.isPublic &&
                            !(group.isFollowing ?? false)) {
                          CustomDialogs.showInfoMessage(
                              context, privateGroupViewText);
                        } else {
                          context.pushNamed(PageUrl.groupsInfoScreen,
                              extra: group.id.toString());
                        }
                      },
                      child: GroupResultItem(
                        group: group,
                        onJoinStateChanged: () => cubit.getRecentGroups(),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
