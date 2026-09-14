import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkam/common/widgets/animated_diff_list.dart';
import 'package:talkam/common/widgets/custom_dialogs.dart';
import 'package:talkam/common/widgets/error_widget.dart';
import 'package:talkam/common/widgets/text_view.dart';

import 'package:talkam/core/constants/package_exports.dart';
import 'package:talkam/core/di/injector.dart';
import 'package:talkam/core/navigation/route_url.dart';
import 'package:talkam/core/theme/pallets.dart';
import 'package:talkam/features/group/data/models/groups_filter_model.dart';
import 'package:talkam/features/group/presentation/blocs/featured_groups/featured_groups_cubit.dart';
import 'package:talkam/features/group/presentation/blocs/groups_cubit/groups_cubit.dart';
import 'package:talkam/features/group/presentation/screens/refresh_group_listener.dart';
import 'package:talkam/features/group/presentation/widgets/group_loading_shimmer.dart';
import 'package:talkam/features/group/presentation/widgets/suggested_groups.dart';
import 'package:talkam/features/post/data/models/get_categories_response.dart';
import 'package:talkam/features/search/data/models/get_group_response.dart';
import 'package:talkam/features/search/presentation/widget/group_result_item.dart';

class MyGroupsTab extends StatefulWidget {
  const MyGroupsTab({super.key, this.selectedCategory});

  final PostCategory? selectedCategory;

  @override
  State<MyGroupsTab> createState() => _GroupExploreRecentTabState();
}

class _GroupExploreRecentTabState extends State<MyGroupsTab>
    with AutomaticKeepAliveClientMixin {
  final bloc = GroupsCubit(injector.get());

  @override
  void initState() {
    bloc.getGroups(isJoined: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshGroupListener(
      onRefresh: (silent) {
        bloc.getGroups(shouldRefresh: !silent, isJoined: true);
      },
      child: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [];
              },
              body: BlocConsumer<GroupsCubit, GroupsState>(
                bloc: bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
                    children: [
                      BlocProvider<FeaturedGroupsCubit>.value(
                        value: injector.get<FeaturedGroupsCubit>(),
                        child: const SuggestedGroups(),
                      ),
                      16.verticalSpace,
                      state.maybeWhen(orElse: () {
                        return AppErrorWidget(
                          onTap: () {
                            bloc.getGroups(isJoined: true);
                          },
                        );
                      }, getGroupsLoading: () {
                        return const Expanded(
                          child: Center(
                            child: GroupLoadingShimmer(),
                          ),
                        );
                      }, getGroupsSuccess: (groups, paginationData) {
                        final allGroups = groups;
                        final displayGroups = widget.selectedCategory == null
                            ? allGroups
                            : allGroups
                                .where((group) =>
                                    group.category?.id ==
                                    widget.selectedCategory!.id)
                                .toList();

                        if (displayGroups.isEmpty) {
                          return const Expanded(
                            child: SizedBox(
                              height: 300,
                              child: Center(
                                child: TextView(
                                    text: "No groups in this category"),
                              ),
                            ),
                          );
                        }
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              // Broadcast instead of refetching directly —
                              // every group tab (this one included)
                              // already listens for this via
                              // RefreshGroupListener and refetches
                              // itself, so pulling to refresh here also
                              // refreshes Recent and Explore.
                              injector.get<GroupsCubit>().refreshGroups();
                            },
                            child: AnimatedDiffList<TalkamGroup>(
                              items: displayGroups,
                              keyOf: (group) => group.id!,
                              itemBuilder: (context, group, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Every group here is one the user
                                        // has actually joined, so there's no
                                        // "private, can't view" case to gate
                                        // on anymore — only suspension can
                                        // block access.
                                        if (group.isSuspended ?? false) {
                                          CustomDialogs.error(
                                              "You have been suspended from this group");
                                        } else {
                                          context.pushNamed(
                                              PageUrl.groupsInfoScreen,
                                              extra: group.id.toString());
                                        }
                                      },
                                      child: GroupResultItem(
                                        group: group,
                                        onJoinStateChanged: () {
                                          // Optimistic: drop it from this
                                          // list immediately so it animates
                                          // out, then reconcile every other
                                          // open group list in the
                                          // background.
                                          bloc.removeGroupLocally(group.id!);
                                          injector.get<GroupsCubit>().refreshAllGroupLists(silent: true);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool stateIsGetGroups(GroupsState previous, GroupsState current) {
    return current.maybeWhen(
      orElse: () => false,
      getGroupsLoading: () => true,
      getGroupsFailure: (error) => true,
      getGroupsSuccess: (__, _) => true,
    );
  }
}
